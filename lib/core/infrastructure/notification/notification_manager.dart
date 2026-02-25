import 'common/notification_entity.dart';

abstract class NotificationManager {
  ///
  /// Initialize notification manager
  ///
  Future<void> initialize();

  ///
  /// Initialize with authentication data
  /// Example: userId, token, etc.
  ///
  Future<void> onAuthenticated();

  ///
  /// Handle unauthenticated state
  ///
  Future<void> onUnauthenticated();

  ///
  /// Mark app as ready to process notifications
  /// This should be called after app initialization is complete
  /// and navigation stack is ready
  ///
  Future<void> markAppReady();

  ///
  /// Handle notification opened
  /// Normally open notification from foreground
  ///
  Future<void> handleNotificationOpened(NotificationEntity notification);

  ///
  /// Show notification by [NotificationEntity]
  ///
  Future<void> showNotification(NotificationEntity notification);

  ///
  /// Clear notification by id
  ///
  Future<void> clearNotification(String id);

  ///
  /// Clear all native notifications like Android or iOS
  ///
  Future<void> clearAllNotifications();

  /// ----------------------------------------------------------------------------
  /// Handle notification opened
  /// ----------------------------------------------------------------------------

  Future<void> handleOpenNewMessageNotification(NotificationEntity notification);

  Future<void> handleOpenCallNotification(NotificationEntity notification, {bool isGroupIncoming = false});

  Future<void> handleOpenChatNotification(NotificationEntity notification);

  Future<void> handleOpenCentralNotification(NotificationEntity notification);

  /// ----------------------------------------------------------------------------
  /// Life cycle events
  /// ----------------------------------------------------------------------------

  ///
  /// Called when app is paused (goes to background)
  ///
  Future<void> onAppPaused();

  ///
  /// Called when app is resumed (comes from background)
  /// This is useful for processing queued notifications after passcode unlock
  ///
  Future<void> onAppResumed();
}
