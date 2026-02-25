import 'dart:io';

import 'package:uchat/entities/enums.dart';

/// File identification interface
/// Task 1: Responsible for determining file type and metadata
abstract class FileTypeIdentifier {
  /// Determines the file type based on extension, MIME type, etc.
  MessageFileType identifyFileType(File file);

  /// Gets file metadata (size, extension, MIME type)
  Future<FileMetadata> getFileMetadata(File file);
}

/// File metadata container
class FileMetadata {
  final String fileName;
  final String extension;
  final String? mimeType;
  final int sizeInBytes;
  final double? width;
  final double? height;
  final double? duration;

  const FileMetadata({
    required this.fileName,
    required this.extension,
    this.mimeType,
    required this.sizeInBytes,
    this.width,
    this.height,
    this.duration,
  });
}
