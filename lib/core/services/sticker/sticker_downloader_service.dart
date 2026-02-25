import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async_queue/async_queue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_http_data_source.dart';
import 'package:uchat/features/sticker/domain/abstracts/sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/features/sticker/domain/events/sticker_item_download_complete_event.dart';
import 'package:uchat/features/sticker/domain/events/sticker_pack_download_status_event.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

/// Simple semaphore implementation for controlling concurrency
class _Semaphore {
  final int maxCount;
  int _currentCount = 0;
  final List<Function()> _waitQueue = [];

  _Semaphore(this.maxCount);

  Future<void> acquire() async {
    if (_currentCount < maxCount) {
      _currentCount++;
      return;
    }

    final completer = Completer<void>();
    _waitQueue.add(() => completer.complete());
    return completer.future;
  }

  void release() {
    _currentCount--;
    if (_waitQueue.isNotEmpty) {
      final next = _waitQueue.removeAt(0);
      _currentCount++;
      next();
    }
  }
}

/// Cache entry for pack download status
class _PackDownloadCacheEntry {
  final bool isDownloaded;
  final DateTime timestamp;

  _PackDownloadCacheEntry(this.isDownloaded) : timestamp = DateTime.now();
}

class StickerDownloaderService {
  // Performance optimization constants
  static const int _maxConcurrentDownloads = 5;
  static const Duration _progressUpdateInterval = Duration(milliseconds: 500);
  static const int _maxRetries = 3;

  final StickerHttpDataSource stickerHttpDataSource;

  String? stickerUserCachePath;
  String? stickerTempCachePath;

  StickerDownloaderService({required this.stickerHttpDataSource});

  String _currentDownloadingPackId = '';
  final stickerPackDownloadQueue = AsyncQueue.autoStart(allowDuplicate: false);

  // Performance optimization fields
  final Map<String, _PackDownloadCacheEntry> _packDownloadCache = {};
  DateTime? _lastProgressUpdate;

  // ✅ Replace individual AsyncQueues with shared semaphore for parallel processing
  final Map<String, _Semaphore> _stickerItemSemaphoreMap = {};
  static const int _maxConcurrentItemDownloads = 5;

  /// A map to keep track of sticker packs that are currently being downloaded or queued for download.
  ///
  /// This is used to prevent multiple downloads of the same sticker pack at the same time,
  /// and check if a sticker pack is already in the download queue.
  ///
  /// The key is the sticker pack ID, and the value is the download progress from 0.0 to 1.0
  /// {stickerPackId: progress[0.0]}
  final Map<String, double> stickerInQueueDownloadProgress = {};

  final Map<String, StickerDownloadStatus> stickerInQueueDownloadStatus = {};

  String get currentDownloadingPackId => _currentDownloadingPackId;

  Future<void> initializeDirectory({required String userId}) async {
    try {
      if (userId.isEmpty) {
        return;
      }
      // Get the application document directory and create a subdirectory for stickers
      final tempDir = await getTemporaryDirectory();
      Directory stickerTempDir = Directory('${tempDir.path}/stickers');
      await stickerTempDir.create(recursive: true);
      stickerTempCachePath = stickerTempDir.path;

      final docDir = await getApplicationDocumentsDirectory();
      Directory stickerUserDir = Directory('${docDir.path}/stickers/$userId');
      stickerUserDir = await stickerUserDir.create(recursive: true);
      stickerUserCachePath = stickerUserDir.path;
    } catch (e, stackTrace) {
      _log.e('Cannot create sticker directory', e, stackTrace);
    }
  }

  String _getStickerPackTempPath(String packId) {
    return '$stickerTempCachePath/$packId';
  }

  String _getStickerItemTempPath(String packId, String fileId) {
    String fileName = fileId;
    if (fileId.endsWith('.tgs')) {
      fileName = fileId.replaceRange(fileId.length - 3, fileId.length, 'json');
    }

    if (stickerTempCachePath == null) {
      return '';
    }
    return '$stickerTempCachePath/$packId/$fileName';
  }

  String _getStickerPackUserPath(String packId) {
    return '$stickerUserCachePath/$packId';
  }

