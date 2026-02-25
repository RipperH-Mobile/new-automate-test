import 'dart:io';
import '../entities/directory_stats.dart';
import '../entities/file_info.dart';

abstract class CacheRepository {
  /// Get the temporary directory path
  Future<Directory> getTemporaryDirectory();

  /// Get the application support directory path
  Future<Directory> getApplicationSupportDirectory();

  /// Scan directory and get file statistics
  Future<DirectoryStats> scanDirectory(Directory directory);

  /// Get all files in directory recursively
  Future<List<FileInfo>> getFilesInDirectory(Directory directory);

  /// Clear all files in directory
  Future<bool> clearDirectory(Directory directory);

  /// Clear files by type in directory
  Future<bool> clearFilesByType(Directory directory, FileType fileType);

  /// Get directory size in bytes
  Future<int> getDirectorySize(Directory directory);
}
