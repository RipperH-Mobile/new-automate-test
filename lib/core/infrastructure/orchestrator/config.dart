import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/controllers/real_time_database_controller.dart';
import 'package:uchat/core/di/analytic_injection.dart';
import 'package:uchat/core/domain/services/app_version_service.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/notification/notification_manager.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/features/accounts_center/accounts_center_barrel.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/features/central_notification/presentation/central_notification_presentation.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room_list/presentation/chat_room_list_presentation.dart';
import 'package:uchat/features/contact/domain/use_cases/repair_contacts_without_phone_number_use_case.dart';
import 'package:uchat/features/home/home_barrel.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/features/sync/data/data_source/remote/firebase_realtime_database_service.dart';
import 'package:uchat/features/sync/domain/sync_domain.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';
import 'package:uchat/screens/setting_notification/setting_notification_controller.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../../domain/enums/passcode_result.dart';
import '../analytics/crashlytics_service.dart';
import 'common/task_group.dart';
import 'common/task_result.dart';
import 'common/typedef.dart';
import 'navigation/navigation_coordinator.dart';
import 'orchestrator.dart';
import 'tasks/factory_dependencies.dart';
import 'tasks/initialize_analytic.dart';
import 'tasks/initialize_app.dart';
import 'tasks/launch_app.dart';
import 'tasks/on_authenticated.dart';
import 'tasks/permanent_controller.dart';
import 'tasks/singleton_dependencies.dart';