  String _getStickerItemUserPath(String packId, String fileId) {
    String fileName = fileId;
    if (fileId.endsWith('.tgs')) {
      fileName = fileId.replaceRange(fileId.length - 3, fileId.length, 'json');
    }

    if (stickerUserCachePath == null) {
      _log.w('Sticker user cache path is not initialized.');
      return '';
    }
    return '$stickerUserCachePath/$packId/$fileName';
  }

  Future<void> downloadStickerPack<T extends StickerPackEntity>({required T stickerPack}) async {
    try {
      if (stickerPack.stickerItems.isEmpty) {
        _log.w('Sticker pack ${stickerPack.id} has no items to download.');
        return;
      }

      if (await isPackDownloaded(packId: stickerPack.id, stickerCount: stickerPack.stickerItems.length)) {
        _log.d('Sticker pack ${stickerPack.id} is already downloaded.');
        return;
      }

      if (ConnectivityController.instance.isOffline) {
        throw NoInternetException(message: 'Device is offline');
      }

      stickerInQueueDownloadProgress[stickerPack.id] = 0.0;
      stickerInQueueDownloadStatus[stickerPack.id] = StickerDownloadStatus.inQueue;
      eventBus.fire(StickerPackDownloadStatusEvent(
        packId: stickerPack.id,
        fileId: stickerPack.coverId,
        status: StickerDownloadStatus.inQueue,
        currentProgress: 0,
        totalProgress: stickerPack.stickerItems.length + 1,
      ));
      stickerPackDownloadQueue.addJob(
        (_) async {
          try {
            await _downloadStickerPack(stickerPack: stickerPack);
          } catch (e, stackTrace) {
            _log.e('Error in downloadStickerPack job for pack: ${stickerPack.id}', e, stackTrace);
            rethrow;
          }
        },
        label: stickerPack.id,
      );
    } catch (e, stackTrace) {
      _log.w('Error adding download job for sticker pack: ${stickerPack.id}', e, stackTrace);
      rethrow;
    }
  }

  void cancelDownloadJob(String packId) {
    try {
      if (stickerInQueueDownloadStatus.containsKey(packId)) {
        stickerInQueueDownloadProgress.remove(packId);
        stickerInQueueDownloadStatus.remove(packId);

        eventBus.fire(StickerPackDownloadStatusEvent(
          packId: packId,
          fileId: '',
          status: StickerDownloadStatus.cancelled,
        ));
      }
    } catch (e, stackTrace) {
      _log.w('Error cancelling download job for sticker pack: $packId', e, stackTrace);
    }
  }

  void cancelAllDownloadJobs() {
    try {
      stickerPackDownloadQueue.clear();
      _log.d('All sticker pack download jobs have been cancelled.');
    } catch (e, stackTrace) {
      _log.w('Error cancelling all download jobs', e, stackTrace);
    }
  }

  bool isInQueue(String packId) {
    return stickerInQueueDownloadProgress.containsKey(packId);
  }

  (StickerDownloadStatus, double) getDownloadProgress(String packId) {
    if (stickerInQueueDownloadStatus.containsKey(packId)) {
      return (
        stickerInQueueDownloadStatus[packId] ?? StickerDownloadStatus.idle,
        stickerInQueueDownloadProgress[packId] ?? 0.0
      );
    } else {
      return (StickerDownloadStatus.idle, 0.0);
    }
  }

  bool _isCancelledOrFailed(String packId) {
    final currentPackStatus = stickerInQueueDownloadStatus[packId];
    if (currentPackStatus == null) {
      return true;
    }
    return currentPackStatus.isCancelled == true || currentPackStatus.isFailed == true;
  }

