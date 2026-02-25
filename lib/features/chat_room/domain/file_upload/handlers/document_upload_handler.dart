import 'dart:io';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/upload_file_handler.dart';

/// Document upload handler
/// Handles document files (PDF, Excel, Word, etc.) and other generic files
/// Acts as a fallback handler for any file type not handled by image/video handlers
class DocumentUploadHandler extends BaseUploadFileHandler {
  final LoggerService _logger;

  DocumentUploadHandler(this._logger);

  @override
  List<String> get supportedFileTypes => [];

  @override
  bool shouldCompress(File file, FileMetadata metadata) {
    // Documents typically should not be compressed
    // as they may lose functionality or become corrupted
    return false;
  }

  // for security reason
  List<String> get blacklistFileType => [
        '.exe',
        '.bat',
        '.sh',
        '.bin',
        '.cmd',
        '.msi',
        '.com',
        '.apk',
        '.html', // remove
        '.htm',
        '.js',
        '.css',
        '.php',
        '.jsp',
        '.asp',
        '.dll',
        '.sys',
        '.reg',
        '.ini'
      ];

  @override
  bool canHandle(File file, FileMetadata metadata) {
    return !blacklistFileType.any((type) {
      final lowerType = type.toLowerCase();
      return metadata.extension.toLowerCase().contains(lowerType) ||
          (metadata.mimeType?.toLowerCase().contains(lowerType) ?? false);
    });
  }

  @override
  Future<File> compress(
    File file,
    FileMetadata metadata, {
    Function(double progress)? onProgress,
    Function()? onCancel,
  }) async {
    // No compression for documents
    _logger.d('No compression applied for document: ${metadata.fileName}');
    return file;
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
    );
  }
}
