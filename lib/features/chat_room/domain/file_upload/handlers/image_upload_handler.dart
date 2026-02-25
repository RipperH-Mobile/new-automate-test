import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/upload_file_handler.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

/// Image upload handler
/// Handles only image compression and processing
class ImageUploadHandler extends BaseUploadFileHandler {
  final LoggerService _logger;

  ImageUploadHandler(this._logger);

  @override
  List<String> get supportedFileTypes => UChatConstant.supportImageExtensionList;

  @override
  bool shouldCompress(File file, FileMetadata metadata) {
    // Compress if file size exceeds threshold (e.g., 2MB)
    //! TODO: Check image File, it seem this File param is not original file (cached or compressed file)
    const int compressionThreshold = 2 * 1024 * 1024; // 2MB
    return metadata.sizeInBytes > compressionThreshold;
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
        onProgress?.call(1.0);
        return file;
      }

      _logger.d('Starting image compression for file: ${metadata.fileName}');
      onProgress?.call(0.33);
      final Uint8List? compressedBytes = await FileService.compressImage(
        file,
        quality: 50,
        format: CompressFormat.jpeg,
      );
      onProgress?.call(0.50);

      if (compressedBytes == null) {
        _logger.w('Image compression failed, returning original file');
        return file;
      }

      // Create compressed file
      final String compressedPath = '${file.path}_compressed.jpeg';
      final File compressedFile = File(compressedPath);
      await compute(compressedFile.writeAsBytes, compressedBytes);
      onProgress?.call(1.0);

      _logger.d(
        'Image compression completed. Original size: ${metadata.sizeInBytes}, Compressed size: ${compressedBytes.length}',
      );

      return compressedFile;
    } catch (e, stackTrace) {
      _logger.e('Error compressing image: ${metadata.fileName}', e, stackTrace);
      // Return original file if compression fails
      return file;
    }
  }

  @override
  Future<SendFileMessageRequest> updateSendFileRequest({
    required SendFileMessageRequest originalRequest,
    required File processedFile,
  }) async {
    // For best performance, consider moving this logic to a compute() function.
    final imageBytes = await processedFile.readAsBytes();
    final imageSize = imageBytes.length;
    final img.Image? originalImage = img.decodeImage(imageBytes);

    final msgFileModel = originalRequest.messageFile.copyWith(
      uploadFile: processedFile,
      size: imageSize,
      width: originalImage?.width.toDouble(),
      height: originalImage?.height.toDouble(),
    );

    return originalRequest.copyWith(
      messageFile: msgFileModel,
      width: msgFileModel.width,
      height: msgFileModel.height,
    );
  }
}
