import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/notification/debug/message_state_entity.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_log_entity.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_logger.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_debug_toggle_service.dart';


/// Controller for notification debug UI
///
/// This controller manages the state and business logic for the notification
/// debug screen.
class NotificationDebugController extends GetxController {
  final NotificationLogger _logger = NotificationLogger();
  final NotificationDebugToggleService _debugToggle = NotificationDebugToggleService();
  
  // Observable state
  final isEnabled = false.obs;
  final notificationLogs = <NotificationLogEntity>[].obs;
  final messageStateLogs = <MessageStateEntity>[].obs;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();
  
  @override
  void onInit() {
    super.onInit();
    useLogger().d('NotificationDebugController.onInit - Initializing controller');
    _loadSettings();
    useLogger().d('NotificationDebugController.onInit - Settings loaded, isEnabled: ${isEnabled.value}');
    ever(isEnabled, (_) => _saveSettings());
    
    // Initial data refresh if logging is enabled
    if (isEnabled.value) {
      useLogger().d('NotificationDebugController.onInit - Logging is enabled, refreshing data');
      _refreshData();
    } else {
      useLogger().d('NotificationDebugController.onInit - Logging is disabled, not refreshing data');
    }
  }
  
  void _loadSettings() {
    isEnabled.value = _debugToggle.isNotificationLoggingEnabled;
  }
  
  void _saveSettings() {
    _debugToggle.setNotificationLoggingEnabled(isEnabled.value);
  }
  
  /// Toggles notification logging on/off
  Future<void> toggleLogging() async {
    useLogger().d('NotificationDebugController.toggleLogging - Toggling logging from ${!isEnabled.value} to ${isEnabled.value}');
    isEnabled.value = !isEnabled.value;
    useLogger().d('NotificationDebugController.toggleLogging - New isEnabled value: ${isEnabled.value}');
    if (isEnabled.value) {
      useLogger().d('NotificationDebugController.toggleLogging - Logging is now enabled, refreshing data');
      await _refreshData();
    } else {
      useLogger().d('NotificationDebugController.toggleLogging - Logging is now disabled, clearing data');
      notificationLogs.clear();
    }
  }
  
  /// Refreshes debug data from the logger (public method)
  Future<void> refreshData() async {
    await _refreshData();
  }
  
  /// Refreshes debug data from the logger
  Future<void> _refreshData() async {
    useLogger().d('NotificationDebugController._refreshData - Starting refresh');
    
    if (!isEnabled.value) {
      useLogger().d('NotificationDebugController._refreshData - Logging is disabled, returning');
      return;
    }
    
    isLoading.value = true;
    errorMessage.value = null;
    
    try {
      // Fetch all data from in-memory storage
      final logs = _logger.getNotificationLogs();
      
      useLogger().d('NotificationDebugController._refreshData - Fetched ${logs.length} logs');
      
      // Update observable lists
      notificationLogs.assignAll(logs);
      
      // Fetch message state logs
      final messageLogs = _logger.getMessageStateLogs();
      messageStateLogs.assignAll(messageLogs);
      
      useLogger().d('NotificationDebugController._refreshData - Updated observable lists. notificationLogs.length: ${notificationLogs.length}, messageStateLogs.length: ${messageStateLogs.length}');
    } catch (e) {
      useLogger().e('NotificationDebugController._refreshData - Error refreshing data', e);
      errorMessage.value = 'Failed to load debug data: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  
  /// Clears all debug data from the logger
  Future<void> clearAllData() async {
    try {
      _logger.clearAllData();
      await _refreshData();
    } catch (e) {
      errorMessage.value = 'Failed to clear data: $e';
    }
  }
  
  
  
  
  /// Shows details for a specific notification log
  void showNotificationLogDetails(NotificationLogEntity log) {
    Get.toNamed(
      '/notification_debug/log_details',
      arguments: {'log': log},
    );
  }
  
  /// Shows details for a specific message state log
  void showMessageStateLogDetails(MessageStateEntity log) {
    Get.toNamed(
      '/notification_debug/message_state_details',
      arguments: {'log': log},
    );
  }
  
}
