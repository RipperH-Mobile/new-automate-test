import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:ffmpeg_kit_flutter_new_full/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_full/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/constants/uchat_mime.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/utils/storage/storage.dart';
import 'package:uchat/widgets.dart';
import 'package:path/path.dart' as path;

// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final _log = useLogger();

const appDesktopSaveTargetDirectoryPath = 'APP_DESKTOP_SAVE_TARGET_DIRECTORY_PATH';
const _kMaxSyncWriteFileSize = 10 * 1024 * 1024; // 10 MB
const _kSoftwareEncoderDefaultScale = '1080';
const _kSoftwareEncoderDefaultFps = '30';
const _kSoftwareEncoderDefaultCrf = '28';
const _kSoftwareEncoderDefaultBr = '128k';
const _kLargeVideoSizeThresholdMb = 25;
const _kMediumVideoSizeThresholdMb = 15;

/// Exception thrown when video compression is cancelled by the user.
class CompressionCancelledException implements Exception {
  final String message;
  const CompressionCancelledException([this.message = 'Video compression was cancelled.']);

  @override
  String toString() => 'CompressionCancelledException: $message';
}

class FileService with ServiceMixin {
  // Singleton pattern
  static final FileService instance = FileService.internal();

  factory FileService() => instance;

  FileService.internal();

  final config = ConfigDb().general;

  final _flutterVideoInfo = FlutterVideoInfo();

  /// The session ID of the currently active FFmpeg compression.
  /// Used to cancel an in-progress compression via [cancelVideoCompression].
  int? _activeFFmpegSessionId;

  String get fileBaseUrl => AppEnv.apiUrl;

  String _desktopSaveTargetDirectoryPath = '';

  String get desktopSaveTargetDirectoryPath {
    if (_desktopSaveTargetDirectoryPath.isNotEmpty) {
      return _desktopSaveTargetDirectoryPath;
    } else {
      return config.getStringSync(key: appDesktopSaveTargetDirectoryPath) ?? '';
    }
  }

  String get desktopSaveTargetDirectoryRelativePath {
    if (Platform.isMacOS) {
      if (desktopSaveTargetDirectoryPath.startsWith('/Volumes')) {
        final relativePath = p.relative(desktopSaveTargetDirectoryPath, from: '/Volumes/Macintosh HD');
        return '/$relativePath';
      } else {
        final relativePath = p.relative(desktopSaveTargetDirectoryPath);
        return '~/$relativePath';
      }
    } else {
      final relativePath = p.relative(desktopSaveTargetDirectoryPath);
      return '~/$relativePath';
    }
  }

  set desktopSaveTargetDirectoryPath(String path) {
    if (Platform.isMacOS && path.startsWith('/Volumes/Macintosh HD')) {
      path = path.replaceFirst('/Volumes/Macintosh HD', '');
    }
    config.saveConfigSync(
      key: appDesktopSaveTargetDirectoryPath,
      value: path,
    );
    _desktopSaveTargetDirectoryPath = path;
  }

  Future<void> setDefaultDesktopSaveTargetDirectoryPath() async {
    if (desktopSaveTargetDirectoryPath.isNotEmpty) {
      return;
    }

    final dir = await path_provider.getDownloadsDirectory();
    if (dir != null) {
      final path = dir.path;
      desktopSaveTargetDirectoryPath = path;
    }
  }

  Future<String?> getDirectoryPath() async {
    final directoryPath = await FilePicker.platform.getDirectoryPath();
    return directoryPath;
  }

  String getAvatarUrl(String avatarId) {
    return '${fileBaseUrl}profile/avatar/$avatarId';
  }

  String getProfileBackgroundUrl(String backgroundId) {
    return '${fileBaseUrl}profile/background/$backgroundId';
  }

  String getFileUrl(String fileId) {
    if (fileId.isEmpty) {
      useLogger().i(StackTrace.current);
    }

    return '${fileBaseUrl}chat-rooms/file/$fileId';
  }

  String getStickerUrl(String fileId, String packId) {
    return '${fileBaseUrl}sticker/$packId/file/$fileId';
  }

  String getAnnounceUrl(String fileId, {bool includeFileBaseUrl = true}) {
    return includeFileBaseUrl ? '${fileBaseUrl}announcement/image/$fileId' : 'announcement/image/$fileId';
  }

  String getOfficialMenuContainerBackground(String fileId, String oaId) {
    return '${fileBaseUrl}oa/$oaId/file/$fileId';
  }

  String getOfficialMenuCommandBackground(String fileId, String oaId) {
    return '${fileBaseUrl}oa/$oaId/file/$fileId';
  }

  String getOfficialRichMenuImage(String fileId, String oaId) {
    debugPrint(
        'getOfficialRichMenuImage: fileId=$fileId, oaId=$oaId imageUrl=${fileBaseUrl}v3/oa/$oaId/rich-menu/image/$fileId');
    return '${fileBaseUrl}v3/oa/$oaId/rich-menu/image/$fileId';
  }

