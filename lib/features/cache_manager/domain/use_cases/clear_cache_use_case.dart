import 'dart:io';
import '../entities/file_info.dart';
import '../repositories/cache_repository.dart';

class ClearCacheUseCase {
  final CacheRepository _repository;

  ClearCacheUseCase(this._repository);

  Future<bool> clearAll(Directory directory) async {
    return await _repository.clearDirectory(directory);
  }

  Future<bool> clearByType(Directory directory, FileType fileType) async {
    return await _repository.clearFilesByType(directory, fileType);
  }
}
