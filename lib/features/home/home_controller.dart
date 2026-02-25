import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:uchat/api/payloads/last_seen_at/last_seen_at_payload.dart';
import 'package:uchat/api/services/last_seen_at_service.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/services/dialog_service.dart';
import 'package:uchat/core/domain/use_cases/get_all_users_use_case.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/screen_lag_contact_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_session_expired_account_use_case.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/accounts_center_arguments.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/quick_switch_bottom_sheet.dart';
import 'package:uchat/features/auth/presentation/arguments/welcome_arguments.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';
import 'package:uchat/features/central_notification/presentation/controller/central_notification_controller.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/vibrate.dart';

final _log = useLogger();

// const paneIndexStorageKey = 'pane_index_storage';
const paneIndexStorageConfigKey = 'HOME_PANE_INDEX';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  static HomeController get instance => Get.find<HomeController>();

  late AnimationController animationController;
  late AnimationController quickSwitchAnimationCtl;

  late final Worker paneIndexWorker;

  final configGeneral = ConfigDb().general;

  final paneIndex = 0.obs;
  final previousPaneIndex = 0.obs;
  final bounceTime = const Duration(seconds: 1);
  final bottomMenuLabelSize = 10.0.obs;

  CupertinoTabController? cupertinoController;
  StreamSubscription? _userLoggedOutSubscription;
  StreamSubscription? _centralNotiLastseenUpdate;

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  final contactCtl = Get.find<ContactsController>();
  final appSettingsController = Get.find<AppSettingsController>();
  final roomsController = Get.find<ChatListController>();
  final centralNotificationController = Get.find<CentralNotificationController>();

  bool isShowSplash = true;
  bool isShowUpdatingOverlay = false;
  bool enableTroubleshootEasyAccess = false;
  double? troubleshootEasyAccessX;
  double? troubleshootEasyAccessY;

  bool isUserTappedCentralNoti = false;

  final isShowPopupMenu = false.obs;
  final isShowQuickSwitch = false.obs;

  void showUpdatingOverlay(bool _isShowUpdatingOverlay) {
    isShowUpdatingOverlay = _isShowUpdatingOverlay;
    isShowSplash = true;
    update(['home-screen']);
  }

  void hideUpdatingOverlay() {
    isShowUpdatingOverlay = false;
    isShowSplash = false;
    update(['home-screen']);
  }

  void showSplash() {
    isShowSplash = true;
    update(['home-screen']);
  }

  void hideSplash() {
    if (!isShowUpdatingOverlay) {
      isShowSplash = false;
      update(['home-screen']);
      ScreenLagContactPerformanceService.mainTrace.stop();
    }
  }

  SettingMyProfileController get settingProfileController {
    if (!Get.isRegistered<SettingMyProfileController>()) {
      Get.put(SettingMyProfileController());
    }

    return Get.find<SettingMyProfileController>();
  }

  ChatListController get chatListController {
    return Get.find<ChatListController>();
  }

  final MultiSplitViewController multiViewController = MultiSplitViewController(
    areas: [
      Area(flex: 45),
      Area(flex: 55),
    ],
  );

  @override
  void onInit() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
    );
    quickSwitchAnimationCtl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
    );
    if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      cupertinoController = CupertinoTabController();
    }

    _centralNotiLastseenUpdate = eventBus.on<CentralNotificationLastSeenUpdateEvent>().listen(
      (event) async {
        await onPressToUpdateDateTime('socket');
      },
    );

    // Initialing custom input mode
    int paneIndexValue = await configGeneral.getIntWithDefault(
      key: paneIndexStorageConfigKey,
      defaultValue: 0,
    );

    // When previous show setting panel
    // force back to chat list.
    if (paneIndexValue == 4) {
      paneIndexValue = 1;
    }

    paneIndex(paneIndexValue);
    cupertinoController?.index = paneIndexValue;

    paneIndexWorker = ever<int>(
      paneIndex,
      (index) async {
        cupertinoController?.index = index;

        try {
          await configGeneral.saveConfig(
            key: paneIndexStorageConfigKey,
            value: index,
          );
        } catch (e, stackTrace) {
          _log.e(e.toString(), e, stackTrace);
        }

        if (index == 0 && UserController.instance.isLoggedIn) {
          EasyDebounce.debounce(
            'triggerUpdateFriendRequestGroupInviteCount',
            bounceTime,
            () async {
              eventBus.fire(RequireGroupInviteUpdateEvent());
              eventBus.fire(RequireFriendRequestUpdateEvent());
            },
          );
        }
      },
    );

    await onPressToUpdateDateTime('pressed');
    await loadEnableTroubleshootEasyAccess();

    super.onInit();
  }

  @override
  void onClose() async {
    _log.d('onClose');
    animationController.dispose();
    quickSwitchAnimationCtl.dispose();
    cupertinoController?.dispose();
    paneIndexWorker.dispose();
    await _userLoggedOutSubscription?.cancel();
    await _centralNotiLastseenUpdate?.cancel();

    super.onClose();
  }

  Future<void> onNavigationTapped(int index, [BuildContext? context]) async {
    eventBus.fire(CloseSlidablePanelEvent());
    eventBus.fire(CloseToastForceDeleteEvent());

    // _widgetPanes are arranged as follows:
    // 0: Contacts, 1: ChatList, 2: CallLog, 3: CentralNotification, 4: MyProfile
    if (index == 2) {
      isShowPopupMenu(false);
      animationController.reverse();
      // CallLog tab selected: refresh call log data.
      previousPaneIndex(index);
      paneIndex(index);
      // Retrieve the controller
      final callLogController = Get.find<CallLogScreenController>();
      await callLogController.loadInitial();
      callLogController.markCallLogsAsSeen();
    } else if (index == 3) {
      isUserTappedCentralNoti = true;
      isShowPopupMenu(false);
      animationController.reverse();
      paneIndex(index);
      centralNotificationController.updateNotificationCenterData();
      await onPressToUpdateDateTime('pressed');
    } else if (index == 4) {
      cupertinoController?.index = previousPaneIndex.value;

      if (!animationController.isCompleted) {
        //NOTE.open popup
        SchedulerBinding.instance.addPostFrameCallback((Duration _) {
          isShowPopupMenu(true);
          animationController.forward();
        });
      } else {
        //NOTE.close popup
        animationController.reverse().then((_) {
          isShowPopupMenu(false);
        });
      }
      settingProfileController.clearData();
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.myProfileDesktop);
    } else if (index == 5) {
      isShowPopupMenu(false);
      animationController.reverse();
      Get.back();
    } else {
      isShowPopupMenu(false);
      animationController.reverse();
      paneIndex(index);
      previousPaneIndex(index);
      cupertinoController?.index = index;

      appSettingsController.setRoutesSettingRightPanel(routes: '');
    }

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.pageViewed,
      eventProperties: EventProperty.pageViewedBottomNavBar(paneIndex: index),
      sendImmediately: true,
    );
  }

  Future<void> loadEnableTroubleshootEasyAccess() async {
    try {
      enableTroubleshootEasyAccess = await configGeneral.getBoolWithDefault(
        key: ConfigDb.getEnableTroubleshootEasyAccess(),
        defaultValue: false,
      );
    } catch (e) {
      _log.e('loadEnableTroubleshootEasyAccess error.', e);
    }

    try {
      troubleshootEasyAccessX = await configGeneral.getDouble(key: ConfigDb.getTroubleshootEasyAccessPositionX());
    } catch (e, stackTrace) {
      _log.e('load troubleshootEasyAccessX error.', e, stackTrace);
    }

    try {
      troubleshootEasyAccessY = await configGeneral.getDouble(key: ConfigDb.getTroubleshootEasyAccessPositionY());
    } catch (e, stackTrace) {
      _log.e('load troubleshootEasyAccessY error.', e, stackTrace);
    }

    useLogger().d(
      'Troubleshoot Easy Access: $enableTroubleshootEasyAccess, x: $troubleshootEasyAccessX, y: $troubleshootEasyAccessY',
    );
    update(['troubleshoot-easy-access']);
  }

  Future<void> saveTroubleshootEasyAccessPosition(double x, double y) async {
    EasyDebounce.debounce(
      'saveTroubleshootEasyAccessPosition',
      const Duration(milliseconds: 500),
      () async {
        await configGeneral.saveConfig(
          key: ConfigDb.getTroubleshootEasyAccessPositionX(),
          value: x,
        );

        await configGeneral.saveConfig(
          key: ConfigDb.getTroubleshootEasyAccessPositionY(),
          value: y,
        );

        useLogger().d('Save Troubleshoot Easy Access x: $x, y: $y');
      },
    );
  }

  Future<void> onPressToUpdateDateTime(String type) async {
    if (type == 'pressed') {
      if (paneIndex() == 3 && previousPaneIndex() != 3) {
        previousPaneIndex(3);

        await onUpdateTimeToServerAndDb();
      }
    } else if (type == 'socket') {
      if (paneIndex() == 3) {
        await onUpdateTimeToServerAndDb();
      }
    }
  }

  Future<void> onUpdateTimeToServerAndDb() async {
    try {
      final lastSeenAt = DateTime.now().toUtc();
      await ConfigDb().authenticated.saveConfig(key: notiLastReadAtKey, value: lastSeenAt);
      await ConfigDb().authenticated.saveConfig(key: notiUnreadCountKey, value: 0);

      CentralNotificationController.instance.notiUnreadCount(0);

      await LastSeenAtService().updateDateTimeToServer(LastSeenAtRequest(
        lastSeenNotificationAt: lastSeenAt.toIso8601String(),
      ));
    } catch (e) {
      _log.e('onUpdateTimeToServerAndDb error.', e);
    }
  }

  void resetPaneIndex() {
    onNavigationTapped(0);
  }

  void showQuickSwitchBottomSheet(BuildContext context) async {
    // Close popup menu if opened
    animationController.reverse().then((_) {
      isShowPopupMenu(false);
    });

    isShowQuickSwitch(true);
    quickSwitchAnimationCtl.forward();
    GetIt.I<VibrateUtil>().vibrateLight();
    final allUserList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams(
      sortByLoginAt: true,
    ));
    final index = allUserList.indexWhere((e) => UserController.instance.isCurrentUser(e.id ?? ''));
    if (index != -1) {
      final currentUser = allUserList.removeAt(index);
      allUserList.insert(0, currentUser);
    }

    Get.bottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      QuickSwitchBottomSheet(
        itemCount: allUserList.length,
        accountList: allUserList,
        onTapAddAccount: () {
          Get.back();
          Get.toNamed(Routes.welcome, arguments: WelcomeArguments(isAddAccount: true));
        },
        onTapAccount: (UserEntity user) async {
          if (UserController.instance.isCurrentUser(user.id ?? '')) {
            // If user tap on current account, just close the bottom sheet.
            Get.back();
            return;
          }
          Get.back();
          final bottomMargin = kBottomNavigationBarHeight + AppSpace.space2;
          showSplash();
          await GetIt.I<AccountsCenterService>().switchAccount(
            user,
            bottomMargin: bottomMargin,
            showLoading: false,
          );
          hideSplash();
        },
      ),
    ).then((_) {
      quickSwitchAnimationCtl.reverse().then((_) {
        isShowQuickSwitch(false);
      });
    });

    final res = await GetIt.I<GetSessionExpiredAccountUseCase>().call(
      GetSessionExpiredAccountParams(userList: allUserList),
    );
    if (res.visibleExpiredAccounts.isNotEmpty || res.expiredHiddenAccountCount > 0) {
      GetIt.I<DialogService>().showSessionExpireDialog(customOnConfirm: () {
        // Close session expired dialog and bottom sheet.
        Get.close(2);
        Get.toNamed(Routes.accountsCenter, arguments: AccountsCenterArguments(sessionExpiredAccountResponse: res));
      });
    }
  }
}