final OrchestratorTasks tasks = {
  //
  // ---------------------------------------------------------------------
  // App Start up Section
  // ---------------------------------------------------------------------
  //

  //
  // Initialize app
  // When: Run before [runApp()] in main.dart, first of everything.
  //
  // - For singleton dependencies initialize first, then it can be used with other places where it needs to be used.
  // - For factory dependencies, Is centralized place to register all factory dependencies.
  //
  // Don't need to edit if you don't need to change the default behavior.
  //
  OrchestratorTaskType.initializeApp: [
    // Keep this task at the beginning, because it initializes the logger.
    OrchestratorTask(
      id: 'initialize-app-begin',
      tasks: [initializeAppBegin],
    ),
    // Task for initializing 3rd party libraries.
    OrchestratorTask(
      id: 'initialize-app-core',
      tasks: [initializeAppCore],
    ),
    // Register analytic needs to be done after env is loaded in initializeAppCore.
    OrchestratorTask(
      id: 'register-analytics',
      tasks: [registerAnalytic],
    ),

    OrchestratorTask(
      id: 'register-singleton-dependencies',
      tasks: [registerSingletonDependencies],
    ),
    OrchestratorTask(
      id: 'register-factory-dependencies',
      tasks: [registerFactoryDependencies],
    ),
    OrchestratorTask(
      id: 'manage-legacy-dependencies',
      tasks: [registerPermanentController],
    ),

    OrchestratorTask(
      id: 'initialize-singleton-dependencies',
      tasks: [initializeSingletonDependencies],
    ),
    OrchestratorTask(
      id: 'launch-app-check-app-version',
      tasks: [
        () async {
          await GetIt.I<AppVersionService>().checkUpdate(timeout: const Duration(microseconds: 100));
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'initialize-analytics',
      tasks: [
        () async {
          initializeLoggerSingletonDependencies();
          return await initializeAnalytic();
        }
      ],
    ),
  ],

  //
  // Launch app
  // When: Run after [runApp()] in main.dart, before the app is shown to the user.
  //
  OrchestratorTaskType.launchApp: [
    OrchestratorTask(
      id: 'launch-app-begin',
      tasks: [
        () => launchAppBegin(),
      ],
    ),

    OrchestratorTask(
      id: 'launch-calling',
      tasks: [
        () async {
          UChatCallController.instance.initCall();
          return TaskResult.skip;
        },
      ],
    ),

    // Passcode task, run after the app is launched.
    // This task is responsible for initializing the security service and handling authentication.
    // It will show the passcode screen if the user is logged in and has a passcode set.
    OrchestratorTask(
      id: 'launch-app-passcode-initialize',
      tasks: [
        () async {
          await GetIt.I<SecurityService>().initialize();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'launch-app-passcode-auth',
      condition: () => GetIt.I<AccountsCenterService>().haveAccount,
      tasks: [
        () async {
          await GetIt.I<SecurityService>().onAuthenticated();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'launch-app-passcode-screen',
      condition: () => GetIt.I<AccountsCenterService>().haveAccount,
      tasks: [
        () async {
          final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen(
            onShowed: () {
              // WidgetsBinding.instance.addPostFrameCallback((_) async {
              //   await Orchestrator.run(OrchestratorTaskType.onAuthenticated);
              //   HomeController.instance.hideSplash();
              // });
            },
            isFirstRouteToCalled: GetIt.I<NavigationCoordinator>().firstRouteToIsCalled,
          );
          useLogger().d('ZZZ => launch-app-passcode-screen -> Passcode result: $result');
          GetIt.I<SecurityService>().activatePreventTap();

          if (result == PasscodeResult.unlocked || result == PasscodeResult.passed) {
            return TaskResult.next;
          }

          return TaskResult.stop;
        }
      ],
    ),

    // Run the first route to navigate to the main page.
    // Or route to the right page based on user interaction.
    OrchestratorTask(
      id: 'launch-app-initialize-first-route',
      tasks: [
        () async {
          await GetIt.I<NavigationCoordinator>().firstRouteTo();
          return TaskResult.next;
        },
      ],
    ),

    // Task for checking if the user is logged in.
    // If the user is logged in, run the authenticated tasks.
    OrchestratorTask(
      id: 'launch-app-finalize',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () async {
          Orchestrator.run(OrchestratorTaskType.onAuthenticated);

          return TaskResult.next;
        },
      ],
    ),

    // Mark notification manager as ready to process pending notifications
    // This must happen after firstRouteTo to ensure navigation stack is ready
    OrchestratorTask(
      id: 'launch-app-notification-ready',
      tasks: [
        () async {
          await GetIt.I<NotificationManager>().markAppReady();
          return TaskResult.next;
        },
      ],
    ),

    // After app launch and splash screen is hidden,
    // if call is active, open the call screen.
    OrchestratorTask(
      id: 'launch-call-screen',
      tasks: [
        () async {
          UChatCallController.instance.callCtlList.firstOrNull?.openCallScreen();
          return TaskResult.skip;
        },
      ],
    ),

    // Other tasks that need to be run after the splash screen is hidden.
    OrchestratorTask(
      id: 'launch-app-other',
      tasks: [
        () async {
          AppController.instance.initGoogleMap();
          return TaskResult.next;
        },
        () async {
          AppSettingsController.instance.initPackageInfo();
          return TaskResult.next;
        },
        () async {
          await AppSettingsController.instance.fetchPublicConfig();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'launch-app-clear-notification',
      tasks: [
        () async {
          await GetIt.I<NotificationManager>().clearAllNotifications();
          return TaskResult.next;
        }
      ],
    ),
    OrchestratorTask(
      id: 'launch-app-check-and-notify-update',
      runParallel: false,
      tasks: [
        () async {
          await GetIt.I<AppVersionService>().checkUpdate();
          await GetIt.I<AppVersionService>().notifyUpdate();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'launch-app-check-fetch-announcement',
      runParallel: false,
      tasks: [
        () async {
          await AnnouncementController.instance.fetchAnnouncementAndShow();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // ---------------------------------------------------------------------
  // Authenticate Section
  // ---------------------------------------------------------------------
  //

  //
  // On authenticated
  // When: Run after the user is authenticated, when user information loaded to the [UserController].
  //
  OrchestratorTaskType.onAuthenticated: [
    OrchestratorTask(
      id: 'on-authenticated-begin',
      runParallel: false,
      tasks: [
        () => onAuthenticated(),
        () async {
          if (!UserController.instance.useFirebaseState) {
            GetIt.I<SyncService>().addSyncQueue();
          }
          return TaskResult.next;
        },
        () {
          GetIt.I<TaxonomyService>().onAuthenticated(
            UserController.instance.currentUser.value,
            officialAccountNumber: ContactsController.instance.officialAccountList.length,
            friendNumber: ContactsController.instance.friendList.length,
            groupNumber: ContactsController.instance.groupList.length,
          );
          return TaskResult.next;
        },
        () {
          StickerController.instance.initCurrentUserSticker();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-initialize',
      tasks: [
        () async {
          await ManageChatController.instance.initialize();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-local-setup',
      tasks: [
        () async {
          ConnectivityController.instance.onUserLoaded();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<NotificationManager>().onAuthenticated();
          return TaskResult.next;
        },
        () async {
          await AudioController.instance.setupAudioPlayer();
          return TaskResult.next;
        },
        () async {
          PermissionController.instance.initAndroidInfo();
          return TaskResult.next;
        },
        () async {
          await SubscriptionController.instance.onInitSubscriptionData();
          return TaskResult.next;
        },
        () async {
          InAppPurchaseController.instance.initInAppPurchase();
          return TaskResult.next;
        },
        () async {
          UserController.instance.onUserLoaded();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<CrashlyticsService>().onUserLoaded();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<StickerDownloaderService>().initializeDirectory(
            userId: UserController().currentUser()?.id ?? '',
          );
          return TaskResult.next;
        },
        () async {
          await GetIt.I<MarkSendingMessagesAsFailedUseCase>().call();
          return TaskResult.next;
        }
      ],
    ),
    OrchestratorTask(
      id: 'init-firebase-realtime-database-for-authenticated-user',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () async {
          await GetIt.I<FirebaseRealtimeDatabaseService>().checkIsLoggedInToFirebase();

          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-connect-init-online-users-realtime-database',
      tasks: [
        () {
          RealTimeDatabaseController.instance.onInitOnlineStatusUser();

          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'init-firebase-realtime-database-for-state',
      condition: () => UserController.instance.useFirebaseState && UserController.instance.isLoggedIn,
      tasks: [
        () {
          GetIt.I<FirebaseRealtimeDatabaseService>().initListener();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-fetch-update',
      tasks: [
        () async {
          await UChatCallNativeMethodChanel.instance.triggerUpdateVoipUser();
          return TaskResult.next;
        },
        () {
          GetIt.I<SyncService>().startNetworkMonitor();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-premium-review',
      tasks: [
        () {
          AppController.instance.showDialogReviewPremium();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-reason-refund',
      tasks: [
        () async {
          UserController.instance.fetchPendingRefundReasons();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-start-heartbeat-and-monitoring',
      tasks: [
        () {
          HttpCaller.instance.heartbeat.startHeartbeatSystem();
          return TaskResult.next;
        },
        () {
          SocketCaller.instance.monitoring.startMonitoringSystem();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-update-draft-message',
      tasks: [
        () {
          GetIt.I<UpdateDraftMessageUseCase>().call(NoParams());
          return TaskResult.next;
        }
      ],
    ),
    OrchestratorTask(
      id: 'on-authenticated-fetch-announcement-after-auth-done',
      tasks: [
        () async {
          await AnnouncementController.instance.fetchAnnouncementAndShow();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // On unauthenticated
  // When: Run when the user is logged out, when user information is cleared from the [UserController].
  //
  OrchestratorTaskType.onUnAuthenticated: [
    OrchestratorTask(
      id: 'on-unauthenticated',
      tasks: [
        () {
          GetIt.I<SyncService>().disposeSyncProcess();
          return TaskResult.next;
        },
        () {
          GetIt.I<FirebaseRealtimeDatabaseService>().onClearListener();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<NotificationManager>().onUnauthenticated();
          return TaskResult.next;
        },
        () {
          ChatListController.instance.onUserLoggedOutOrBeforeSwitch();
          return TaskResult.next;
        },
        () {
          ContactsController.instance.onUserLoggedOutOrBeforeSwitch();
          return TaskResult.next;
        },
        () {
          StickerController.instance.onUserLoggedOutOrBeforeSwitch();
          return TaskResult.next;
        },
        () {
          AnnouncementController.instance.onUserLoggedOutOrBeforeSwitch();
          return TaskResult.next;
        },
        () {
          CentralNotificationController.instance.onUserLoggedOutOrBeforeSwitch();
          return TaskResult.next;
        },
        () {
          HomeController.instance.resetPaneIndex();
          return TaskResult.next;
        },
        () async {
          await UChatCallNativeMethodChanel.instance.removeOneSignalUser();
          return TaskResult.next;
        },
        () {
          HttpCaller.instance.heartbeat.stopHeartBeating();
          return TaskResult.next;
        },
        () {
          SocketCaller.instance.monitoring.stopMonitoringSystem();
          return TaskResult.next;
        },
        () {
          GetIt.I<TaxonomyService>().onUnauthenticated();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // On unauthenticated for normal account
  // When: Run when the user is logged out, when user information is cleared from the [UserController].
  // This is for normal account, not debug account.
  // It's mean run every time when user logged out.
  //
  OrchestratorTaskType.onUnAuthenticatedForNormalAccount: [
    OrchestratorTask(
      id: 'on-unauthenticated-for-normal-account',
      tasks: [
        () async {
          await GetIt.I<SyncService>().clearAllCurrentStateSeq();
          return TaskResult.next;
        },
        () {
          CentralNotificationController.instance.onUserLoggedOut();
          return TaskResult.next;
        },
        () async {
          await UserController.instance.clearAllAboutUserData();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // ---------------------------------------------------------------------
  // Network Connection Section
  // ---------------------------------------------------------------------
  //

  OrchestratorTaskType.onSocketConnected: [
    OrchestratorTask(
      id: 'on-socket-connected-sync-state',
      condition: () => SocketCaller.instance.reconnectCount > 0 && !UserController.instance.useFirebaseState,
      tasks: [
        () {
          GetIt.I<SyncService>().addSyncQueue();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-socket-connected-fetch-update',
      tasks: [
        () {
          ChatListController.instance.onSocketConnected();
          return TaskResult.next;
        },
        () async {
          CentralNotificationController.instance.updateNotificationCenterData();
          return TaskResult.next;
        },
        () async {
          await ContactsController.instance.fetchFriendRequestList();
          return TaskResult.next;
        },
        () async {
          await ContactsController.instance.fetchGroupInviteList();
          return TaskResult.next;
        },
        () {
          ContactsController.instance.updateAllFriendLastSeen();
          return TaskResult.next;
        },
        () async {
          await PremiumPackagesStoreController.instance.fetchPremiumPackage();
          return TaskResult.next;
        },
        () async {
          await AppSettingsController.instance.fetchPublicConfig();
          return TaskResult.next;
        },
        () {
          StickerController.instance.initCurrentUserSticker();
          return TaskResult.next;
        },
        () {
          UserController.instance.fetchPendingRefundReasons();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<RepairContactsWithoutPhoneNumberUseCase>().call();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-socket-connected-in-app-purchase',
      tasks: [
        // () {
        //   InAppPurchaseController.instance.verifyAllPendingPurchase();
        //   return TaskResult.next;
        // },
        () {
          InAppPurchaseController.instance.setCurrentSubscriptionProductId();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-socket-connected-check-connection-quality',
      tasks: [
        () {
          ConnectivityController.instance.handleCheckConnectionQuality();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // ---------------------------------------------------------------------
  // Lifecycle Section
  // ---------------------------------------------------------------------
  //

  //
  // On app resumed
  // When: Run when the app is resumed, when the app is in foreground.
  //
  // For example: When app is resumed, start all the services that are needed.
  //
  OrchestratorTaskType.onAppResumed: [
    OrchestratorTask(
      id: 'on-app-resumed-security-passcode',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () async {
          final result = await GetIt.I<SecurityService>().showVerifyPasscodeScreen(onShowed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              useLogger().d('ZZZ => hide protection screen');
              GetIt.I<SecurityService>().hideProtectionScreen();
            });
          });

          useLogger().d('ZZZ => on-app-resumed-security-passcode -> Passcode result: $result');
          useLogger().d('ZZZ => hide protection screen 2');
          GetIt.I<SecurityService>().hideProtectionScreen();
          GetIt.I<SecurityService>().activatePreventTap();

          if (result == PasscodeResult.unlocked) {
            return TaskResult.next;
          }

          return TaskResult.stop;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-app-resumed-network-monitor',
      tasks: [
        () {
          GetIt.I<HttpCaller>().heartbeat.startHeartbeatSystem();
          return TaskResult.next;
        },
        () {
          GetIt.I<SocketCaller>().monitoring.startMonitoringSystem();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-app-resumed-socket-connect',
      condition: () => !GetIt.I<SocketCaller>().isConnected && UserController.instance.isLoggedIn,
      tasks: [
        () {
          GetIt.I<SocketCaller>().reconnect();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-app-resumed-sync-state',
      condition: () => UserController.instance.isLoggedIn,
      runParallel: false,
      tasks: [
        () {
          GetIt.I<SyncService>().addSyncQueue();
          return TaskResult.next;
        },
        () {
          GetIt.I<SyncService>().startNetworkMonitor();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-app-resumed-check-update',
      runParallel: false,
      tasks: [
        () async {
          await GetIt.I<AppVersionService>().checkUpdate();
          return TaskResult.next;
        },
        () async {
          await GetIt.I<AppVersionService>().notifyUpdate();
          return TaskResult.next;
        },
        () async {
          await AnnouncementController.instance.fetchAnnouncementAndShow();
          return TaskResult.next;
        },
      ],
    ),
    OrchestratorTask(
      id: 'on-app-resumed-main',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () {
          MediaViewerService.instance.onAppResumed();
          return TaskResult.next;
        },
        () {
          ContactsController.instance.checkImportantPermission();
          return TaskResult.next;
        },
        () {
          if (SettingNotificationController.isRegistered) {
            SettingNotificationController.instance.verifyNotificationNativePermission();
          }
          return TaskResult.next;
        },
        () async {
          await GetIt.I<NotificationManager>().onAppResumed();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // On app paused
  // When: Run when the app is paused, when the app is in background.
  //
  // For example: When app is paused, stop all the services that are not needed.
  // This is to save battery and resources.
  //
  OrchestratorTaskType.onAppPaused: [
    OrchestratorTask(
      id: 'on-app-paused',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () {
          GetIt.I<HttpCaller>().heartbeat.stopHeartBeating();
          return TaskResult.next;
        },
        () {
          GetIt.I<SocketCaller>().monitoring.stopMonitoringSystem();
          return TaskResult.next;
        },
        () {
          GetIt.I<SyncService>().stopNetworkMonitor();
          return TaskResult.next;
        },
        () {
          GetIt.I<NotificationManager>().onAppPaused();
          return TaskResult.next;
        }
      ],
    ),
  ],

  //
  // On app inactive
  // When: Run when the app is inactive, when the app is in background and not visible to the user.
  //
  OrchestratorTaskType.onAppInactive: [
    OrchestratorTask(
      id: 'on-app-inactive',
      condition: () => UserController.instance.isLoggedIn,
      tasks: [
        () {
          GetIt.I<SecurityService>().showProtectionScreen();
          return TaskResult.next;
        },
        () {
          GetIt.I<SecurityService>().onAppInactive();
          return TaskResult.next;
        },
      ],
    ),
  ],

  //
  // ---------------------------------------------------------------------
  // Other Section
  // ---------------------------------------------------------------------
  //

  OrchestratorTaskType.onSyncInitBeforeWriteToDb: [
    OrchestratorTask(
      id: 'on-sync-init-before-write-to-db',
      tasks: [
        () {
          ChatListController.instance.onSyncInitBeforeWriteToDb();
          return TaskResult.next;
        },
      ],
    ),
  ],

  OrchestratorTaskType.onSyncInitAfterWriteToDb: [
    OrchestratorTask(
      id: 'on-sync-init-after-write-to-db',
      tasks: [
        () {
          ChatListController.instance.onSyncInitAfterWriteToDb();
          return TaskResult.next;
        },
        () {
          ContactsController.instance.onSyncInitAfterWriteToDb();
          return TaskResult.next;
        },
        () {
          HomeController.instance.hideSplash();
          return TaskResult.next;
        }
      ],
    ),
  ]
};
