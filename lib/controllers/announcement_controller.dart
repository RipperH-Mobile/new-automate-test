import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/dialog/announcement/announcement_dialog.dart';
import 'package:uchat/widgets/dialog/announcement/maintenance_dialog.dart';

final _log = useLogger();
const anmLastGetAtConfigKey = 'ANNOUNCEMENT_LAST_GET_AT';

class AnnouncementController extends FullLifeCycleController {
  static AnnouncementController get instance => Get.find();

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  final announcementList = <AnnouncementCollection>[];

  final lang = Get.locale?.languageCode ?? 'EN';

  StreamSubscription? _passcodeCheckedSub;
  StreamSubscription? _startAnnouncementSub;

  final isAnnouncementDialogShow = false.obs;
  final isMaintenanceDialogShow = false.obs;
  final isShowed = <String>[].obs;
  final isNotShowTodayCheck = false.obs;

  PageController? anmPageController;
  final anmCurrentPage = 0.obs;

  final configAuthenticated = ConfigDb().authenticated;
  final _announcementMemo = AsyncMemoizer();
  final _announcementCache = AsyncCache<void>.ephemeral();
  final _startAnnounceCache = AsyncCache<void>.ephemeral();

  @override
  void onInit() async {
    _passcodeCheckedSub = eventBus.on<PasscodeCheckedEvent>().listen(
      (event) async {
        // Do not show announcement in login welcome screen because it will be replaced with
        // home screen when sync is completed. startAnnounce is called in LoginWelcomeController instead.
        if (Get.currentRoute != Routes.loginWelcome) {
          await fetchAnnouncementAndShow();
        }
      },
    );

    _startAnnouncementSub = eventBus.on<StartAnnouncementEvent>().listen(
      (event) async {
        _log.d('Current route: ${Get.currentRoute} == ${Routes.home}');

        if (!Get.currentRoute.contains('/passcode')) {
          await startAnnounce();
        } else {
          eventBus.fire(PasscodeActivateEvent(
            callback: () {
              eventBus.fire(PasscodeCheckedEvent());

              if (Get.currentRoute.contains('/passcode')) {
                final routeCheckList = ['', '/', Routes.splash];
                if (!routeCheckList.contains(Get.previousRoute)) {
                  Get.back();
                } else {
                  Get.offAllNamed(Routes.home);
                }
              }
            },
          ));
        }
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    _passcodeCheckedSub?.cancel();
    _startAnnouncementSub?.cancel();
    super.onClose();
  }

  Future<void> fetchAnnouncementAndShow() async {
    if (UserController.instance.currentUser.value == null) {
      return;
    }

    await _announcementMemo.runOnce(() async {
      await updateAnnouncementFromServer();
      await startAnnounce();
    });
  }

  Future<void> startAnnounce() async {
    await _startAnnounceCache.fetch(() async {
      try {
        await _startAnnounce();
      } catch (e, stackTrace) {
        _log.e('Announcement show dialog error.', e, stackTrace);
      }
    });
  }

  Future<void> _startAnnounce() async {
    final maintenanceData = await AnnouncementDb().getMaintenance();
    final announcements = await AnnouncementDb().getAnnouncement();
    announcementList.addAll(announcements);

    if (isMaintenanceDialogShow() || isAnnouncementDialogShow() || AppController.instance.maintenanceError.isNotEmpty) {
      return;
    }

    // _log.d(
    //   '[startAnnounce]\n'
    //   '${!connectivityCtl.isTrulyOffline}\n'
    //   '[announcementList]\n'
    //   '$announcementList',
    // );

    announcementList.removeWhere((element) {
      final notShowToday = element.dontShowToday?.isSameDay(DateTime.now());
      if (notShowToday == true) {
        return true;
      }

      if (element.id != null) {
        return isShowed.contains(element.id);
      }

      return false;
    });

    int milliseconds = 1200;

    if (maintenanceData != null) {
      _log.d('Show maintenance');
      await Future.delayed(Duration(milliseconds: milliseconds), () async {
        await showMaintenanceDialog(announcement: maintenanceData);
      });
      milliseconds = 500;
    }

    if (announcementList.isNotEmpty) {
      _log.d('Show announcement');
      await Future.delayed(Duration(milliseconds: milliseconds), () async {
        await showAnnouncementDialog(announcementList: announcementList);
      });
    }
  }

  Future<void> updateAnnouncementFromServer() async {
    if (UserController.instance.currentUser.value == null) {
      return;
    }

    await _announcementCache.fetch(() async {
      try {
        await _updateAnnouncementFromServer();
      } catch (e, stackTrace) {
        _log.e('Update announcement from server error.', e, stackTrace);
      }
    });
  }

  Future<void> _updateAnnouncementFromServer() async {
    _log.d('updateAnnouncementFromServer');
    try {
      final lastGetAt = await configAuthenticated.getDateTime(
        key: anmLastGetAtConfigKey,
      );

      final response = await AnnouncementService().getAvailableAnnouncement(
        GetAvailableAnnouncementRequest(lastGetAt: lastGetAt),
      );

      if (response != null && response.isNotEmpty) {
        await configAuthenticated.saveConfig(key: anmLastGetAtConfigKey, value: DateTime.now());
        await AnnouncementDb().putAnnouncements(announcements: response);
      }
    } catch (e, stackTrace) {
      _log.d('Call updateAnnouncementFromServer error.', e, stackTrace);
    }
  }

  Future<void> showAnnouncementDialog({
    required List<AnnouncementCollection> announcementList,
  }) async {
    for (final announcement in announcementList) {
      if (announcement.id != null) {
        isShowed.add(announcement.id!);
      }
    }

    if (announcementList.isNotEmpty) {
      isAnnouncementDialogShow(true);
      anmPageController = PageController();
      Get.dialog(
        const AnnouncementDialog(),
        barrierDismissible: false,
      ).then((_) {
        anmPageController?.dispose();
        anmPageController = null;
        isAnnouncementDialogShow(false);
      });
    }
  }

  Future<void> showMaintenanceDialog({
    required AnnouncementCollection announcement,
  }) async {
    isMaintenanceDialogShow(true);
    await Get.dialog(
      MaintenanceDialog(
        isAnnouncement: true,
        maintenanceText: announcement.text
                ?.firstWhereOrNull(
                    (element) => element.lang?.toLowerCase() == (Get.locale?.languageCode.toLowerCase() ?? 'en'))
                ?.data ??
            '',
      ),
      barrierDismissible: false,
    );
    isMaintenanceDialogShow(false);
  }

  void handleToggleCheckBox(bool? isCheck) async {
    isNotShowTodayCheck(isCheck ?? false);

    for (final announcement in announcementList) {
      announcement.dontShowToday = isNotShowTodayCheck.value ? DateTime.now() : null;
    }

    await AnnouncementDb().putAnnouncements(announcements: announcementList);
  }

  void onAnmPageChange(int page) {
    anmCurrentPage(page);
  }

  void onUserLoggedOutOrBeforeSwitch() {
    isShowed.clear();
  }
}
