import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rive/rive.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/sticker/domain/events/sticker_item_download_complete_event.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';

final _log = useLogger();

class StickerItemPreviewController extends GetxController {
  final String packId;
  final String fileId;

  StickerItemPreviewController({
    required this.packId,
    required this.fileId,
  });

  File? stickerFile;
  RiveFile? riveFile;
  int riveSpeedPlay = 0;
  bool isFileExist = false;

  bool isLoading = false;
  bool isError = false;

  // Image dimensions
  int? _imageWidth;
  int? _imageHeight;

  StreamSubscription? downloadStatusSubscription;

  StickerDownloaderService get stickerDownloaderService => GetIt.I<StickerDownloaderService>();

  StickerController get stickerController => Get.find<StickerController>();
  final config = GetIt.I<ConfigDb>().authenticated;
  final enableWarMode = false.obs;

  @override
  onInit() {
    super.onInit();
    initStickerItem();

    downloadStatusSubscription = eventBus.on<StickerItemDownloadCompleteEvent>().listen(onDownloadComplete);
    _loadWarModeConfig();
  }

  @override
  onClose() {
    downloadStatusSubscription?.cancel();
    super.onClose();
  }

  bool get isLottieFile => fileId.endsWith('.tgs') || fileId.endsWith('.json');

  bool get isRiveFile => fileId.endsWith('.riv');

  /// Get image width in pixels
  int? get imageWidth {
    if (_imageWidth != null) return _imageWidth;

    // Try to get dimensions if file exists and we haven't cached them yet
    if (stickerFile != null && stickerFile!.existsSync() && !isRiveFile && !isLottieFile) {
      _loadImageDimensions();
    }

    return _imageWidth;
  }

  /// Get image height in pixels
  int? get imageHeight {
    if (_imageHeight != null) return _imageHeight;

    // Try to get dimensions if file exists and we haven't cached them yet
    if (stickerFile != null && stickerFile!.existsSync() && !isRiveFile && !isLottieFile) {
      _loadImageDimensions();
    }

    return _imageHeight;
  }

  /// Get formatted dimensions string for display (e.g., "512x512")
  String? get formattedDimensions {
    if (imageWidth != null && imageHeight != null) {
      return '${imageWidth}x$imageHeight';
    }
    return null;
  }

  /// Get file size in bytes for display
  int? get fileSizeInBytes {
    if (stickerFile != null && stickerFile!.existsSync()) {
      try {
        return stickerFile!.lengthSync();
      } catch (e) {
        _log.w('Error getting file size for $packId/$fileId: $e');
        return null;
      }
    }
    return null;
  }

  /// Get formatted file size string for display
  String? get formattedFileSize {
    final sizeInBytes = fileSizeInBytes;
    if (sizeInBytes == null) return null;

    if (sizeInBytes < 1024) {
      return '${sizeInBytes}B';
    } else if (sizeInBytes < 1024 * 1024) {
      final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(1);
      return '${sizeInKB}KB';
    } else {
      final sizeInMB = (sizeInBytes / (1024 * 1024)).toStringAsFixed(1);
      return '${sizeInMB}MB';
    }
  }

  void _loadWarModeConfig() async {
    enableWarMode.value = await config.getBool(key: ConfigDb.getEnableWarModeConfigKey()) ?? false;
  }

  Future<void> initStickerItem() async {
    final filePath = stickerController.getStickerItemPath(packId, fileId);
    if (filePath.isEmpty) {
      await downloadSticker();
      return;
    }

    stickerFile = File(filePath);
    final fileLength = await stickerFile?.length() ?? 0;

    if (isRiveFile) {
      isLoading = true;
      stickerController.addLoadingRivStickerQueue(packId, loadRiveFile);
      update();
    } else {
      if (fileLength <= 0) {
        await downloadSticker();
      } else {
        riveFile = null;
        isFileExist = true;
        isLoading = false;
        isError = false;
        // Load image dimensions for non-rive files
        _loadImageDimensions();
        update();
      }
    }
  }

  /// Load image dimensions for static image files
  Future<void> _loadImageDimensions() async {
    if (stickerFile == null || !stickerFile!.existsSync() || isRiveFile || isLottieFile || _imageWidth != null) {
      return;
    }

    try {
      final bytes = await stickerFile!.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      _imageWidth = image.width;
      _imageHeight = image.height;

      image.dispose();
      codec.dispose();

      update(); // Notify UI of dimension changes
    } catch (e) {
      _log.w('Error loading image dimensions for $packId/$fileId: $e');
    }
  }

  Future<void> loadRiveFile() async {
    final cacheRiveFile = stickerController.getRiveStickerFile(packId, fileId);
    if (cacheRiveFile != null) {
      riveFile = cacheRiveFile;
      isFileExist = true;
      isLoading = false;
      isError = false;
      riveSpeedPlay = 1;
      update();
      return;
    }

    riveFile = await RiveFile.file(stickerFile!.path);
    stickerController.cacheRiveStickerFile(packId, fileId, riveFile!);
    isFileExist = true;
    isLoading = false;
    isError = false;
    riveSpeedPlay = 1;
    update();
  }

  Future<void> downloadSticker() async {
    try {
      if (isLoading) return;

      if (packId.isEmpty || fileId.isEmpty) {
        isLoading = false;
        isError = true;
        update();
        return;
      }

      isLoading = true;
      update();

      await stickerDownloaderService.downloadStickerItem(packId: packId, fileId: fileId, addToQueue: true);
    } catch (e, stackTrace) {
      isLoading = false;
      isError = true;
      update();
      _log.e('Error downloading sticker item: PACK_ID:$packId - FILE_ID:$fileId', e, stackTrace);
    }
  }

  Future<void> onDownloadComplete(StickerItemDownloadCompleteEvent event) async {
    final packId = event.packId;
    final fileId = event.fileId;

    if (this.packId == packId && this.fileId == fileId) {
      stickerFile = event.stickerFile;
      isFileExist = await stickerFile!.exists();
      imageCache.clear();

      // Reset cached dimensions when new file is downloaded
      _imageWidth = null;
      _imageHeight = null;

      if (isRiveFile) {
        riveFile = await RiveFile.file(event.stickerFile.path);
      } else {
        riveFile = null;
        // Load image dimensions for non-rive files
        _loadImageDimensions();
      }

      isLoading = false;
      isError = false;
      update();
    }
  }
}
