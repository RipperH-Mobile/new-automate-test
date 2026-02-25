import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/param/call_attribute_param.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/notification/debug/message_state_entity.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_log_entity.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_logger.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room_list/domain/chat_room_list_domain.dart';
import 'package:uchat/features/home/home_barrel.dart';
import 'package:uchat/lang/lang.dart';
import 'package:uchat/routes/app_pages.dart' show Routes;
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart' show UChatDialog;

import '../../../domain/services/life_cycle_service.dart';
import '../../../domain/services/security_service.dart';
import '../../../domain/services/snackbar_service.dart';
import '../../analytics/logger_service.dart';
import '../common/notification_entity.dart';
import '../common/notification_onesignal_entity.dart';
import '../common/notification_type.dart';
import '../notification_manager.dart';

/// -----------------------------------------------------------------------------
/// Global variables to prevent duplicate notifications
/// -----------------------------------------------------------------------------

/// Tracking entry for notification IDs with timestamp
class _NotificationTrackingEntry {
  final String id;
  final DateTime timestamp;

  _NotificationTrackingEntry(this.id, this.timestamp);

  /// Check if this entry has expired (older than 1 hour)
  bool get isExpired {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    return difference.inHours >= 1;
  }
}

///
/// For prevent duplicate notification received event
/// This happen on development mode when using hot reload.
///
final foregroundReceiveIds = <_NotificationTrackingEntry>[];

///
/// For prevent duplicate notification clicked event
/// This happen on development mode when using hot reload.
///
final clickListenerIds = <_NotificationTrackingEntry>[];

/// Configuration for notification tracking
const int _maxTrackingEntries = 50; // Increased from 10

/// -----------------------------------------------------------------------------------------
/// NotificationOnesignalManagerImpl
/// -----------------------------------------------------------------------------------------
///
/// This class implements the NotificationManager interface using OneSignal for handling notifications.
///
class NotificationOnesignalManagerImpl implements NotificationManager {
  /// TODO: Change [UserController] to [UserService] when it is implemented.
  final UserController userService;
  final SnackbarService snackbarService;
  final LifeCycleService lifeCycleService;
  final SecurityService securityService;

  /// Store only the latest notification that arrives before app is ready
  /// When user taps a notification, only the most recent one should be processed
  NotificationEntity? _latestPendingNotification;

  /// Flag to track if app is ready to handle notifications
  bool _isAppReady = false;

  /// Flag to track if we're currently processing the pending notification
  bool _isProcessingPending = false;

  NotificationOnesignalManagerImpl({
    required this.userService,
    required this.snackbarService,
    required this.lifeCycleService,
    required this.securityService,
  });

  /// ------------------------------------------------------------------------
  /// This is the implementation of NotificationManager using OneSignal.
  /// Register and initialize OneSignal SDK.
  /// ------------------------------------------------------------------------
  ///
  /// This method initializes OneSignal with the app ID and sets up listeners for notification events.
  ///
  @override
  Future<void> initialize() async {
    useLogger().d('[NotificationService] OneSignalManager->initialize');

    try {
      OneSignal.initialize(AppEnv.oneSignalAppID);
      useLogger().d('[NotificationService] oneSignal->initialize: ${AppEnv.oneSignalAppID}');
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] oneSignal->initialize->Error', e, stackTrace);
    }

    // We will update this once he logged in and goes to dashboard.
    // updateUserProfile(osUserID);
    // Store it into shared prefs, So that later we can use it.
    // Preferences.setOnesignalUserId(osUserID);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.removeForegroundWillDisplayListener(notificationOnForegroundWillDisplayListener);
    OneSignal.Notifications.addForegroundWillDisplayListener(notificationOnForegroundWillDisplayListener);

    OneSignal.Notifications.removeClickListener(notificationClickListener);
    OneSignal.Notifications.addClickListener(notificationClickListener);

    // OneSignal.Notifications.addPermissionObserver(
    //   (permission) {
    //     // Will be called whenever the permission changes
    //     // (ie. user taps Allow on the permission prompt in iOS)
    //   },
    // );

    // OneSignal.User.pushSubscription.addObserver(
    //   (OSPushSubscriptionChangedState changes) {
    //     // Will be called whenever the subscription changes
    //     // (ie. user gets registered with OneSignal and gets a user ID)
    //   },
    // );

    // OneSignal.shared.setEmailSubscriptionObserver(
    //   (OSEmailSubscriptionStateChanges emailChanges) {
    //     // Will be called whenever then user's email subscription changes
    //     // (ie. OneSignal.setEmail(email) is called and the user gets registered
    //   },
    // );