  String getEmojiUrl(String fileId) {
    return '${fileBaseUrl}v2/emojis/file/$fileId';
  }

  String getFileIcon({required bool isLockedFile, String? filename}) {
    if (isLockedFile) return UChatAssetPath.lockedFileIcon;

    if (filename == null) {
      return UChatAssetPath.defaultFileTypeIcon;
    }

    String extension = filename.split('.').last;

    switch (extension) {
      case ('doc' || 'docx'):
        return UChatAssetPath.docFileTypeIcon;
      case 'svg':
        return UChatAssetPath.svgFileTypeIcon;
      case ('ppt' || 'pptm' || 'pptx'):
        return UChatAssetPath.pptFileTypeIcon;
      case 'pdf':
        return UChatAssetPath.pdfFileTypeIcon;
      case ('xlsx' || 'xls' || 'csv'):
        return UChatAssetPath.xlsFileTypeIcon;
      default:
        return UChatAssetPath.defaultFileTypeIcon;
    }
  }

  ///
  /// Helper method to get signed url from server.
  /// [url] is from [get*] method above.
  ///
  Future<String> getSignedUrl(String url) async {
    try {
      final urlResp = await httpCaller.get<String>(
        url,
        isExternalApi: true,
        options: Options(
          responseType: ResponseType.plain,
          headers: {},
        ),
        data: {
          'redirect': false,
        },
      );

      if (urlResp.data == null) {
        throw ApiException(message: 'Cannot get signed url.');
      }

      return urlResp.data!.replaceAll('"', '');
    } catch (e, stackTrace) {
      _log.e(UChatLogMessage(
        message: 'Cannot get signed url.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {
          'url': url,
        },
      ));
      rethrow;
    }
  }

  ///
  /// Helper to download from signed url and keep them local.
  ///
  /// TODO: this function should be remove and use function from [DownloadAndShareImage] class instead.
  Future<void> downloadFileFromSignedUrl({
    required String signedUrl,
    required File writeTo,
    void Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final fileResp = await httpCaller.get<List<int>>(
        signedUrl,
        isExternalApi: true,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {},
        ),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      final fileBytes = fileResp.data;
      if (fileBytes == null) {
        throw ApiException(message: 'Cannot received byte data.');
      }

      if (!await writeTo.exists()) {
        await writeTo.create(recursive: true);
      }

      final writeFile = await writeTo.open(mode: FileMode.write);
      await writeFile.writeFrom(fileBytes);
      await writeFile.close();
    } catch (e, stackTrace) {
      _log.e(UChatLogMessage(
        message: 'Cannot download file from signed url.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {
          'url': signedUrl,
        },
      ));
      rethrow;
    }
  }

  ///
  /// Helper to get base path from [fileId] without [roomId]
  /// Example:
  /// - fileId is `roomidlonglength_fileuuid.extension`.
  /// - replace and finally to `fileuuid`.
  ///
  String getBasePathFromFileIdWithOutRoomId(String fileId, String roomId) {
    String basePath = p.basenameWithoutExtension(fileId);
    basePath = basePath.replaceAll('${roomId}_', '');

    return basePath;
  }

  Future<File> downloadMessageFile(
    String fileId, {
    CancelToken? cancelToken,
    required String roomId,
    required String fileName,
    void Function(int count, int total)? onReceiveProgress,
    void Function()? onDownloadSuccess,
  }) async {
    final url = getFileUrl(fileId);

    // Get uchat support dir.
    final uchatAppDir = await UChatStorage().getRoomDirectory(roomId: roomId);

    // Get the base path without duplicate with room id
    final basePath = getBasePathFromFileIdWithOutRoomId(fileId, roomId);
    final file = File('${uchatAppDir.path}/$basePath/$fileName');

    // If file not exist, download it!.
    String? signedUrl;
    try {
      if (!await file.exists()) {
        signedUrl = await getSignedUrl(url);
        await downloadFileFromSignedUrl(
          signedUrl: signedUrl,
          writeTo: file,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
        );
        onDownloadSuccess?.call();
      }
    } catch (e, stackTrace) {
      _log.e('Cannot launch "$url".', e, stackTrace);
      rethrow;
    }

    return file;
  }

  Future<File> downloadMessagePDFFile(
    String fileId,
    String fileName,
    void Function(int, int)? onReceiveProgress,
  ) async {
    try {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileId');
      if (await file.exists()) {
        return file;
      }

      final url = getFileUrl(fileId);
      final response = await httpCaller.get(
        url,
        isExternalApi: true,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {},
        ),
        onReceiveProgress: onReceiveProgress,
      );

      final bytes = response.data;
      file.writeAsBytes(bytes);

      return file;
    } catch (e, stackTrace) {
      _log.e('Cannot open pdf "$fileName" ($fileId).', e, stackTrace);
      rethrow;
    }
  }

  static String getFileExtension(String fileName) {
    return p.extension(fileName).split('.').last;
  }

  static Future<Uint8List?> compressImage(
    File file, {
    String? fileName,
    String? fileExtension,
    int quality = 50,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    final String ext = fileExtension ?? getFileExtension(fileName ?? file.path);
    final compressFormat = switch (ext) {
      'png' => CompressFormat.png,
      'webp' => CompressFormat.webp,
      _ => format,
    };

    final compressedImageBytes = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: quality,
      format: compressFormat,
    );
    return compressedImageBytes;
  }

  Future<File?> compressImageToFile({
    required File file,
    String? fileExtension,
    int quality = 50,
    String? fileName,
  }) async {
    final compressedImageBytes = await compressImage(
      file,
      fileExtension: fileExtension,
      quality: quality,
      fileName: fileName,
    );

    if (compressedImageBytes == null) {
      return null;
    }

    // final compressedFile = await convertUint8ListToFile(
    //   compressedImageBytes,
    //   fileName: fileName,
    //   fileExtension: fileExtension,
    // );

    final compressedFile = await compute(
        (Map<String, dynamic> fileData) async => await convertUint8ListToFile(
              fileData['compressedImageBytes'],
              fileName: fileData['fileName'],
              fileExtension: fileData['fileExtension'],
            ),
        {
          'compressedImageBytes': compressedImageBytes,
          'fileName': fileName,
          'fileExtension': fileExtension,
        });

    return compressedFile;
  }

  static BlurHash? generateBlurHash(Map<String, dynamic> imageData) {
    final imageBytes = imageData['imageBytes'] as Uint8List;
    final width = imageData['width'] as int?;
    final height = imageData['height'] as int?;

    img.Image? imageObj = img.decodeImage(imageBytes);
    if (imageObj == null) {
      return null;
    }

    img.Image thumbnail = img.copyResize(
      imageObj,
      width: width ?? 16,
      height: height ?? 16,
    );

    return BlurHash.encode(thumbnail, numCompX: 4, numCompY: 4);
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<bool> _isValidFile(File file) async {
    // return await file.exists() && await file.length() > 0;
    // check file can be opened by video info
    try {
      final info = await _flutterVideoInfo.getVideoInfo(file.path);
      return info != null && (info.duration != null && info.duration! > 0);
    } catch (e) {
      _log.e('Cannot get video info for "${file.path}".', e);
      return false;
    }
  }

  Future<void> _safeDelete(String filePath) async {
    try {
      final f = File(filePath);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  /// Compress video
  /// [file] is the video file.
  /// [onCompressingProgress] is the callback when compressing progress.
  /// [onDone] is the callback when compressing done.
  /// [onError] is the callback when compressing error.
  /// [onCancel] is the callback when compressing cancel.
  /// Return [File] is the compressed video file.
  /// Throw [CompressionCancelledException] when compressing is cancelled.
  /// Throw [Exception] when compressing error.
  /// Compress video file.
  ///
  /// Note: Android emulators lacking hardware encoders may produce corrupted video files
  /// without throwing an explicit exception.
  /// To handle this, we verify the output integrity using [_isValidFile] after compression.
  /// and re-attempt compression using software encoder if needed. if it fails again, return the original file.
  Future<File> compressVideo({
    required File file,
    double? fileDuration,
    void Function(double percentage)? onCompressingProgress,
    void Function(File compressedFile)? onDone,
    void Function(dynamic error)? onError,
    void Function()? onCancel,
  }) async {
    try {
      final tempPath = await getTemporaryDirectory();
      final outputPath = path.join(tempPath.path, 'video_${DateTime.now().millisecondsSinceEpoch}.mp4');
      String command = await getFFmpegCommand(file: file, outputPath: outputPath);

      // Compress file via execute the command
      ReturnCode? returnCode = await onFFmpegCompressing(
        command: command,
        totalDuration: fileDuration ?? 0,
        onCompressingProgress: onCompressingProgress,
      );

      // If the session was cancelled, clean up and throw
      if (ReturnCode.isCancel(returnCode)) {
        await _safeDelete(outputPath);
        onCancel?.call();
        throw const CompressionCancelledException();
      }

      final outputFile = File(outputPath);
      final bool hwEncodeValid = ReturnCode.isSuccess(returnCode) && await _isValidFile(outputFile);

      // If hardware encoder isn't success or output is corrupted (e.g. emulator
      // returns success but produces a broken file), fall back to software encoder.
      if (!hwEncodeValid) {
        await _safeDelete(outputPath);

        command = await getFFmpegCommand(
          file: file,
          outputPath: outputPath,
          useSoftwareEncoder: true,
        );

        returnCode = await onFFmpegCompressing(
          command: command,
          totalDuration: fileDuration ?? 0,
          onCompressingProgress: onCompressingProgress,
        );

        // Check cancel again for the software encoder fallback
        if (ReturnCode.isCancel(returnCode)) {
          await _safeDelete(outputPath);
          onCancel?.call();
          throw const CompressionCancelledException();
        }

        if (ReturnCode.isSuccess(returnCode) && await _isValidFile(outputFile)) {
          return outputFile;
        }
      } else {
        return outputFile;
      }

      return file;
    } on CompressionCancelledException {
      rethrow;
    } catch (e, stackTrace) {
      _log.w('Cannot compress video.', e, stackTrace);
      rethrow;
    } finally {
      _activeFFmpegSessionId = null;
      onCompressingProgress?.call(1);
    }
  }

  Future<String> getFFmpegCommand({
    required File file,
    required String outputPath,
    bool useSoftwareEncoder = false,
  }) async {
    /// FFmpeg Video Compression Command
    ///
    // -i "${file.path}" = Input video file to compress
    // -vf "scale=-2:\'min(1080,ih)\'" = Resize video intelligently:
    //     -2 = Auto-calculate width to maintain aspect ratio (always even number)
    //     min(1080,ih) = Limit height to max 1080px (keeps smaller videos as-is)
    //     Preserves original orientation (portrait/landscape/square)
    // -r 30 = Set frame rate to 30fps
    // -c:a aac = Use AAC codec for audio
    // -b:a 128k = Audio bitrate 128 kbps (96k - 128k standard quality)
    //    Less number = low quality (8k, 16k, 32k, 64k, 96k, 112k, 128k, 160k, ...)
    // "$outputPath" = Output file path to save (input and output shouldn't be the same path)

    if (useSoftwareEncoder || (!Platform.isIOS && !Platform.isAndroid)) {
      /// Software Encoder
      ///
      // -c:v libx264 = Use H.264 software encoder (slower but universally compatible)
      // -crf 28 = Constant Rate Factor quality level (0-51, lower is better)
      //     18-23 = High quality, 28 = Good quality (recommended), 35+ = Low quality
      //     CRF controls quality, file size varies based on video complexity
      // -preset ultrafast = Encoding speed (ultrafast/fast/medium/slow/veryslow)
      //     ultrafast = 5-10x faster but 30-40% larger file
      //     Tradeoff: speed vs compression efficiency

      String scale = _kSoftwareEncoderDefaultScale;
      String fps = _kSoftwareEncoderDefaultFps;
      String crf = _kSoftwareEncoderDefaultCrf;
      String br = _kSoftwareEncoderDefaultBr;
      final fileSize = (await file.length()) / 1024 / 1024; // MB

      if (fileSize >= _kLargeVideoSizeThresholdMb) {
        scale = '720';
        fps = '24';
        crf = '30';
        br = '96k';
      } else if (fileSize >= _kMediumVideoSizeThresholdMb) {
        scale = '1080';
        fps = '24';
        crf = '28';
        br = '96k';
      }

      final command =
          '-i "${file.path}" -vf "scale=-2:\'min($scale,ih)\'" -r $fps -c:v libx264 -crf $crf -preset ultrafast -c:a aac -b:a $br "$outputPath"';

      final outputFile = File(outputPath);
      if (await outputFile.exists()) {
        // -y = overwrite file

        return '-y $command';
      }

      return command;
    } else if (Platform.isIOS) {
      // -c:v h264_videotoolbox = Use Apple's hardware encoder (VideoToolbox) - 3-5x faster than software
      // -b:v 1.5M = Video bitrate 1.5 Mbps (megabits per second)
      //     Controls file size: 2M = ~15MB per minute
      //     1M = smaller file, 4M = better quality

      return '-i "${file.path}" -vf "scale=-2:\'min(1080,ih)\'" -r 30 -c:v h264_videotoolbox -b:v 1.5M -c:a aac -b:a 128k "$outputPath"';
    } else {
      // -c:v h264_mediacodec = Use Android's hardware encoder (MediaCodec) - 3-5x faster than software

      return '-i "${file.path}" -vf "scale=-2:\'min(1080,ih)\'" -r 30 -c:v h264_mediacodec -b:v 1.5M -c:a aac -b:a 128k "$outputPath"';
    }
  }

  Future<ReturnCode?> onFFmpegCompressing({
    required String command,
    required double totalDuration,
    required void Function(double percentage)? onCompressingProgress,
  }) async {
    final completer = Completer<ReturnCode?>();
    int lastUpdateTime = 0;

    final session = await FFmpegKit.executeAsync(
      command,
      (session) async {
        completer.complete(await session.getReturnCode());
      },
      null,
      (statistics) {
        final timeMs = statistics.getTime();

        // Update progress every 200ms
        if (timeMs - lastUpdateTime >= 200) {
          lastUpdateTime = timeMs;

          if (totalDuration > 0) {
            final progress = (timeMs / totalDuration).clamp(0.0, 0.999);
            onCompressingProgress?.call(progress);
          }
        }
      },
    );

    // Store the session ID so it can be cancelled externally
    _activeFFmpegSessionId = session.getSessionId();

    return await completer.future;
  }

  /// Cancel the currently running FFmpeg video compression session.
  ///
  /// This cancels the active FFmpegKit session (if any).
  /// The [compressVideo] method will detect the cancellation via
  /// [ReturnCode.isCancel] and throw a [CompressionCancelledException].
  Future<void> cancelVideoCompression() async {
    final sessionId = _activeFFmpegSessionId;
    if (sessionId != null) {
      _log.d('Cancelling FFmpeg session: $sessionId');
      await FFmpegKit.cancel(sessionId);
      _activeFFmpegSessionId = null;
    }
  }

  Future<Uint8List> downloadFile(String url,
      {void Function(int received, int total)? onProgress, CancelToken? cancelToken}) async {
    try {
      final httpResp = await httpCaller.get<Uint8List>(
        url,
        isExternalApi: true,
        onReceiveProgress: (received, total) {
          if (onProgress != null) {
            EasyThrottle.throttle(
              'download-file-progress',
              const Duration(milliseconds: 100),
              () {
                onProgress(received, total);
              },
            );
          }
        },
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.bytes,
          headers: httpCaller.apiHeader,
        ),
      );

      return httpResp.data ?? Uint8List(0);
    } catch (e, stackTrace) {
      _log.e('Cannot download file from "$url".', e, stackTrace);
      rethrow;
    }
  }

  double originalRatioImage({
    required double originWidth,
    required double originHeight,
  }) {
    // handle square image
    if (originHeight == originWidth) {
      return 1;
    }

    // handle portrait image
    if (originHeight > originWidth) {
      final originalRatio = originWidth / originHeight;

      // for some images that too height
      // set ratio to 0.35 for showing some white space beside(left, right) it
      if (originalRatio < 0.09) {
        return 0.35;
      }

      // for some images that has ratio between 0.1 and 0.2
      // set ratio to 0.462 for the same screen capture image ratio
      // they will have white space beside(left, right) them
      if (originalRatio >= 0.1 && originalRatio <= 0.2) {
        return 0.462;
      }

      return originalRatio;
    }

    // handle landscape image
    if (originHeight < originWidth) {
      final originalRatio = originWidth / originHeight;

      // for some images that too width
      // set ratio to 3.5 for showing some white space beside(up, down) it
      if (originalRatio > 3) {
        return 3.5;
      }

      return originalRatio;
    }

    // handle other ratio image
    return originWidth / originHeight;
  }

  /// Save file to gallery or custom path(if it is desktop).
  /// [files] is the list of [FileSavingRequest] that contains [fileName] and [fileUrl].
  /// [savePath] is the custom path to save file. if you don't want to use default path.
  /// Return [bool] is the status of saving file.
  /// Return [null] if it is not saved.
  /// Throw [ApiException] when cannot download file.
  /// Throw [Exception] when cannot save file.
  Future<bool?> saveFile({
    required List<FileSavingRequest> files,
    String? savePath,
    Function(int progress, int total)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      bool isSaved = false;
      bool useDefaultPath = true;
      if (savePath != null) {
        useDefaultPath = false;
      }
      String? directoryPath = savePath;

      if (directoryPath == null) {
        if (UChatScreenUtil.instance.isMobilePlatform) {
          directoryPath = (await getTemporaryDirectory()).path;
        } else {
          if (desktopSaveTargetDirectoryPath.isNotEmpty && useDefaultPath) {
            directoryPath = desktopSaveTargetDirectoryPath;
          } else {
            final selectedDirectoryPath = await getDirectoryPath();
            if (selectedDirectoryPath != null) {
              directoryPath = selectedDirectoryPath;
            } else {
              return null;
            }
          }
        }
      }

      for (var i = 0; i < files.length; i++) {
        final file = files[i];
        String fileName = file.fileName;
        String fileUrl = file.fileUrl;

        if (file.isGif) {
          fileName = '${file.giphyId}.gif';
          fileUrl = 'https://i.giphy.com/media/${file.giphyId}/200.gif';
        }

        if (UChatScreenUtil.instance.isMobilePlatform) {
          final Uint8List bytes = await downloadFile(
            fileUrl,
            cancelToken: cancelToken,
            onProgress: onProgress,
          );

          if (bytes.isEmpty) {
            throw ApiException(message: 'Cannot download file from "$fileUrl".');
          }

          if (file.isVideo || file.isGif) {
            try {
              fileName = await buildFile(
                path: directoryPath!,
                fileName: fileName,
                bytes: bytes,
              );

              final result = await SaverGallery.saveFile(
                filePath: '$directoryPath/$fileName',
                fileName: fileName,
                skipIfExists: false,
              );
              isSaved = result.isSuccess;
            } catch (e, s) {
              _log.e('Cannot save file.', e, s);
            }
          } else {
            final result = await SaverGallery.saveImage(
              bytes,
              fileName: fileName,
              skipIfExists: false,
            );
            isSaved = result.isSuccess;
          }
        } else {
          final isDirectoryExist = await directoryExists(directoryPath!);
          if (!isDirectoryExist) {
            final newDirectory = await getDirectoryPath();
            if (newDirectory != null) {
              directoryPath = newDirectory;
              desktopSaveTargetDirectoryPath = directoryPath;
            } else {
              return null;
            }
          }
          final Uint8List bytes = await downloadFile(
            fileUrl,
            cancelToken: cancelToken,
            onProgress: onProgress,
          );

          if (bytes.isEmpty) {
            throw ApiException(message: 'Cannot download file from "$fileUrl".');
          }
          await buildFile(
            path: directoryPath,
            fileName: fileName,
            bytes: bytes,
          );
          isSaved = true;
        }

        // if (onProgress != null) {
        //   onProgress((i + 1).toDouble(), files.length.toDouble());
        // }
      }

      return isSaved;
    } catch (e, stackTrace) {
      _log.e('Cannot save file.', e, stackTrace);
      if (e is DioException && CancelToken.isCancel(e)) {
        return null;
      }
      handleException(e);
      return false;
    }
  }

  Future<void> saveFileUint8List({
    required Uint8List bytes,
    required String fileName,
  }) async {
    try {
      String? directoryPath;

      if (desktopSaveTargetDirectoryPath.isNotEmpty) {
        directoryPath = desktopSaveTargetDirectoryPath;
      } else {
        final selectedDirectoryPath = await getDirectoryPath();
        if (selectedDirectoryPath != null) {
          directoryPath = selectedDirectoryPath;
        } else {
          return;
        }
      }

      await buildFile(
        path: directoryPath,
        fileName: fileName,
        bytes: bytes,
      );
    } catch (e, stackTrace) {
      _log.e('Cannot save saveFileUint8List.', e, stackTrace);
    }
  }

  Future<String> buildFile({
    required String path,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final file = File('$path/$fileName');

    final fileExists = await file.exists();

    if (!fileExists) {
      await file.writeAsBytes(bytes);
      return fileName;
    } else {
      final newFileName = generateFileName(fileName);
      await buildFile(
        path: path,
        fileName: newFileName,
        bytes: bytes,
      );
      return newFileName;
    }
  }

  Future<String> uniqueFilename({
    required String filePath,
    bool returnFullPath = false,
  }) async {
    final fileName = p.basename(filePath);
    final pathDirectory = p.dirname(filePath);

    final file = File('$pathDirectory/$fileName');
    String resultFilename = fileName;
    bool exist = await file.exists();
    while (exist) {
      final newFilename = generateFileName(resultFilename);
      final newFile = File('$pathDirectory/$newFilename');
      exist = await newFile.exists();
      resultFilename = newFilename;
    }

    if (returnFullPath) {
      return '$pathDirectory/$resultFilename';
    } else {
      return resultFilename;
    }
  }

  String generateFileName(String fileName) {
    final regExp = RegExp(r'\((\d+)\)$');
    final splitFileName = fileName.split('.');
    final ext = splitFileName.last;
    splitFileName.removeLast();

    String name = splitFileName.join();
    final match = regExp.firstMatch(name);

    if (match == null) {
      splitFileName.add(' (1)');
      name = '$name (1)';
    } else {
      final currentCount = int.parse(match.group(0)!.replaceAll('(', '').replaceAll(')', ''));
      name = name.replaceRange(match.start, match.end, '(${currentCount + 1})');
    }

    return '$name.$ext';
  }

  /// Get file size in MB.
  double fileSize(File file) {
    final byteLength = file.lengthSync();
    return byteLength / math.pow(1024, 2);
  }

  double calcScale({
    required int srcWidth,
    required int srcHeight,
    int minWidth = 1920,
    int minHeight = 1080,
  }) {
    var scaleW = srcWidth / minWidth;
    var scaleH = srcHeight / minHeight;
    var scale = math.max(1.0, math.min(scaleW, scaleH));
    return scale;
  }

  Future<File> convertUint8ListToFile(
    Uint8List imgUint8List, {
    String? fileName,
    String? fileExtension,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final name = fileName ?? '${const Uuid().v4()}.$fileExtension';
    final file = File('${tempDir.path}/$name');

    // < 10 MB
    if (imgUint8List.length < _kMaxSyncWriteFileSize) {
      await file.writeAsBytes(imgUint8List, flush: false);
      return file;
    }

    // >= 10MB
    final filePath = file.path;
    final transferable = TransferableTypedData.fromList([imgUint8List]);

    await Isolate.run(() {
      final bytes = transferable.materialize().asUint8List();
      File(filePath).writeAsBytesSync(bytes, flush: false);
    });

    return file;
  }

  String? findMimeFromUint8List(Uint8List data) {
    return lookupMimeType('', headerBytes: data);
  }

  String? findExtensionFromMime(String? mime) {
    if (mime == null) {
      return null;
    }

    final parsedMime = mime.toLowerCase();

    if (mimeDB.containsKey(mime)) {
      final mimeObj = mimeDB[parsedMime] as Map<String, dynamic>?;

      if (mimeObj == null) {
        return null;
      }

      if (mimeObj['extensions'] != null) {
        final exts = mimeObj['extensions'] as List<String>?;
        if (exts != null && exts.isNotEmpty) {
          return exts.first;
        } else {
          return null;
        }
      }
    }

    return null;
  }

  Future<VideoData?> getVideoInfo(File file) async {
    return await _flutterVideoInfo.getVideoInfo(file.path);
  }

  Future<double?> getAudioDuration(File file) async {
    try {
      final playerController = PlayerController();
      await playerController.preparePlayer(path: file.path);
      final duration = await playerController.getDuration();
      playerController.dispose();
      return duration.toDouble();
    } catch (e, stackTrace) {
      _log.e('Cannot get audio duration.', e, stackTrace);
      return null;
    }
  }

  bool shouldCompressVideo({required VideoData videoInfo, double height = 0.0, double width = 0.0}) {
    final videoHeight = videoInfo.height?.toDouble() ?? height;
    final videoWidth = videoInfo.width?.toDouble() ?? width;
    if (videoHeight <= 0 || videoWidth <= 0) {
      return false;
    }

    return (videoInfo.height ?? height) >= 1080 ||
        (videoInfo.width ?? width) >= 1080 ||
        videoInfo.framerate != null && videoInfo.framerate! > 60;
  }

  String fileSizeStr(dynamic initSize, [int round = 2]) {
    /**
     * [size] can be passed as number or as string
     *
     * the optional parameter [round] specifies the number
     * of digits after comma/point (default is 2)
     */
    var divider = 1024;
    int size;
    try {
      size = int.parse(initSize.toString());
    } catch (e) {
      throw ArgumentError('Can not parse the size parameter: $e');
    }

    if (size < divider) {
      return '$size B';
    }

    if (size < divider * divider && size % divider == 0) {
      return '${(size / divider).toStringAsFixed(0)} KB';
    }

    if (size < divider * divider) {
      return '${(size / divider).toStringAsFixed(round)} KB';
    }

    if (size < divider * divider * divider && size % divider == 0) {
      return '${(size / (divider * divider)).toStringAsFixed(0)} MB';
    }

    if (size < divider * divider * divider) {
      return '${(size / divider / divider).toStringAsFixed(round)} MB';
    }

    if (size < divider * divider * divider * divider && size % divider == 0) {
      return '${(size / (divider * divider * divider)).toStringAsFixed(0)} GB';
    }

    if (size < divider * divider * divider * divider) {
      return '${(size / divider / divider / divider).toStringAsFixed(round)} GB';
    }

    if (size < divider * divider * divider * divider * divider && size % divider == 0) {
      num r = size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} TB';
    }

    if (size < divider * divider * divider * divider * divider) {
      num r = size / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} TB';
    }

    if (size < divider * divider * divider * divider * divider * divider && size % divider == 0) {
      num r = size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)} PB';
    } else {
      num r = size / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)} PB';
    }
  }

  Future<Uint8List?> generateThumbnailVideo(String videoPath) async {
    try {
      final thumbData = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        quality: 80,
        maxWidth: 720,
      );

      return thumbData;
    } catch (e, stackTrace) {
      _log.e('Cannot generate thumbnail video.', e, stackTrace);
      return null;
    }
  }

  /// Check if pdf is encrypted.
  ///
  /// Return [bool] is the status of pdf encryption.
  Future<bool> isPdfEncrypted(String pdfPath) async {
    try {
      final fileData = await File(pdfPath).readAsString(encoding: Encoding.getByName('latin1')!);
      final isEncrypt = fileData.contains('/Encrypt');
      return isEncrypt;
    } catch (e, stackTrace) {
      _log.e('Cannot check pdf encryption.', e, stackTrace);
      return false;
    }
  }

  /// Generate thumbnail for pdf file.
  ///
  /// This function use [pdfx] package to render the first page of pdf file.
  ///
  /// Return [Uint8List] (first) if can generate thumbnail.
  /// Return [bool] (second) if the pdf is encrypted.
  /// Return [bool] (third) if the thumbnail generation failed.
  /// Return format is (Uint8List?, bool)
  ///
  /// Example:
  /// - Can generate thumbnail: (data, false, false)
  /// - Pdf is encrypted: (null, true, false)
  /// - Cannot generate thumbnail: (null, false, true)
  ///
  /// Throw [Exception] when cannot generate thumbnail.
  Future<(Uint8List?, bool, bool)> generatePdfThumbnail(String pdfPath) async {
    PdfDocument? document;
    try {
      // Check if pdf is encrypted
      final isEncrypted = await isPdfEncrypted(pdfPath);
      if (isEncrypted) {
        // Return null data and true for encrypted
        return (null, true, false);
      }

      // Generate thumbnail for pdf
      document = await PdfDocument.openFile(pdfPath);
      final page = await document.getPage(1);
      final pageImage = await page.render(
        width: page.width * .5,
        height: page.height * .5,
        format: PdfPageImageFormat.jpeg,
        backgroundColor: '#FFFFFFFF',
      );
      // Close page after render
      await page.close();
      return (pageImage?.bytes, false, false);
    } catch (e, stackTrace) {
      _log.e('Cannot generate thumbnail pdf.', e, stackTrace);
      return (null, false, true);
    } finally {
      // Close document after use
      await document?.close();
    }
  }

  Future<bool> directoryExists(String path) async {
    final directory = Directory(path);
    return await directory.exists();
  }

  Future<String> mobileFileSavePath({
    required String roomId,
    required String fileId,
    required String fileName,
  }) async {
    final roomDirectory = await UChatStorage.instance.getRoomDirectory(roomId: roomId);
    final fileIdDirectory = p.basenameWithoutExtension(fileId);
    return '${roomDirectory.path}/$fileIdDirectory/$fileName';
  }

  String desktopFileSavePath({required String fileName}) {
    final directoryPath = desktopSaveTargetDirectoryPath;
    return '$directoryPath/$fileName';
  }

  Future<void> openFile(String filePath, {MessageFileModel? file}) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.noAppToOpen) {
        if (file != null) {
          showFileOptionsDialog(filePath, file);
        } else {
          UChatDialog.showAlertDialog(title: 'Cannot open this file.', description: 'No app to open.');
        }
      }
    } catch (e, stackTrace) {
      _log.e('Cannot open file.', e, stackTrace);
    }
  }

  /// Download file from url and save it to gallery.
  ///
  /// this method is used to download file from url and save it to gallery.
  /// for mobile platform, it will use [SaverGallery.saveFile] to save file to gallery.
  /// for desktop platform, it will use [buildFile] to save file to custom path.
  ///
  /// This function move from [DownloadAndShareImage] class.
  Future<void> download(
    List<MediaFileModel> mediaList, {
    CancelToken? cancelToken,
    String? successMessage,
    BuildContext? context,
    Duration showSuccessDialogDuration = const Duration(seconds: 1),
    bool showWaitingLoading = true,
    Function(int progress, int total)? onProgress,
  }) async {
    try {
      if (UChatScreenUtil.instance.isMobilePlatform) {
        final allow = await PermissionController.instance.checkGalleryPermission();
        if (!allow) {
          return;
        }
      }

      if (showWaitingLoading) {
        AppToast.showDownloadToast(context: Get.context!, title: 'Downloaded'.tr);
      }

      bool downloadSuccess = true;
      List<FileSavingRequest> downloadList = [];

      for (var i = 0; i < mediaList.length; i++) {
        final media = mediaList[i];

        if (media.isGif) {
          downloadList.add(
            FileSavingRequest(
              fileId: media.fileId,
              fileExtension: media.fileExtension,
              mimeType: media.mimeType,
              roomId: media.roomId,
              messageId: media.messageId,
              fileName: media.fileName,
              fileUrl: media.url,
              giphyId: media.giphyId,
              isGif: true,
            ),
          );
        } else {
          downloadList.add(
            FileSavingRequest(
              fileId: media.fileId,
              fileExtension: media.fileExtension,
              mimeType: media.mimeType,
              roomId: media.roomId,
              messageId: media.messageId,
              fileName: media.fileName,
              fileUrl: media.url,
              isVideo: media.isVideo,
            ),
          );
        }
      }
      final result = await FileService.instance.saveFile(
        files: downloadList,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );
      if (result == null) {
        await UChatLoading.hide();
        return;
      }

      if (result == false) {
        downloadSuccess = false;
      }

      if (!downloadSuccess) {
        await UChatLoading.hide();
        // UChatNewDialog.showGeneralErrorDialog(
        //   context: Get.context!,
        // );
        return;
      } else {
        // await UChatLoading.success(message: (successMessage ?? 'Saved!').tr, duration: showSuccessDialogDuration);
        AppToast.hideToast(Get.context!);
        AppToast.showDownloadToast(context: Get.context!, title: 'Downloaded'.tr);
      }
    } catch (e, s) {
      await UChatLoading.hide();
      _log.w('download error', e, s);
      handleException(e);
    }
  }
}
