import 'dart:io';
import '../entities/directory_stats.dart';
import '../repositories/cache_repository.dart';

class GetDirectoryStatsUseCase {
  final CacheRepository _repository;

  GetDirectoryStatsUseCase(this._repository);

  Future<DirectoryStats> call(Directory directory) async {
    return await _repository.scanDirectory(directory);
  }
}