  Future<void> _downloadStickerPack<T extends StickerPackEntity>({required T stickerPack}) async {
    try {
      if (stickerPack.stickerItems.isEmpty) {
        _log.w('Sticker pack ${stickerPack.id} has no items to download.');
        return;
      }

      if (_isCancelledOrFailed(stickerPack.id)) {
        return;
      }

      if (ConnectivityController.instance.isOffline) {
        throw NoInternetException(message: 'Device is offline');
      }

      _currentDownloadingPackId = stickerPack.id;
      stickerInQueueDownloadStatus[stickerPack.id] = StickerDownloadStatus.inProgress;

      final totalDownloadAmount = stickerPack.stickerItems.length + 1; // +1 for cover

      // ✅ Parallel downloads with concurrency control
      final semaphore = _Semaphore(_maxConcurrentDownloads);
      final downloadTasks = <Future<void>>[];
      int completedCount = 0;

      // Create download tasks for all sticker items
      for (final item in stickerPack.stickerItems) {
        final task = _createDownloadTask(semaphore, stickerPack, item, () {
          completedCount++;
          _updateProgressThrottled(stickerPack, completedCount, totalDownloadAmount - 1);
        });
        downloadTasks.add(task);
      }

      // Wait for all downloads to complete
      await Future.wait(downloadTasks);

      if (_isCancelledOrFailed(stickerPack.id)) {
        return;
      }

      // Download cover after all items are done
      await _downloadStickerItemWithRetry(
        packId: stickerPack.id,
        fileId: stickerPack.coverId,
        saveToUserCache: true,
      );

      completedCount++; // Include cover in final count
      eventBus.fire(StickerPackDownloadStatusEvent(
        packId: stickerPack.id,
        fileId: stickerPack.coverId,
        status: StickerDownloadStatus.completed,
        currentProgress: completedCount.toDouble(),
        totalProgress: totalDownloadAmount.toDouble(),
      ));

      GetIt.I<TaxonomyService>().sendEvent(
        EventName.stickerDownloaded,
        eventProperties: EventProperty.stickerDownloaded(
          stickerPack.name,
          stickerPack.publisher,
          stickerPack.price,
          stickerPack.price == 0,
        ),
      );

      stickerInQueueDownloadProgress[stickerPack.id] = completedCount.toDouble() / totalDownloadAmount;
      stickerInQueueDownloadStatus[stickerPack.id] = StickerDownloadStatus.completed;
      _currentDownloadingPackId = '';
    } on NoInternetException catch (e) {
      _log.w('Failed to download sticker pack ${stickerPack.id} due to no internet connection.', e);
      eventBus.fire(StickerPackDownloadStatusEvent(
        packId: stickerPack.id,
        fileId: stickerPack.coverId,
        status: StickerDownloadStatus.failed,
      ));
      stickerInQueueDownloadStatus[stickerPack.id] = StickerDownloadStatus.failed;
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.w('Error downloading sticker pack: ${stickerPack.id}', e, stackTrace);
      eventBus.fire(StickerPackDownloadStatusEvent(
        packId: stickerPack.id,
        fileId: stickerPack.coverId,
        status: StickerDownloadStatus.failed,
      ));
      stickerInQueueDownloadStatus[stickerPack.id] = StickerDownloadStatus.failed;
      rethrow;
    } finally {
      _currentDownloadingPackId = '';
      // Clean up the queue and reset the progress for the pack.
      stickerInQueueDownloadProgress.remove(stickerPack.id);
      stickerInQueueDownloadStatus.remove(stickerPack.id);
    }
  }

  /// ✅ Create download task with semaphore control
  Future<void> _createDownloadTask<T extends StickerPackEntity>(
    _Semaphore semaphore,
    T stickerPack,
    dynamic item,
    VoidCallback onComplete,
  ) async {
    await semaphore.acquire();
    try {
      if (!_isCancelledOrFailed(stickerPack.id)) {
        await _downloadStickerItemWithRetry(
          packId: stickerPack.id,
          fileId: item.fileId,
          saveToUserCache: true,
        );
        onComplete();
      }
    } finally {
      semaphore.release();
    }
  }

  /// ✅ Throttled progress updates to prevent UI spam
  void _updateProgressThrottled<T extends StickerPackEntity>(
    T stickerPack,
    int completed,
    int total,
  ) {
    final now = DateTime.now();

    // Throttle progress updates except for completion
    if (_lastProgressUpdate != null &&
        now.difference(_lastProgressUpdate!) < _progressUpdateInterval &&
        completed < total) {
      return;
    }

    _lastProgressUpdate = now;

    eventBus.fire(StickerPackDownloadStatusEvent(
      packId: stickerPack.id,
      fileId: stickerPack.coverId,
      status: StickerDownloadStatus.inProgress,
      currentProgress: completed.toDouble(),
      totalProgress: (total + 1).toDouble(), // +1 for cover
    ));

    stickerInQueueDownloadProgress[stickerPack.id] = completed.toDouble() / (total + 1);
  }

