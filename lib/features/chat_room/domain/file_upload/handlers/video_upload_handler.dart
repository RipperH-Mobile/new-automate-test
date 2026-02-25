import 'dart:io';

import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/upload_file_handler.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

/// Video upload handler
/// Handles only video compression and processing
class VideoUploadHandler extends BaseUploadFileHandler {
  final LoggerService _logger;

  VideoUploadHandler(this._logger);

  @override
  List<String> get supportedFileTypes => UChatConstant.supportVideoExtensionList;

  @override
  bool shouldCompress(File file, FileMetadata metadata) {
    // Check if it's an AVI file (typically don't compress)
    if (metadata.extension.toLowerCase() == 'avi') {
      return false;
    }

    // For other video files, check various conditions:
    // - File size threshold
    // - Resolution threshold
    // - Duration threshold
    // TODO: Add more specific compression logic based on video properties
    //! TODO: Check video File, it seem this File param is not original file (cached or compressed file)
    const int sizeThreshold = 5 * 1024 * 1024; // 5MB
    return metadata.sizeInBytes > sizeThreshold;
  }

  @override
  Future<File> compress(
    File file,
    FileMetadata metadata, {
    Function(double progress)? onProgress,
    Function()? onCancel,
  }) async {
    try {
      if (!shouldCompress(file, metadata)) {
        return file;
      }
      _logger.d('Starting video compression for file: ${metadata.fileName}');

      // Get video info for compression decision
      final VideoData? videoInfo = await FileService.instance.getVideoInfo(file);
      if (videoInfo == null) {
        _logger.e('Cannot get video info for compression');
        return file;
      }

      // Check if compression is needed based on video properties
      final bool shouldCompressVideo = FileService.instance.shouldCompressVideo(
        videoInfo: videoInfo,
        height: videoInfo.height?.toDouble() ?? 0.0,
        width: videoInfo.width?.toDouble() ?? 0.0,
      );

      if (!shouldCompressVideo) {
        _logger.d('Video compression not needed based on video properties');
        return file;
      }

      // Perform video compression
      final File compressedFile = await FileService.instance.compressVideo(
        file: file,
        fileDuration: videoInfo.duration,
        onCompressingProgress: onProgress,
        onCancel: onCancel,
      );

      _logger.d('Video compression completed for file: ${metadata.fileName}');

      return compressedFile;
    } on CompressionCancelledException {
      _logger.d('Video compression cancelled for file: ${metadata.fileName}');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Error compressing video: ${metadata.fileName}', e, stackTrace);
      // Return original file if compression fails
      return file;
    }
  }

  @override
  Future<SendFileMessageRequest> updateSendFileRequest({
    required SendFileMessageRequest originalRequest,
    required File processedFile,
  }) async {
    final msgFileModel = originalRequest.messageFile.copyWith(
      uploadFile: processedFile,
      size: processedFile.lengthSync(),
    );
    return originalRequest.copyWith(
      messageFile: msgFileModel,
      duration: msgFileModel.duration,
      width: msgFileModel.width,
      height: msgFileModel.height,
    );
  }
}
