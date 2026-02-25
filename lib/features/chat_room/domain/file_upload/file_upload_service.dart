import 'dart:io';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/handlers/document_upload_handler.dart';
import 'package:uchat/features/chat_room/domain/file_upload/handlers/image_upload_handler.dart';
import 'package:uchat/features/chat_room/domain/file_upload/handlers/video_upload_handler.dart';
import 'package:uchat/features/chat_room/domain/file_upload/implementations/file_type_identifier_impl.dart';
import 'package:uchat/features/chat_room/domain/file_upload/implementations/file_upload_task_impl.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_upload_task.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/upload_file_handler.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

/// File upload service that orchestrates the new architecture
/// This service coordinates all 6 tasks of the file upload process
class FileUploadService {
  final LoggerService _logger;
  final FileTypeIdentifier _fileTypeIdentifier;
  final FileUploadTask _uploadTask;
  final List<UploadFileHandler> _handlers;

  FileUploadService(this._logger)
      : _fileTypeIdentifier = FileTypeIdentifierImpl(),
        _uploadTask = FileUploadTaskImpl(_logger),
        _handlers = [
          ImageUploadHandler(_logger),
          VideoUploadHandler(_logger),
          DocumentUploadHandler(_logger),
        ];

  /// Main method to process and upload a file
  /// Coordinates all 6 tasks in sequence
  Future<FileUploadResult> processAndUploadFile({
    required SendFileMessageRequest fileReq,
    bool enableUploadPro = false,
    Function(double progress)? onProgress,
    Function()? onCancel,
    Map<String, dynamic>? additionalData,
  }) async {
    final File file = fileReq.files.first;
    try {
      _logger.d('Starting file upload process for: ${file.path}');

      // Task 1: File Identification
      final FileMetadata metadata = await _fileTypeIdentifier.getFileMetadata(file);
      _logger.d('File metadata extracted: ${metadata.fileName}, size: ${metadata.sizeInBytes}');

      // Task 2 & 5: Find appropriate handler for this file type
      final UploadFileHandler? handler = _findHandler(file, metadata);
      if (handler == null) {
        throw Exception('No handler found for file type: ${metadata.extension}');
      }

      _logger.d('Using handler: ${handler.runtimeType}');

      // Task 2: Compression Decision & Task 3/4: Compression (if needed)
      File processedFile = file;
      bool wasCompressed = false;
      double startProgress = 0;
      final double compressionWeight = handler.shouldCompress(file, metadata) ? 0.5 : 0.0;

      if (handler.shouldCompress(file, metadata)) {
        _logger.d('Compressing file: ${metadata.fileName}');
        processedFile = await handler.compress(
          file,
          metadata,
          onProgress: onProgress != null
              ? (compressionProgress) {
                  // Compression phase: 0% to 50%
                  onProgress(compressionProgress * compressionWeight);
                }
              : null,
          onCancel: onCancel,
        );
        wasCompressed = processedFile.path != file.path;
        startProgress = compressionWeight;

        _logger.d('Compression completed. Was compressed: $wasCompressed');
      } else {
        _logger.d('No compression needed for file: ${metadata.fileName}');
      }
      // OpenFile.open(processedFile.path);
      // throw Exception('Debug Open File before upload');

      // Task 6: Upload Task (API & Domain Call)
      final MessageCollection result;
      if (enableUploadPro) {
        result = await _uploadTask.uploadFilePro(
          fileReq: fileReq,
          mimeType: metadata.mimeType,
          onProgress: onProgress != null
              ? (uploadProgress) {
                  // Upload phase: 50% to 100% or 0% to 100% if no compression
                  final totalProgress = startProgress + (uploadProgress * (1.0 - compressionWeight));
                  onProgress(totalProgress);
                }
              : null,
        );
      } else {
        SendFileMessageRequest sendFileRequest = await handler.updateSendFileRequest(
          originalRequest: fileReq,
          processedFile: processedFile,
        );

        result = await _uploadTask.uploadFile(
          fileReq: sendFileRequest,
          additionalData: additionalData,
          onProgress: onProgress != null
              ? (uploadProgress) {
                  // Compression phase: 50% to 100%
                  final totalProgress = startProgress + (uploadProgress * (1.0 - compressionWeight));
                  onProgress(totalProgress);
                }
              : null,
        );
      }

      _logger.d('File upload completed successfully: ${metadata.fileName}');

      // Clean up compressed file if it was created
      if (wasCompressed && processedFile.path != file.path) {
        try {
          await processedFile.delete();
          _logger.d('Cleaned up compressed file: ${processedFile.path}');
        } catch (e) {
          _logger.w('Failed to clean up compressed file: ${processedFile.path}', e);
        }
      }

      return FileUploadResult(
        success: true,
        result: result,
        originalFile: file,
        processedFile: processedFile,
        wasCompressed: wasCompressed,
        metadata: metadata,
      );
    } on CompressionCancelledException catch (e) {
      _logger.d('File compression cancelled: ${file.path} - $e');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Error in file upload process: ${file.path}', e, stackTrace);

      rethrow;
    }
  }

  /// Find the appropriate handler for the given file
  UploadFileHandler? _findHandler(File file, FileMetadata metadata) {
    try {
      return _handlers.firstWhere((handler) => handler.canHandle(file, metadata));
    } catch (e) {
      _logger.w('No handler found for file: ${metadata.fileName}');
      return null;
    }
  }
}

/// Result of the file upload process
class FileUploadResult {
  final bool success;
  final MessageCollection? result;
  final dynamic error;
  final File originalFile;
  final File? processedFile;
  final bool wasCompressed;
  final FileMetadata metadata;

  FileUploadResult({
    required this.success,
    this.result,
    this.error,
    required this.originalFile,
    this.processedFile,
    this.wasCompressed = false,
    required this.metadata,
  });
}
