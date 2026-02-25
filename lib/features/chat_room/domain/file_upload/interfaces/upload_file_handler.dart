import 'dart:io';

import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_type_identifier.dart';

/// Upload file handler interface (Strategy Pattern)
/// Task 5: File-Type Responsibility Handling
abstract class UploadFileHandler {
  /// Determines whether this file should be compressed
  /// Task 2: Compression Decision
  bool shouldCompress(File file, FileMetadata metadata);

  /// Compresses the file if needed
  /// Task 3 & 4: Image/Video Compression
  Future<File> compress(
    File file,
    FileMetadata metadata, {
    Function(double progress)? onProgress,
    Function()? onCancel,
  });

  /// Gets the file type this handler supports
  List<String> get supportedFileTypes;

  /// Validates if this handler can process the given file
  bool canHandle(File file, FileMetadata metadata);

  /// Optionally update the SendFileMessageRequest with the processed file
  Future<SendFileMessageRequest> updateSendFileRequest({
    required SendFileMessageRequest originalRequest,
    required File processedFile,
  });
}

/// Base implementation with common logic
abstract class BaseUploadFileHandler implements UploadFileHandler {
  @override
  bool canHandle(File file, FileMetadata metadata) {
    return supportedFileTypes.any((type) =>
        metadata.extension.toLowerCase().contains(type.toLowerCase()) ||
        (metadata.mimeType?.toLowerCase().contains(type.toLowerCase()) ?? false));
  }
}
