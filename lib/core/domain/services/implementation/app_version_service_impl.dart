import 'dart:async';

import 'package:uchat/core/domain/services/dialog_service.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services/config_db.dart';

import '../../../data/data_sources/models/payloads/app_version/check_app_version.dart';
import '../../../data/data_sources/remote/app_version_http_data_source.dart';
import '../../../exceptions/api_exception.dart';
import '../../entities/version_entity.dart';
import '../app_version_service.dart';
import '../navigator_service.dart';

const checkUpdateInterval = Duration(minutes: 30);

class AppVersionServiceImpl implements AppVersionService {
  final AppVersionHttpDataSource httpDataSource;
  final MetaService metaService;
  final DialogService dialogService;
  final NavigatorService navigatorService;
  final ConfigInstance generalConfig;

  AppVersionServiceImpl({
    required this.httpDataSource,
    required this.metaService,
    required this.dialogService,
    required this.navigatorService,
    required this.generalConfig,
  });

  VersionEntity? _currentVersion;
  VersionEntity? _lastVersion;

  @override
  VersionEntity? get lastVersion => _lastVersion;

  bool? _lastVersionForceUpdate;
  DateTime? _lastUpdate;

  @override
  DateTime? get lastUpdate => _lastUpdate;

  /// For check only one time to show the dialog.
  bool _hasRunCheckAppVersion = false;

  @override
  bool get lastVersionForceUpdate => _lastVersionForceUpdate ?? false;

  @override
  Future<void> initialize() async {
    _currentVersion = VersionEntity.fromString(metaService.appVersion);

    final lastVersion = await generalConfig.getString(key: ConfigDb.getAppVersionLastUpdateKey());
    if (lastVersion != null) {
      _lastVersion = VersionEntity.fromString(lastVersion);
    }

    _lastUpdate = await generalConfig.getDateTime(key: ConfigDb.getAppVersionLastVersionKey());
    _lastVersionForceUpdate = await generalConfig.getBool(key: ConfigDb.getAppVersionLastVersionForceUpdateKey());
  }

  ///
  /// Save the last version and last update time to the config instance and local storage.
  ///
  Future<void> _saveConfig() async {
    await generalConfig.saveConfig(key: ConfigDb.getAppVersionLastUpdateKey(), value: _lastVersion?.toString());
    await generalConfig.saveConfig(key: ConfigDb.getAppVersionLastVersionKey(), value: _lastUpdate);
    await generalConfig.saveConfig(
      key: ConfigDb.getAppVersionLastVersionForceUpdateKey(),
      value: _lastVersionForceUpdate,
    );
  }

  @override
  Future<void> checkUpdate({Duration? timeout}) async {
    if (!_canRunCheckAppVersion()) {
      return;
    }

    final currentVersion = VersionEntity.fromString(metaService.appVersion);
    final lastVersion = _lastVersion;
    if (lastVersion != null && currentVersion.needsUpdate(lastVersion) && !_isInvalidateCache()) {
      return;
    }

    try {
      useLogger().d('Check app version: ${currentVersion.toString()}');
      final CheckAppVersionResponse? result;
      if (timeout == null) {
        result = await httpDataSource.checkAppVersion();
      } else {
        result = await httpDataSource.checkAppVersion().timeout(const Duration(milliseconds: 2000));
      }

      _lastUpdate = DateTime.now();
      if (result == null) {
        _lastVersion = null;
        await _saveConfig();
        return;
      }

      _lastVersion = VersionEntity.fromString(result.version);
      _lastVersionForceUpdate = result.isForceUpdate;
    } on ApiException catch (e, stackTrace) {
      if (e.code != 404) {
        useLogger().w('_checkAppVersion error.', e, stackTrace);
      } else {
        useLogger().d('_checkAppVersion error.', e, stackTrace);
        _lastVersion = null;
        await _saveConfig();
      }
      return;
    } on TimeoutException catch (e, stackTrace) {
      useLogger().d('_checkAppVersion timeout.', e, stackTrace);
      return;
    } catch (e, stackTrace) {
      useLogger().w('_checkAppVersion error.', e, stackTrace);
      return;
    } finally {
      _lastUpdate = DateTime.now();
      await _saveConfig();
    }
  }

  @override
  Future<void> notifyUpdate() async {
    final currentVersion = _currentVersion;
    final lastVersion = _lastVersion;

    if (currentVersion == null || lastVersion == null) {
      return;
    }

    if (currentVersion.needsUpdate(lastVersion)) {
      final isConfirm = await dialogService.showAppUpdateDialog(forceUpdate: _lastVersionForceUpdate ?? false);
      useLogger().d('App update dialog result: $isConfirm');
      if (isConfirm) {
        await navigatorService.goToAppStore();
      }
      _hasRunCheckAppVersion = true;
    }
  }

  ///
  /// This method will check the time difference between the last update and the current time
  /// When the time difference is greater than the [checkUpdateInterval], it will return true.
  /// It's meaning can run the check app version.
  ///
  bool _canRunCheckAppVersion() {
    if (_hasRunCheckAppVersion) {
      return false;
    }

    final lastUpdate = _lastUpdate;
    if (lastUpdate == null) {
      return true;
    }

    final currentVersion = _currentVersion;
    final lastVersion = _lastVersion;
    if (lastVersion != null && currentVersion != null) {
      if (currentVersion.needsUpdate(lastVersion) && !_isInvalidateCache()) {
        return false;
      }
    }

    return _isInvalidateCache();
  }

  ///
  /// This method will check if the last update time is older than the [checkUpdateInterval].
  /// If it is, it will return true, meaning the cache is invalidated and needs to be refreshed.
  ///
  bool _isInvalidateCache() {
    final lastUpdate = _lastUpdate;
    if (lastUpdate == null) {
      return true;
    }

    final now = DateTime.now();
    final timeDifference = now.difference(lastUpdate);

    useLogger().d('Time difference since last update: $timeDifference (${timeDifference > checkUpdateInterval})');

    return timeDifference > checkUpdateInterval;
  }

  ///
  /// Resets the cached version and last update time.
  /// This method is used to clear the cache when needed.
  ///
  @override
  void resetCache() {
    _lastVersion = null;
    _lastUpdate = null;
  }
}