    // Set log level at the end of the function to avoid unexpected await.
    try {
      await OneSignal.Debug.setLogLevel(
        AppEnv.isDebug ? OSLogLevel.info : OSLogLevel.verbose,
      );
    } catch (e, stackTrace) {
      useLogger().w('[NotificationService] OneSignal->setLogLevel->Error', e, stackTrace);
    }
  }

  /// ------------------------------------------------------------------------
  /// Queue Management Methods
  /// ------------------------------------------------------------------------

  /// Check if the app is ready to handle notifications
  /// App is considered ready when:
  /// 1. App is in active state
  /// 2. HomeController is registered (main navigation is ready)
  /// 3. User is authenticated
  /// 4. Passcode is not locked
  bool _canHandleNotification() {
    // Check if user is authenticated
    if (userService.currentUser.value == null) {
      useLogger().d('[NotificationService] _canHandleNotification: User not authenticated');
      return false;
    }

    // Check if HomeController is registered (navigation ready)
    if (!Get.isRegistered<HomeController>()) {
      useLogger().d('[NotificationService] _canHandleNotification: HomeController not registered');
      return false;
    }

    // All checks passed
    return true;
  }

  /// Check if notification should be deferred due to passcode or app state
  Future<bool> _shouldDeferNotification() async {
    // Check passcode state
    if (await securityService.isPasscodeLocked()) {
      useLogger().d('[NotificationService] _shouldDeferNotification: Passcode is locked');
      return true;
    }

    // Check app lifecycle state
    if (!lifeCycleService.isActive) {
      useLogger()
          .d('[NotificationService] _shouldDeferNotification: App is not active (state: ${lifeCycleService.appState})');
      return true;
    }

    return false;
  }

  /// Store only the latest pending notification
  /// This ensures when user taps a notification, only the most recent one is processed
  void _queueNotification(NotificationEntity notification) {
    if (_latestPendingNotification != null) {
      useLogger().d(
          '[NotificationService] Replacing pending notification ${_latestPendingNotification!.id} with ${notification.id}');
    } else {
      useLogger()
          .d('[NotificationService] Storing pending notification: ${notification.id} (type: ${notification.type})');
    }

    // Replace any existing pending notification with the latest one
    _latestPendingNotification = notification;
  }

  /// Process the latest pending notification only
  /// When user taps a notification, only the most recent one should be processed
  Future<void> _processPendingNotification() async {
    if (_isProcessingPending) {
      useLogger().d('[NotificationService] Already processing pending notification, skipping');
      return;
    }

    if (_latestPendingNotification == null) {
      useLogger().d('[NotificationService] No pending notification to process');
      return;
    }

    _isProcessingPending = true;
    final notification = _latestPendingNotification!;
    useLogger().d(
        '[NotificationService] Processing latest pending notification: ${notification.id} (type: ${notification.type})');

    try {
      await _handleNotificationImmediate(notification);
      useLogger().d('[NotificationService] Successfully processed pending notification: ${notification.id}');
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Error processing pending notification: ${notification.id}', e, stackTrace);
    } finally {
      // Clear the pending notification after processing
      _latestPendingNotification = null;
      _isProcessingPending = false;
      useLogger().d('[NotificationService] Finished processing pending notification');
    }
  }

  /// Mark app as ready and process the latest pending notification
  @override
  Future<void> markAppReady() async {
    if (_isAppReady) {
      useLogger().d('[NotificationService] App already marked as ready');
      return;
    }

    useLogger().d('GGG: Marking app as ready for notifications');
    _isAppReady = true;

    // Use post frame callback to ensure UI is fully built
    // Process only the latest pending notification (if any)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processPendingNotification();
    });
  }

  /// Internal method to handle notification immediately without checks
  Future<void> _handleNotificationImmediate(NotificationEntity notification) async {
    switch (notification.type) {
      case NotificationType.newMessage:
        await handleOpenNewMessageNotification(notification);
        break;
      case NotificationType.incomingCall:
        await handleOpenCallNotification(notification, isGroupIncoming: true);
        break;
      case NotificationType.call:
        await handleOpenCallNotification(notification);
        break;
      case NotificationType.acceptInvited:
      case NotificationType.missedCall:
        await handleOpenChatNotification(notification);
        break;
      case NotificationType.newGroupInvitation:
      case NotificationType.acceptFriendRequest:
      case NotificationType.newFriendRequest:
        await handleOpenCentralNotification(notification);
        break;
      default:
        useLogger().e('[NotificationService] Unhandled notification type: ${notification.type}');
    }
  }

  /// Check if a specific route exists in the navigation stack
  bool _isRouteInStack(String routeName) {
    try {
      // Check current route tree for the route
      // Note: This is a best-effort check. If we can't determine,
      // we'll rely on the try-catch in the actual navigation code
      final currentRoute = Get.currentRoute;
      if (currentRoute == routeName) {
        return true;
      }

      // Check if we have a routing history
      // For GetX, if there's any route history, home should be in it
      // This is a heuristic - we assume home is the base route
      if (routeName == Routes.home) {
        // If current route is not root ('/'), home likely exists in stack
        return currentRoute != '/' && currentRoute.isNotEmpty;
      }

      return false;
    } catch (e) {
      useLogger().d('[NotificationService] Could not check route stack for $routeName: $e');
      return false;
    }
  }

  /// --------------------------------------------------------------------------
  /// Implementation for OneSignal notification management
  /// --------------------------------------------------------------------------
  ///
  /// This is the listener for notification received in foreground.
  ///
  void notificationOnForegroundWillDisplayListener(OSNotificationWillDisplayEvent event) async {
    event.preventDefault();
    final notificationId = event.notification.notificationId;

    // Check for duplicates
    if (foregroundReceiveIds.any((entry) => entry.id == notificationId)) {
      useLogger().d('[NotificationService] Duplicate foreground notification detected: $notificationId');
      return;
    }

    useLogger().d('[NotificationService] NotiReceived: $notificationId => ${event.notification.additionalData}');

    // Add to tracking with timestamp
    foregroundReceiveIds.add(_NotificationTrackingEntry(notificationId, DateTime.now()));

    // Limit list size (remove oldest if exceeds limit)
    if (foregroundReceiveIds.length > _maxTrackingEntries) {
      foregroundReceiveIds.removeAt(0);
    }

    // Clean up expired entries first
    foregroundReceiveIds.removeWhere((entry) => entry.isExpired);

    // Prevent notification when passcode is enabled and not verified
    if (await securityService.isPasscodeLocked()) {
      useLogger()
          .w('[NotificationService] Notification received while passcode is enabled and not verified: $notificationId');
      return;
    }

    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    // event.complete(event.notification);
    // _log.d('onesignalEvent: ${event.notification.notificationId} ${event.notification.additionalData}');

    final osNotification = event.notification;
    if (osNotification.title == null || osNotification.body == null) {
      useLogger().w('[NotificationService] Notification received without title or body: $notificationId');
      osNotification.display();
      return;
    }

    final notification = convertOneSignalNotificationToEntity(osNotification);
    if (notification.type == NotificationType.missedCall) {
      await useCallPerformance().startPerformanceCallingMissed(
        CallAttributesParams(
          roomCallId: notification.additionalData['roomCallId'] as String?,
          roomType: notification.additionalData['roomType'] as String?,
          callType: notification.additionalData['callType'] as String?,
          receivingFrom: ReceiveMethod.notification,
        ),
      );
    }
    await showNotification(notification);
  }

  void notificationClickListener(OSNotificationClickEvent result) async {
    // Remove all notification when notification is clicked
    await OneSignal.Notifications.clearAll();

    final notificationId = result.notification.notificationId;
    final data = result.notification.additionalData ?? {};
    final roomId = data['roomId'] is String ? data['roomId'] : data['roomId'].toString();

    // Clean up expired entries first
    clickListenerIds.removeWhere((entry) => entry.isExpired);

    // Check for duplicates
    if (clickListenerIds.any((entry) => entry.id == notificationId)) {
      useLogger().d(
          '[NotificationService] notificationClickListener: Duplicate notification ID detected, returning: $notificationId');
      return;
    }

    useLogger()
        .d('[NotificationService] notificationClickListener: Processing notification click for ID: $notificationId');

    // Log notification clicked
    useLogger().d('[NotificationService] notificationClickListener: Checking if NotificationLogger is enabled');
    final logger = GetIt.instance<NotificationLogger>();
    useLogger().d('[NotificationService] notificationClickListener: Got logger singleton instance from GetIt');

    if (logger.isEnabled) {
      useLogger().d('[NotificationService] notificationClickListener: NotificationLogger is enabled, logging click');
      final logEntity = NotificationLogEntity(
        notificationId: notificationId,
        roomId: roomId,
        timestamp: DateTime.now(),
        logType: NotificationLogType.clicked,
        notificationData: data,
        currentRoute: Get.currentRoute,
        isAppInForeground: lifeCycleService.isActive,
      );
      useLogger()
          .d('[NotificationService] notificationClickListener: Created log entity for notificationId: $notificationId');

      logger.logNotificationClicked(logEntity);
      useLogger().d('[NotificationService] notificationClickListener: Successfully logged notification click');
    } else {
      useLogger()
          .d('[NotificationService] notificationClickListener: NotificationLogger is disabled, not logging click');
    }

    // Add to tracking with timestamp
    clickListenerIds.add(_NotificationTrackingEntry(notificationId, DateTime.now()));

    // Limit list size (remove oldest if exceeds limit)
    if (clickListenerIds.length > _maxTrackingEntries) {
      clickListenerIds.removeAt(0);
    }

    final notification = convertOneSignalNotificationToEntity(result.notification);
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.notificationOpened,
      eventProperties: EventProperty.notificationOpened(notification),
    );

    // SAFETY CHECK: Check if passcode is locked
    if (await securityService.isPasscodeLocked()) {
      useLogger().w(
          '[NotificationService] notificationClickListener: Passcode is locked, queuing notification: $notificationId');
      _queueNotification(notification);
      return;
    }

    // SAFETY CHECK: Check if app can handle notification
    if (!_canHandleNotification()) {
      useLogger()
          .w('[NotificationService] notificationClickListener: App not ready, queuing notification: $notificationId');
      _queueNotification(notification);
      return;
    }

    // SAFETY CHECK: Check if notification should be deferred
    if (await _shouldDeferNotification()) {
      useLogger().w(
          '[NotificationService] notificationClickListener: Deferring notification due to app state: $notificationId');
      _queueNotification(notification);
      return;
    }

    // All safety checks passed, handle notification
    handleNotificationOpened(notification);
  }

  @override
  Future<void> onAppPaused() async {
    useLogger().d('[NotificationService] NotificationManager: onAppPaused called');
  }

  @override
  Future<void> onAppResumed() async {
    useLogger().d('[NotificationService] NotificationManager: onAppResumed called');

    // Check if app is ready and has a pending notification
    // This handles the case where notification was queued while passcode was locked
    if (_isAppReady && _latestPendingNotification != null) {
      useLogger()
          .d('[NotificationService] NotificationManager: App resumed, checking if we can process pending notification');

      // Check if passcode is still locked
      if (await securityService.isPasscodeLocked()) {
        useLogger().d('[NotificationService] NotificationManager: Passcode still locked, not processing notification');
        return;
      }

      // Check if app is in active state
      // if (!lifeCycleService.isActive) {
      //   useLogger().d('[NotificationService] NotificationManager: App not active yet, not processing notification');
      //   return;
      // }

      // Process the latest pending notification
      useLogger().d(
        '[NotificationService] NotificationManager: Processing pending notification ${_latestPendingNotification!.id} after resume',
      );
      await _processPendingNotification();
    }
  }

  /// --------------------------------------------------------------------------
  /// Implementation for authentication state changes
  /// --------------------------------------------------------------------------
  ///
  /// This method is called when the user is logged in or the session is valid.
  /// It will login to OneSignal with the user's external ID and add tags for user ID and session ID.
  ///
  @override
  Future<void> onAuthenticated() async {
    final user = UserController.instance.currentUser.value;

    // If user is null, do nothing.
    if (user == null) {
      return;
    }

    // If notification permission is not granted, do nothing.
    if (await PermissionController.instance.isNotificationPermissionGranted() == false) {
      return;
    }

    try {
      final externalId = '${user.id}-${user.currentSessionKeyId}';
      await OneSignal.login(externalId);
      useLogger().d('[NotificationService] OneSignal login success. ($externalId)');

      // removeAliases is used to remove any unused aliases for some user. This can be removed after there isn't any
      // user with aliases or when aliases config with one signal / back end has change.
      await OneSignal.User.removeAliases(['user_id', 'session_id']);
      await OneSignal.User.removeTag('environment');
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] OneSignal login error', e, stackTrace);
    }

    try {
      useLogger().d('[NotificationService] OneSignal add tags.');
      String userIdPrefix = '';
      if (!AppEnv.isProd) {
        userIdPrefix = '${AppEnv.serverEnvType.toUpperCase()}-';
      }

      await OneSignal.User.addTags({
        'user_id': '$userIdPrefix${user.id!}',
        'session_id': user.currentSessionKeyId,
      });
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] OneSignal add tags error', e, stackTrace);
    }
  }

  /// ----------------------------------------------------------------------------
  /// Implementation for unauthenticated state changes
  /// ----------------------------------------------------------------------------
  ///
  /// This method is called when the user is logged out or the session is invalidated.
  /// It will remove the tags and logout from OneSignal.
  ///
  @override
  Future<void> onUnauthenticated() async {
    try {
      useLogger().d('[NotificationService] OneSignal logout.');
      await OneSignal.User.removeTags(['user_id', 'session_id', 'environment']);
      await OneSignal.logout();
      useLogger().d('[NotificationService] OneSignal logout success.');
    } catch (error, stackTrace) {
      useLogger().w('[NotificationService] Call Onesignal>logout error.', error, stackTrace);
    }
  }

  /// ----------------------------------------------------------------------------
  /// Implementation for showing notifications
  /// ----------------------------------------------------------------------------
  ///
  /// This method is called to show a notification based on the provided NotificationEntity.
  /// It checks the type of notification and handles it accordingly.
  ///
  @override
  Future<void> showNotification(NotificationEntity notification) async {
    useLogger().d('[NotificationService] ShowNotification: ${notification.id} => ${notification.additionalData}');

    if (notification is! NotificationOnesignalEntity) {
      useLogger().w('[NotificationService] Notification is not NotificationOnesignalEntity, cannot show notification.');
      return;
    }

    switch (notification.type) {
      case NotificationType.acceptCall:
      case NotificationType.ackCall:
      case NotificationType.ringingCall:
      case NotificationType.declineCall:
      case NotificationType.cancelCall:
        _preventDefault(notification.id);
        break;
      case NotificationType.call:
        await _handleCallNotification(notification);
        break;
      case NotificationType.newMessage:
        // Don't show notification if user is already in the chat room
        if (_isUserInChatRoom(notification)) {
          return;
        }

        await _handleShowNewMessageNotification(notification);
        break;
      case NotificationType.newGroupInvitation:
      default:
        _showDefaultNotification(notification);
    }
  }

  /// Check if user is currently in the chat room that notification is about
  bool _isUserInChatRoom(NotificationOnesignalEntity notification) {
    final data = notification.additionalData;
    final roomId = data['roomId'] is String ? data['roomId'] : data['roomId'].toString();

    if (!Get.currentRoute.startsWith(Routes.chatRoomDirect.split('/').firstOrNull ?? '')) {
      return false;
    }

    final chatRoomId = Get.currentRoute.split('/').lastOrNull;

    return chatRoomId != null && chatRoomId == roomId;
  }

  /// Handle call notification display logic
  Future<void> _handleCallNotification(NotificationOnesignalEntity notification) async {
    final data = notification.additionalData;
    final isGroupCall = data['roomType'] == 'GROUP';
    final allowCallKit = data['allowCallKit'] != false;

    if (isGroupCall || !allowCallKit) {
      notification.osNotification.display();
    } else {
      if (GetPlatform.isAndroid) {
        // TODO: implement call notification for android
      }
      _preventDefault(notification.id);
    }
  }

  /// Handle new message notification display logic
  Future<void> _handleShowNewMessageNotification(NotificationOnesignalEntity notification) async {
    final title = _buildMessageTitle(notification);

    await _closeExistingSnackbar();

    useLogger().d(
      '[NotificationService] Handle new message notification display. appState: ${lifeCycleService.appState}',
    );

    if (lifeCycleService.isActive) {
      snackbarService.showNotification(
        notification: notification.copyWith(title: title),
        onTap: (_) => handleNotificationOpened(notification),
      );
    } else {
      // If app is inactive or paused, show the notification as a system notification.
      notification.osNotification.display();
    }
  }

  /// Build notification title with subtitle if available
  String _buildMessageTitle(NotificationOnesignalEntity notification) {
    String title = notification.osNotification.title ?? '';
    if (notification.osNotification.subtitle?.isNotEmpty == true) {
      title += '\n${notification.osNotification.subtitle}';
    }
    return title;
  }

  /// Close existing snackbar if open
  Future<void> _closeExistingSnackbar() async {
    if (Get.isSnackbarOpen) {
      try {
        await Get.closeCurrentSnackbar();
      } catch (e, stackTrace) {
        useLogger().w('[NotificationService] Close snackbar error.', e, stackTrace);
      }
    }
  }

  /// Show default notification with snackbar
  void _showDefaultNotification(NotificationOnesignalEntity notification) {
    snackbarService.showNotification(
        notification: notification,
        onTap: (_) => handleNotificationOpened(notification),
        onShow: () {
          if (notification.type == NotificationType.missedCall) {
            useCallPerformance().stopPerformanceCallingMissed(
              receiveMethod: ReceiveMethod.notification,
            );
          }
        });
  }

  /// ----------------------------------------------------------------------------
  /// Implementation for handling notification opened
  /// ----------------------------------------------------------------------------
  ///
  /// This method is called when a notification is opened from the foreground, background and
  /// handles the notification based on its type.
  @override
  Future<void> handleNotificationOpened(NotificationEntity notification) async {
    useLogger().d('[NotificationService] Notification opened from foreground: $notification');

    try {
      Get.closeAllSnackbars();
    } catch (e, stackTrace) {
      useLogger().d('[NotificationService] Close all snackbar error.', e, stackTrace);
    }

    if (notification is! NotificationOnesignalEntity) {
      useLogger().w('[NotificationService] Notification is not NotificationOnesignalEntity, cannot open notification.');
      return;
    }

    // Do nothing if currentUser is null. This should happen notification is tapped when user is not logged in.
    if (userService.currentUser.value == null) {
      useLogger().w('[NotificationService] Skipping open notification because currentUser is null');
      return;
    }

    // Handle different types of notifications
    await _handleNotificationImmediate(notification);
  }

  /// ----------------------------------------------------------------------------
  /// Implementation for clearing notifications
  /// ----------------------------------------------------------------------------
  ///
  /// This method clears all notifications
  @override
  Future<void> clearAllNotifications() async {
    await OneSignal.Notifications.clearAll();
  }

  ///
  /// This method clears a specific notification by its ID.
  ///
  @override
  Future<void> clearNotification(String id) async {
    await OneSignal.Notifications.removeNotification(int.parse(id));
  }

  /// ----------------------------------------------------------------------------
  /// Convert OneSignal notification to NotificationOnesignalEntity
  /// ----------------------------------------------------------------------------
  ///
  /// This method converts an OSNotification object to a NotificationOnesignalEntity.
  ///
  NotificationOnesignalEntity convertOneSignalNotificationToEntity(OSNotification osNotification) {
    final additionalData = osNotification.additionalData ?? {};
    final lang = getOneSignalLangCode(Get.locale ?? const Locale('en'));

    final Map<String, dynamic> markdownMessages;
    if (additionalData.containsKey('markdownMessages')) {
      markdownMessages = json.decode(additionalData['markdownMessages']);
    } else {
      markdownMessages = {};
    }

    final message = markdownMessages[lang] ?? markdownMessages['en'] ?? osNotification.body ?? '';
    final notifiedAt = DateTime.fromMillisecondsSinceEpoch(additionalData['timestamp'], isUtc: true);
    final type = NotificationType.from(additionalData['type'] ?? '');
    final String? avatarUrl = osNotification.additionalData?['senderAvatarUrl'];

    return NotificationOnesignalEntity(
      id: osNotification.notificationId,
      title: osNotification.title ?? 'UChat',
      body: message,
      notifiedAt: notifiedAt,
      avatarUrl: avatarUrl,
      type: type,
      additionalData: additionalData,
      osNotification: osNotification,
    );
  }

  ///
  /// The OneSignal method to prevent default notification behavior.
  ///
  void _preventDefault(String notificationId) {
    OneSignal.Notifications.preventDefault(notificationId);
  }

  /// ----------------------------------------------------------------------------
  /// Handle notification opening methods
  /// ----------------------------------------------------------------------------
  ///
  /// Handle opening a call notification.
  ///
  /// TODO: move [UChatCallController] to using [GetIt] and inject with constructor injection.
  ///
  @override
  Future<void> handleOpenCallNotification(NotificationEntity notification, {bool isGroupIncoming = false}) async {
    if (notification is! NotificationOnesignalEntity) {
      useLogger().w('[NotificationService] Notification is not NotificationOnesignalEntity, cannot show notification.');
      return;
    }

    final data = notification.additionalData;
    // TODO: @NJ - Implement call notification handling
    final callCtl = UChatCallController.instance;
    final callData = RoomCallModel.fromMap({
      'roomId': data['roomId'],
      'roomCallId': data['roomCallId'],
      'roomType': data['roomType'],
      'callType': data['callType'],
      'title': data['title'] ?? notification.osNotification.title,
      'imageUrl': data['imageUrl'],
      'imageBlurHash': data['imageBlurhash'],
      'liveKitRoomSID': data['liveKitRoomSID'],
    });
    callCtl.openIncomingCallScreen(callData, isGroupIncoming: isGroupIncoming);
  }

  ///
  /// Handle opening a central notification.
  /// This will navigate to the home screen and select the central tab.
  ///
  /// TODO: move [HomeController] to using [GetIt] and inject with constructor injection.
  ///
  @override
  Future<void> handleOpenCentralNotification(NotificationEntity notification) async {
    Get.until((route) => route.settings.name == Routes.home);
    HomeController.instance.onNavigationTapped(3);
  }

  ///
  /// Handle opening a chat notification.
  /// This will navigate to the chat room screen if the room exists.
  /// If the room does not exist, it will fetch the room from the server.
  ///
  /// TODO: move [RoomDb] to using [Repository] pattern.
  /// TODO: move [RoomCollection] to using [RoomEntity].
  /// TODO: move [RoomMessageOpenUtil] to using [GetIt] and inject with constructor injection.
  ///
  @override
  Future<void> handleOpenChatNotification(NotificationEntity notification) async {
    final data = notification.additionalData;
    final roomId = data['roomId'] is String ? data['roomId'] : data['roomId']?.toString();

    // Early return if roomId is null
    if (roomId == null) return;

    final targetRoute = Routes.chatRoomDirect.replaceAll(':id', roomId);
    if (Get.currentRoute == targetRoute) {
      // If user is already in the chat room, do nothing.
      useLogger().d('[NotificationService] User is already in the chat room: $roomId, $targetRoute');
      return;
    }

    RoomEntity? roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));

    // If room not found in local DB, fetch from server
    if (roomEntity == null) {
      final response = await GetIt.I<FetchChatRoomUseCase>().call(roomId);
      if (response != null) {
        roomEntity = response;
      }
    }

    // Log error and return if room is still not found after fetch attempt
    if (roomEntity == null) {
      useLogger().e('Cannot get room for notification, Room is null after fetch attempt.');
      return;
    }

    final room = RoomCollection.fromEntity(roomEntity);

    // Navigate to chat room using common logic
    await _navigateToChatRoom(roomId, room);
  }

  ///
  /// Handle opening a new message notification.
  /// This will navigate to the chat room screen if the room exists.
  /// If the room does not exist, it will fetch the room from the server.
  ///
  /// TODO: move [RoomDb] to using [Repository] pattern.
  /// TODO: move [RoomCollection] to using [RoomEntity].
  /// TODO: move [RoomSubscriptionDb] to using [Repository] pattern.
  /// TODO: move [UChatDialog] to using new [DialogService] and inject with constructor injection.
  ///
  @override
  Future<void> handleOpenNewMessageNotification(NotificationEntity notification) async {
    final stopwatch = Stopwatch()..start();
    final data = Map<String, dynamic>.from(notification.additionalData);
    final roomId = data['roomId'] is String ? data['roomId'] : data['roomId'].toString();

    if (roomId == null) {
      useLogger().w('[NotificationService] roomId is null in notification data: $data');
      return;
    }

    // Log initial notification receipt
    // TODO: Improve this logic before use again
    // await _logNotificationReceived(notification, roomId, data);

    // Fetch or create room
    final room = await _fetchOrCreateRoom(roomId, data);
    if (room == null) {
      useLogger().w('[NotificationService] User\'s chat room not found: $roomId');
      return;
    }

    // Validate secret room if needed
    if (!await _validateSecretRoom(room)) {
      useLogger().w('[NotificationService] Secret room validation failed: $roomId');
      return;
    }

    // Prepare messages and target message

    // TODO: Try to remove preparing messages here to improve performance (3 lines commented out)
    // final messages = await _fetchMessages(roomId);
    // await _updateRoomSubscription(room, messages);
    // final message = await _prepareTargetMessage(data['messageId'] ?? '', messages);

    // Ensure home controller is ready
    if (!await _ensureHomeControllerReady()) {
      useLogger().w('[NotificationService] HomeController not ready, cannot navigate to chat room: $roomId');
      return;
    }

    // Navigate to chat room

    // TODO: Try to remove preparing messages here to improve performance (line commented out)
    // await _navigateToChatRoom(roomId, room, message);

    await _navigateToChatRoom(roomId, room);

    // TODO: review face code
    // Navigate to chat room using common logic
    // await _navigateToChatRoomDirect(
    //   roomId: roomId,
    //   room: room,
    //   targetMessage: message,
    // );

    stopwatch.stop();
    _logNotificationHandled(notification, roomId, data, stopwatch.elapsedMilliseconds);
  }

  /// Log notification received event
  /// TODO: Improve this logic before use again
  Future<void> _logNotificationReceived(
    NotificationEntity notification,
    String roomId,
    Map<String, dynamic> data,
  ) async {
    final logger = GetIt.instance<NotificationLogger>();
    if (!logger.isEnabled) return;

    await RoomDb().getRoom(roomId);
    final messages = await _fetchMessages(roomId);

    logger.logNotificationReceived(NotificationLogEntity(
      notificationId: notification.id,
      roomId: roomId,
      timestamp: DateTime.now(),
      logType: NotificationLogType.received,
      notificationData: data,
      messageCountInDb: messages?.length,
      currentRoute: Get.currentRoute,
      isAppInForeground: lifeCycleService.isActive,
    ));
  }

  /// Fetch room from DB or create from server
  Future<RoomCollection?> _fetchOrCreateRoom(String roomId, Map<String, dynamic> data) async {
    RoomCollection? room = await GetIt.I<RoomDb>().getRoom(roomId);

    if (room != null) {
      useLogger().d('[NotificationService] User\'s chat room found in local DB: $roomId');
      return room;
    }

    try {
      useLogger().d('[NotificationService] Fetching user\'s chat room from server: $roomId');
      final tempRoom = await GetIt.I<FetchChatRoomUseCase>().call(roomId);
      room = tempRoom?.toCollection();

      if (room?.isDirect == true) {
        final directRoom = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: data['senderAccountId']),
        );
        room = directRoom?.toCollection();
      }

      return room;
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Cannot fetch my chat room', e, stackTrace);
      return null;
    }
  }

  /// Validate secret room has crypto key
  Future<bool> _validateSecretRoom(RoomCollection room) async {
    if (!room.isSecretRoom) return true;

    final roomSub = await RoomSubscriptionDb().getRoomSubscriptionWithRoomId(room.id!);

    if (roomSub?.hasCryptoKey ?? false) return true;

    UChatDialog.showAlertDialog(
      title: 'Room is not found'.tr,
      description: 'Probably removed'.tr,
      buttonText: 'Okay'.tr,
    );
    return false;
  }

  /// Prepare target message by finding and decrypting it
  Future<MessageCollection?> _prepareTargetMessage(String messageId, List<MessageCollection>? messages) async {
    if (messageId.isEmpty || messages == null) return null;

    final message = messages.firstWhereOrNull((e) => e.id == messageId);
    if (message == null) return null;

    final decrypted = await GetIt.I<DecryptMessageTextUseCase>().call(
      DecryptMessageTextParams(message: message.toEntity()),
    );
    return decrypted?.toCollection();
  }

  /// Ensure HomeController is ready and navigate to chat list tab
  Future<bool> _ensureHomeControllerReady() async {
    if (!Get.isRegistered<HomeController>()) {
      useLogger().e('[NotificationService] HomeController not registered, cannot navigate to chat list');
      return false;
    }

    final HomeController homeCtl = Get.find<HomeController>();
    homeCtl.onNavigationTapped(1); // '1' is the chat list tab
    return true;
  }

  /// Navigate to chat room
  Future<void> _navigateToChatRoom(String roomId, RoomCollection room, [MessageCollection? message]) async {
    final chatRoomDirect = _getChatRoomController(roomId);
    final expectedRoute = Routes.chatRoomDirect.replaceAll(':id', roomId);
    final isSubScreenStacked = Get.currentRoute != expectedRoute;

    if (chatRoomDirect == null || chatRoomDirect.roomId != roomId) {
      useLogger().d('[NotificationService] Navigating to new chat room: $roomId');
      await _navigateToNewChatRoom(roomId, room, message);
    } else if (isSubScreenStacked && chatRoomDirect.roomId == roomId) {
      useLogger().d('[NotificationService] Cleaning up sub-screen stack for chat room: $roomId');
      _handleSubScreenStack(expectedRoute);
    }
  }

  /// Get ChatRoomController if registered
  ChatRoomController? _getChatRoomController(String roomId) {
    if (!Get.isRegistered<ChatRoomController>(tag: roomId)) return null;

    try {
      return Get.find<ChatRoomController>(tag: roomId);
    } catch (e, stackTrace) {
      useLogger().d('[NotificationService] Cannot get ChatRoomController.', e, stackTrace);
      return null;
    }
  }

  /// Navigate to new chat room (not yet opened)
  Future<void> _navigateToNewChatRoom(
    String roomId,
    RoomCollection room, [
    MessageCollection? message,
  ]) async {
    final homeRouteExists = _isRouteInStack(Routes.home);

    if (!homeRouteExists) {
      _navigateWithSafeStack(roomId, room, message);
      return;
    }

    _navigateWithUntil(roomId, room, message);
  }

  /// Navigate with safe stack (when home route missing)
  void _navigateWithSafeStack(String roomId, RoomCollection room, MessageCollection? message) {
    useLogger().w('[NotificationService] Home route not in navigation stack, using safe navigation');
    Get.offAllNamed(Routes.home);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', roomId),
        arguments: ChatRoomArguments(room: room, targetMessage: message),
      );
      _logMessageStateAfterNavigation(roomId, message);
    });
  }

  /// Navigate using Get.until to home
  void _navigateWithUntil(String roomId, RoomCollection room, MessageCollection? message) {
    try {
      Get.until((r) => r.settings.name == Routes.home);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(
          Routes.chatRoomDirect.replaceAll(':id', roomId),
          arguments: ChatRoomArguments(room: room, targetMessage: message),
        );
        _logMessageStateAfterNavigation(roomId, message);
      });
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Navigation error during Get.until', e, stackTrace);
      _navigateWithFallback(roomId, room, message);
    }
  }

  /// Fallback navigation when Get.until fails
  void _navigateWithFallback(String roomId, RoomCollection room, MessageCollection? message) {
    try {
      Get.offAllNamed(
        Routes.chatRoomDirect.replaceAll(':id', roomId),
        arguments: ChatRoomArguments(room: room, targetMessage: message),
      );
      _logMessageStateAfterNavigation(roomId, message);
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Fallback navigation also failed', e, stackTrace);
    }
  }

  /// Handle sub-screen stack cleanup
  void _handleSubScreenStack(String expectedRoute) {
    try {
      useLogger().d('[NotificationService] Cleaning up sub-screen stack to: $expectedRoute');
      Get.until((r) => r.settings.name == Routes.home || r.settings.name == expectedRoute);
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Navigation error during sub-screen stack cleanup', e, stackTrace);
    }
  }

  /// Log notification handled event
  void _logNotificationHandled(
    NotificationEntity notification,
    String roomId,
    Map<String, dynamic> data,
    int processingTimeMs,
  ) {
    final logger = GetIt.instance<NotificationLogger>();
    if (!logger.isEnabled) return;

    logger.logNotificationClicked(NotificationLogEntity(
      notificationId: notification.id,
      roomId: roomId,
      timestamp: DateTime.now(),
      logType: NotificationLogType.handled,
      notificationData: data,
      processingTimeMs: processingTimeMs,
    ));
  }

  /// Fetches messages from the server for a given room.
  /// TODO: Move to use 'use-case' from feature.
  Future<List<MessageCollection>?> _fetchMessages(String roomId) async {
    final stopwatch = Stopwatch()..start();

    // TODO: Waiting send last seq to OneSignal on server.
    // useLogger().d(
    //   'Seq from noti: $seq\n'
    //   'lastMessage?.seq = ${lastMessage?.seq}',
    // );

    // if (seq != null &&
    //     lastMessage?.seq != null &&
    //     lastMessage!.seq! < seq) {
    // END TODO

    try {
      final messageResp = await MessageService().fetchMessagesFromServer(
        roomId,
        timeout: const Duration(seconds: 1),
        onlyAfter: true,
      );

      stopwatch.stop();

      // Log fetch results
      final logger = GetIt.instance<NotificationLogger>();
      if (logger.isEnabled) {
        final log = NotificationLogEntity(
          notificationId: 'fetch-$roomId-${DateTime.now().millisecondsSinceEpoch}',
          roomId: roomId,
          timestamp: DateTime.now(),
          logType: NotificationLogType.received,
          notificationData: {
            'messageCount': messageResp?.messages?.length ?? 0,
            'fetchTime': stopwatch.elapsedMilliseconds,
          },
          messageCountInDb: messageResp?.messages?.length,
        );

        // Check for potential race condition
        if ((messageResp?.messages?.length ?? 0) == 0) {
          // Log empty fetch for debugging
          useLogger().w('[NotificationService] Empty message fetch received', {
            'roomId': roomId,
            'fetchTime': stopwatch.elapsedMilliseconds,
          });
        }

        logger.logNotificationReceived(log);
      }

      useLogger().d('[NotificationService] Found ${messageResp?.messages?.length} messages');
      return messageResp?.messages;
    } catch (e, stackTrace) {
      stopwatch.stop();

      // Log fetch error
      final logger = GetIt.instance<NotificationLogger>();
      if (logger.isEnabled) {
        logger.logNotificationReceived(NotificationLogEntity(
          notificationId: 'fetch-error-$roomId-${DateTime.now().millisecondsSinceEpoch}',
          roomId: roomId,
          timestamp: DateTime.now(),
          logType: NotificationLogType.error,
          notificationData: {
            'error': e.toString(),
            'stackTrace': stackTrace.toString(),
            'fetchTime': stopwatch.elapsedMilliseconds,
          },
        ));
      }

      useLogger().e('[NotificationService] Run fetchMessagesFromServer fail', e, stackTrace);
      return null;
    }

    // TODO: Waiting send last seq to OneSignal on server.
    // }
    // END TODO
  }

  /// Updates room subscription with the latest message if messages are available.
  /// TODO: Move to use 'use-case' from feature.
  Future<void> _updateRoomSubscription(RoomCollection room, List<MessageCollection>? messages) async {
    if (messages?.isNotEmpty == true) {
      try {
        final roomSub = await GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionWithRoomId(room.id!);
        if (messages?.firstOrNull != null) {
          final param = DecryptMessageTextParams(message: messages!.first.toEntity());
          roomSub?.lastMessage = (await GetIt.I<DecryptMessageTextUseCase>().call(param))?.toModel();
        }

        if (roomSub != null) {
          await GetIt.I<RoomSubscriptionDb>().putRoomSubscription(roomSub);
        }
      } catch (e, stackTrace) {
        useLogger().e('[NotificationService] Update room message subscription fail', e, stackTrace);
      }
    }
  }

  /// Logs message state after navigating to a chat room
  /// This helps debug race conditions by comparing database state with UI state
  Future<void> _logMessageStateAfterNavigation(String roomId, MessageCollection? targetMessage) async {
    try {
      final stopwatch = Stopwatch()..start();
      final logger = GetIt.instance<NotificationLogger>();

      if (!logger.isEnabled) {
        return;
      }

      useLogger().d('[NotificationService] Logging message state after navigation to room: $roomId');

      // Get 10 most recent messages from database
      List<MessageCollection> databaseMessages = [];
      int totalDatabaseCount = 0;

      try {
        final allDbMessages = await GetIt.I<MessageLocalRepository>().getAllSentMessage(
          roomId: roomId,
        );
        totalDatabaseCount = allDbMessages.length;

        // Take the 10 most recent messages (newest first)
        databaseMessages = allDbMessages.take(10).map((e) => e.toCollection()).toList();
      } catch (e) {
        useLogger().e('[NotificationService] Failed to fetch messages from database for message state logging', e);
      }

      // Get current UI messages (this will be available after the chat room is initialized)
      List<MessageCollection> uiMessages = [];
      int totalUiCount = 0;

      try {
        // Try to get the message list controller if it's already initialized
        final chatRoomTag = 'chat-room-$roomId';
        if (Get.isRegistered<MessageListController>(tag: chatRoomTag)) {
          final messageListController = Get.find<MessageListController>(tag: chatRoomTag);
          uiMessages = messageListController.messages.take(10).toList();
          totalUiCount = messageListController.messages.length;
        }
      } catch (e) {
        useLogger().d('[NotificationService] MessageListController not yet initialized, UI messages will be empty', e);
      }

      stopwatch.stop();

      // Create the message state log
      final messageStateLog = MessageStateEntity(
        roomId: roomId,
        timestamp: DateTime.now(),
        databaseMessages: databaseMessages,
        uiMessages: uiMessages,
        totalDatabaseMessageCount: totalDatabaseCount,
        totalUiMessageCount: totalUiCount,
        currentRoute: Get.currentRoute,
        isAppInForeground: lifeCycleService.isActive,
        fetchTimeMs: stopwatch.elapsedMilliseconds,
      );

      // Log the message state
      logger.logMessageState(messageStateLog);

      useLogger().d(
          '[NotificationService] Message state logged for room: $roomId, DB: $totalDatabaseCount, UI: $totalUiCount');
    } catch (e, stackTrace) {
      useLogger().e('[NotificationService] Failed to log message state', e, stackTrace);
    }
  }
}
