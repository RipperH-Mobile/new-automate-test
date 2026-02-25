import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../domain/entities/directory_stats.dart';
import '../../domain/entities/file_info.dart';
import '../../domain/repositories/cache_repository.dart';

class CacheRepositoryImpl implements CacheRepository {
  @override
  Future<Directory> getTemporaryDirectory() async {
    return await path_provider.getTemporaryDirectory();
  }

  @override
  Future<Directory> getApplicationSupportDirectory() async {
    return await path_provider.getApplicationSupportDirectory();
  }

  @override
  Future<DirectoryStats> scanDirectory(Directory directory) async {
    try {
      final files = await getFilesInDirectory(directory);
      return DirectoryStats.fromFiles(
        directory.path,
        directory.path.split('/').last,
        files,
      );
    } catch (e) {
      // Return empty stats if directory doesn't exist or can't be read
      return DirectoryStats.fromFiles(
        directory.path,
        directory.path.split('/').last,
        [],
      );
    }
  }

  @override
  Future<List<FileInfo>> getFilesInDirectory(Directory directory) async {
    final List<FileInfo> files = [];

    try {
      if (!await directory.exists()) {
        return files;
      }

      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          try {
            final fileInfo = FileInfo.fromFile(entity);
            files.add(fileInfo);
          } catch (e) {
            // Skip files that can't be read
            continue;
          }
        }
      }
    } catch (e) {
      // Return empty list if directory can't be read
      return [];
    }

    return files;
  }

  @override
  Future<bool> clearDirectory(Directory directory) async {
    try {
      if (!await directory.exists()) {
        return true;
      }

      await for (final entity in directory.list()) {
        try {
          if (entity is File) {
            await entity.delete();
          } else if (entity is Directory) {
            await entity.delete(recursive: true);
          }
        } catch (e) {
          // Continue even if some files can't be deleted
          continue;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearFilesByType(Directory directory, FileType fileType) async {
    try {
      if (!await directory.exists()) {
        return true;
      }

      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          try {
            final fileInfo = FileInfo.fromFile(entity);
            if (fileInfo.type == fileType) {
              await entity.delete();
            }
          } catch (e) {
            // Continue even if some files can't be deleted
            continue;
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getDirectorySize(Directory directory) async {
    int size = 0;

    try {
      if (!await directory.exists()) {
        return 0;
      }

      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          try {
            final stats = await entity.stat();
            size += stats.size;
          } catch (e) {
            // Skip files that can't be read
            continue;
          }
        }
      }
    } catch (e) {
      return 0;
    }

    return size;
  }
}