  /// ✅ Add retry logic for failed downloads
  Future<void> _downloadStickerItemWithRetry({
    required String packId,
    required String fileId,
    required bool saveToUserCache,
  }) async {
    Exception? lastException;

    for (int attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        await _downloadStickerItem(
          packId: packId,
          fileId: fileId,
          saveToUserCache: saveToUserCache,
        );
        return; // Success
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());

        if (attempt < _maxRetries - 1) {
          // Exponential backoff
          final delay = Duration(milliseconds: 1000 * (1 << attempt));
          await Future.delayed(delay);
          _log.w('Retrying download $packId/$fileId, attempt ${attempt + 2}');
        }
      }
    }

    // All retries failed
    _log.e('Failed to download $packId/$fileId after $_maxRetries attempts');
    throw lastException!;
  }

  /// ✅ Optimized pack download check with caching
  Future<bool> isPackDownloaded({required String packId, required int stickerCount}) async {
    final cacheKey = '$packId-$stickerCount';
    final cachedResult = _packDownloadCache[cacheKey];

    // Check cache first
    if (cachedResult != null && DateTime.now().difference(cachedResult.timestamp) < const Duration(minutes: 5)) {
      return cachedResult.isDownloaded;
    }

    final packDir = Directory('$stickerUserCachePath/$packId');
    if (!await packDir.exists()) {
      _packDownloadCache[cacheKey] = _PackDownloadCacheEntry(false);
      return false;
    }

    // ✅ Use efficient counting instead of full listSync
    int fileCount = 0;
    try {
      await for (final entity in packDir.list()) {
        if (entity is File) {
          fileCount++;
          if (fileCount >= stickerCount) break; // Early exit when count reached
        }
      }
    } catch (e) {
      _log.w('Error counting files in pack directory: $packId', e);
      return false;
    }

    final isDownloaded = fileCount >= stickerCount;
    _packDownloadCache[cacheKey] = _PackDownloadCacheEntry(isDownloaded);
    return isDownloaded;
  }

  Future<bool> deleteStickerPack({required String packId}) async {
    final packDir = Directory('$stickerUserCachePath/$packId');
    final packExists = await packDir.exists();
    if (!packExists) {
      _log.w('Sticker pack directory does not exist: $packId');
      return false;
    }

    try {
      // Remove sticker items without cover.
      final items = await packDir.list().toList();
      for (final item in items) {
        await item.delete(recursive: true);
      }

      return true;
    } catch (e, stackTrace) {
      _log.e('deleteStickerPack $packId failed.', e, stackTrace);
      return false;
    }
  }

  Future<void> downloadStickerItem({
    required String packId,
    required String fileId,
    bool saveToUserCache = false,
    bool addToQueue = false,
  }) async {
    if (ConnectivityController.instance.isOffline) {
      throw NoInternetException(message: 'Device is offline');
    }

    if (addToQueue) {
      // ✅ Use semaphore for parallel processing instead of sequential AsyncQueue
      if (!_stickerItemSemaphoreMap.containsKey(packId)) {
        _stickerItemSemaphoreMap[packId] = _Semaphore(_maxConcurrentItemDownloads);
      }

      // Create parallel download task with semaphore control
      final semaphore = _stickerItemSemaphoreMap[packId]!;

      // Return the download future for optional awaiting by caller
      return _downloadWithSemaphore(
        semaphore: semaphore,
        packId: packId,
        fileId: fileId,
        saveToUserCache: saveToUserCache,
      );
    } else {
      await _downloadStickerItem(
        packId: packId,
        fileId: fileId,
        saveToUserCache: saveToUserCache,
      );
    }
  }

  /// ✅ Download with semaphore control for parallel processing
  Future<void> _downloadWithSemaphore({
    required _Semaphore semaphore,
    required String packId,
    required String fileId,
    required bool saveToUserCache,
  }) async {
    await semaphore.acquire();
    try {
      await _downloadStickerItem(
        packId: packId,
        fileId: fileId,
        saveToUserCache: saveToUserCache,
      );
    } catch (e, stackTrace) {
      _log.e('Error in downloadStickerItem job for pack: $packId, file: $fileId', e, stackTrace);
      // Don't rethrow to prevent one failed download from stopping others
    } finally {
      semaphore.release();
    }
  }

  Future<void> _downloadStickerItem({
    required String packId,
    required String fileId,
    bool saveToUserCache = false,
  }) async {
    try {
      String packDirPath = _getStickerPackTempPath(packId);
      if (saveToUserCache) {
        packDirPath = _getStickerPackUserPath(packId);
      }

      Directory packDir = Directory(packDirPath);
      final isExist = await packDir.exists();

      if (!isExist) {
        await packDir.create(recursive: true);
      }

      final isTgsSticker = fileId.endsWith('.tgs');
      if (isTgsSticker) {
        final fileName = fileId.replaceRange(
          fileId.length - 3,
          fileId.length,
          'json',
        );
        final savePath = '$packDirPath/$fileName';
        final file = File('$stickerTempCachePath/$packId/$fileName');
        final fileExists = await file.exists();

        if (fileExists) {
          if (ConnectivityController.instance.isOffline) {
            throw NoInternetException(message: 'Device is offline');
          }

          await file.copy(savePath);
          await Future.delayed(const Duration(milliseconds: 150));
          eventBus.fire(StickerItemDownloadCompleteEvent(fileId: fileId, packId: packId, stickerFile: file));
        } else {
          final stickerData = await stickerHttpDataSource.downloadStickerItem(
            packId: packId,
            fileId: fileId,
          );
          if (stickerData.isEmpty) {
            return;
          }

          await _downloadTgsSticker(
            stickerData: stickerData,
            filePath: savePath,
            packId: packId,
            fileId: fileId,
          );
        }
      } else {
        final savePath = '$packDirPath/$fileId';
        final file = File('$stickerTempCachePath/$packId/$fileId');
        final fileExists = await file.exists();
        if (fileExists) {
          if (ConnectivityController.instance.isOffline) {
            throw NoInternetException(message: 'Device is offline');
          }

          final newFile = await file.copy(savePath);
          final fileLength = await newFile.length();

          if (fileLength > 0) {
            await Future.delayed(const Duration(milliseconds: 150));
            eventBus.fire(StickerItemDownloadCompleteEvent(fileId: fileId, packId: packId, stickerFile: newFile));
            return;
          }
        }

        final stickerData = await stickerHttpDataSource.downloadStickerItem(
          packId: packId,
          fileId: fileId,
        );
        if (stickerData.isEmpty) {
          return;
        }

        await _downloadNormalSticker(
          stickerData: stickerData,
          filePath: savePath,
          packId: packId,
          fileId: fileId,
        );
      }
    } catch (e, stackTrace) {
      _log.e('Failed to download sticker item: PACK_ID:$packId - FILE_ID:$fileId', e, stackTrace);
      rethrow;
    }
  }

  /// ✅ Convert data from .tgs file into json file with optimized isolate processing
  /// .tgs file is sticker file from telegram.
  Future<void> _downloadTgsSticker({
    required List<int> stickerData,
    required String filePath,
    required String packId,
    required String fileId,
  }) async {
    try {
      final file = File(filePath);

      // ✅ Process TGS in isolate to avoid UI blocking
      final processedJson = await compute(_processTgsInIsolate, {
        'stickerData': stickerData,
        'targetScale': 512.0,
      });

      // ✅ Write file in isolate to avoid blocking
      await compute(_writeFileInIsolate, {
        'filePath': filePath,
        'content': processedJson,
      });

      eventBus.fire(StickerItemDownloadCompleteEvent(
        fileId: fileId,
        packId: packId,
        stickerFile: file,
      ));
    } catch (e, stackTrace) {
      _log.e('Failed to download animated sticker: $packId - $fileId', e, stackTrace);
      rethrow;
    }
  }

  /// ✅ Heavy TGS processing moved to isolate
  static String _processTgsInIsolate(Map<String, dynamic> params) {
    final stickerData = params['stickerData'] as List<int>;
    final targetScale = params['targetScale'] as double;

    final decoded = gzip.decode(stickerData);
    final decodedStr = String.fromCharCodes(decoded);
    final result = json.decode(decodedStr) as Map<String, dynamic>;

    // Apply scaling transformations efficiently
    final scale = targetScale / (result['w'] as num);
    result['w'] = result['w'] * scale;
    result['h'] = result['h'] * scale;

    // Process layers efficiently
    final layers = result['layers'] as List?;
    if (layers != null) {
      for (final layer in layers) {
        _processLayerTransforms(layer, scale);
      }
    }

    return json.encode(result);
  }

  /// ✅ Helper method for processing layer transformations
  static void _processLayerTransforms(dynamic layer, double scale) {
    if (layer is! Map<String, dynamic>) return;

    final ks = layer['ks'];
    if (ks == null || ks is! Map<String, dynamic>) return;

    final parent = layer['parent'];
    if (parent == null) return;

    // Process position transformations
    final p = ks['p'];
    if (p is Map<String, dynamic> && p['k'] is List) {
      final k = p['k'] as List;
      p['k'] = k.map((x) => _processKeyframe(x, scale)).toList();
    }

    // Process scale transformations
    var s = ks['s'];
    if (s is Map<String, dynamic> && s['k'] is List) {
      final k = s['k'] as List;
      s['k'] = k.map((x) => _processKeyframe(x, scale)).toList();
    } else if (s == null) {
      // Add default scale if missing
      ks['s'] = {
        'a': 0,
        'k': [100 * scale, 100 * scale, 100 * scale],
      };
    }
  }

  /// ✅ Helper method for processing keyframes
  static dynamic _processKeyframe(dynamic x, double scale) {
    if (x is num) {
      return x * scale;
    } else if (x is Map<String, dynamic>) {
      final Map<String, dynamic> result = Map.from(x);
      if (x['s'] is List) {
        result['s'] = (x['s'] as List).map((y) => y * scale).toList();
      }
      if (x['e'] is List) {
        result['e'] = (x['e'] as List).map((y) => y * scale).toList();
      }
      return result;
    }
    return x;
  }

  /// ✅ Write file operation in isolate
  static void _writeFileInIsolate(Map<String, dynamic> params) {
    final filePath = params['filePath'] as String;
    final content = params['content'] as String;
    File(filePath).writeAsStringSync(content);
  }

  /// ✅ Optimized normal sticker download with better memory management
  Future<void> _downloadNormalSticker({
    required List<int> stickerData,
    required String filePath,
    required String packId,
    required String fileId,
  }) async {
    try {
      final file = File(filePath);

      // ✅ Handle large file processing
      if (stickerData.length > 600000) {
        try {
          if (fileId.endsWith('.png') || fileId.endsWith('.jpg')) {
            CompressFormat format = CompressFormat.png;
            if (fileId.endsWith('jpg')) {
              format = CompressFormat.jpeg;
            }

            // ✅ Image compression must stay on main thread (platform channels required)
            final compressedData = await FlutterImageCompress.compressWithList(
              Uint8List.fromList(stickerData),
              quality: 10,
              format: format,
            );

            // ✅ Write compressed data in isolate
            await compute(_writeBytesInIsolate, {
              'filePath': filePath,
              'data': compressedData,
            });
          } else {
            // ✅ Write large files in isolate
            await compute(_writeBytesInIsolate, {
              'filePath': filePath,
              'data': stickerData,
            });
          }
        } catch (e, stackTrace) {
          _log.e('saveNormalSticker failed by image compress.', e, stackTrace);
          rethrow;
        }
      } else {
        // Small files can be written directly
        await file.writeAsBytes(stickerData);
      }

      eventBus.fire(StickerItemDownloadCompleteEvent(
        fileId: fileId,
        packId: packId,
        stickerFile: file,
      ));
    } catch (e, stackTrace) {
      _log.e('Failed to download normal sticker: $packId - $fileId', e, stackTrace);
      rethrow;
    }
  }

  /// ✅ File writing in isolate (removed unused image compression isolate method)
  static void _writeBytesInIsolate(Map<String, dynamic> params) {
    final filePath = params['filePath'] as String;
    final data = params['data'] as List<int>;
    File(filePath).writeAsBytesSync(data);
  }

  String getStickerItemPath(String packId, String fileId) {
    final userPath = _getStickerItemUserPath(packId, fileId);
    final tempPath = _getStickerItemTempPath(packId, fileId);

    final userFile = File(userPath);
    final tempFile = File(tempPath);

    if (userFile.existsSync()) {
      return userFile.path;
    } else if (tempFile.existsSync()) {
      return tempFile.path;
    } else {
      return '';
    }
  }
}
