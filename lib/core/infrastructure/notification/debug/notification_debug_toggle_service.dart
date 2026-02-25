import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services/config_db.dart';

/// Service for managing debug feature toggles
///
/// This service provides a centralized way to enable/disable debug features
/// in the application. It uses the ConfigDb to persist settings across app
/// restarts.
class NotificationDebugToggleService {
  static const String _notificationLoggingEnabledKey = 'notification_logging_enabled';

  final ConfigDb _configDb;

  NotificationDebugToggleService() : _configDb = GetIt.instance<ConfigDb>();

  /// Returns true if notification logging is enabled
  bool get isNotificationLoggingEnabled {
    try {
      useLogger().d(
          'DebugToggleService.isNotificationLoggingEnabled - Reading config for key: $_notificationLoggingEnabledKey');
      final config = _configDb.general.getConfigSync(key: _notificationLoggingEnabledKey);
      final enabled = config?.boolValue ?? false;
      useLogger().d('DebugToggleService.isNotificationLoggingEnabled - Config value: $enabled');
      return enabled;
    } catch (e) {
      // If there's an error reading the config, default to disabled
      useLogger().e('DebugToggleService.isNotificationLoggingEnabled - Error reading config', e);
      return false;
    }
  }

  /// Sets whether notification logging is enabled
  Future<void> setNotificationLoggingEnabled(bool enabled) async {
    try {
      useLogger().d('DebugToggleService.setNotificationLoggingEnabled - Setting enabled to: $enabled');
      await _configDb.general.saveConfig(
        key: _notificationLoggingEnabledKey,
        value: enabled,
      );
      useLogger().d('DebugToggleService.setNotificationLoggingEnabled - Successfully saved config');
    } catch (e) {
      // Silently fail to avoid impacting the main app functionality
      // In a real implementation, we might want to log this error
      useLogger().e('DebugToggleService.setNotificationLoggingEnabled - Error saving config', e);
    }
  }
}
