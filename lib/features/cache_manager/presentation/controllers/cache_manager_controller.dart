import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/directory_stats.dart';
import '../../domain/entities/file_info.dart';
import '../../domain/use_cases/get_directory_stats_use_case.dart';
import '../../domain/use_cases/clear_cache_use_case.dart';

class CacheManagerController extends GetxController {
  late final GetDirectoryStatsUseCase _getDirectoryStatsUseCase;
  late final ClearCacheUseCase _clearCacheUseCase;

  CacheManagerController() {
    _getDirectoryStatsUseCase = GetIt.instance.get<GetDirectoryStatsUseCase>();
    _clearCacheUseCase = GetIt.instance.get<ClearCacheUseCase>();
  }

  // Observables
  final Rx<DirectoryStats?> _temporaryDirectoryStats = Rx<DirectoryStats?>(null);
  final Rx<DirectoryStats?> _applicationSupportDirectoryStats = Rx<DirectoryStats?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxInt _selectedTabIndex = 0.obs;

  // Getters
  DirectoryStats? get temporaryDirectoryStats => _temporaryDirectoryStats.value;

  DirectoryStats? get applicationSupportDirectoryStats => _applicationSupportDirectoryStats.value;

  bool get isLoading => _isLoading.value;

  String get error => _error.value;

  int get selectedTabIndex => _selectedTabIndex.value;

  // Current directory stats based on selected tab
  DirectoryStats? get currentDirectoryStats {
    return _selectedTabIndex.value == 0 ? _temporaryDirectoryStats.value : _applicationSupportDirectoryStats.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadDirectoryStats();
  }

  void setSelectedTab(int index) {
    _selectedTabIndex.value = index;
  }

  Future<void> loadDirectoryStats() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      // Load temporary directory stats
      final tempDir = await getTemporaryDirectory();
      final tempStats = await _getDirectoryStatsUseCase.call(tempDir);
      _temporaryDirectoryStats.value = tempStats;

      // Load application support directory stats
      final appSupportDir = await getApplicationSupportDirectory();
      final appStats = await _getDirectoryStatsUseCase.call(appSupportDir);
      _applicationSupportDirectoryStats.value = appStats;
    } catch (e) {
      _error.value = 'Failed to load directory stats: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> clearAllCache() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final currentDir =
          _selectedTabIndex.value == 0 ? await getTemporaryDirectory() : await getApplicationSupportDirectory();

      final success = await _clearCacheUseCase.clearAll(currentDir);

      if (success) {
        Get.snackbar(
          'Success',
          'Cache cleared successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        await loadDirectoryStats(); // Refresh stats
      } else {
        _error.value = 'Failed to clear cache';
      }
    } catch (e) {
      _error.value = 'Failed to clear cache: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> clearCacheByType(FileType fileType) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final currentDir =
          _selectedTabIndex.value == 0 ? await getTemporaryDirectory() : await getApplicationSupportDirectory();

      final success = await _clearCacheUseCase.clearByType(currentDir, fileType);

      if (success) {
        Get.snackbar(
          'Success',
          'Cleared ${fileType.displayName} files successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        await loadDirectoryStats(); // Refresh stats
      } else {
        _error.value = 'Failed to clear ${fileType.displayName} files';
      }
    } catch (e) {
      _error.value = 'Failed to clear ${fileType.displayName} files: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  void refreshData() {
    loadDirectoryStats();
  }
}
