import 'dart:async';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/domain/use_cases/update_account_setting_use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingNotificationBId {
  static const String notificationPermissionBanner = 'notification_permission_banner';
}

class SettingNotificationController extends GetxController {
  static SettingNotificationController get instance => Get.find<SettingNotificationController>();
  static bool get isRegistered => Get.isRegistered<SettingNotificationController>();

  final UpdateAccountSettingUseCase updateAccountSettingUseCase;
  final isAllowNotification = true.obs;
  final isShowMessage = false.obs;

  StreamSubscription? _userUpdateSubscription;

  SettingNotificationController({
    required this.updateAccountSettingUseCase,
  });

  bool notificationNativePermission = false;

  @override
  void onInit() {
    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.accountSettings?.notification?.enabled != isAllowNotification() &&
          event.user.accountSettings?.notification?.enabled != null) {
        isAllowNotification(event.user.accountSettings?.notification?.enabled);
      }
      if (event.user.accountSettings?.notification?.hiddenMessage != isShowMessage() &&
          event.user.accountSettings?.notification?.hiddenMessage != null) {
        isShowMessage(event.user.accountSettings?.notification?.hiddenMessage);
      }
    });

    checkShowNoti();
    checkShowMessageInNoti();
    verifyNotificationNativePermission();

    super.onInit();
  }

  @override
  void onClose() async {
    await _userUpdateSubscription?.cancel();
    super.onClose();
  }

  Future<void> verifyNotificationNativePermission() async {
    final isGranted = await PermissionController.instance.hasNotificationPermission;
    notificationNativePermission = isGranted;
    update([SettingNotificationBId.notificationPermissionBanner]);
  }

  Future<void> requestNotificationNativePermission() async {
    await PermissionController.instance.checkNotificationPermission();
    await verifyNotificationNativePermission();
  }

  void handleBack() {
    Get.back();
  }

  void checkShowNoti() {
    isAllowNotification(
      UserController.instance.currentUser()?.accountSettings?.notification?.enabled ?? false,
    );
  }

  void checkShowMessageInNoti() {
    isShowMessage(
      UserController.instance.currentUser()?.accountSettings?.notification?.hiddenMessage ?? false,
    );
  }

  void updateNotificationSettings({bool? enabled, bool? hiddenMessage}) async {
    try {
      if (enabled == null && hiddenMessage == null) return;

      GetIt.I<TaxonomyService>().sendEvent(
        EventName.notificationUpdated,
        eventProperties: EventProperty.notificationUpdate(
          (enabled ?? isAllowNotification.value) ? 'enabled' : 'disabled',
        ),
      );
      await UChatLoading.show(status: 'Saving...'.tr);

      await updateAccountSettingUseCase.call(
        UpdateAccountSettingRequest.create(
          notification: NotificationSettingsModel(
            enabled: enabled ?? isAllowNotification.value,
            hiddenMessage: hiddenMessage ?? isShowMessage.value,
          ),
        ),
      );

      if (enabled != null) isAllowNotification.value = enabled;
      if (hiddenMessage != null) isShowMessage.value = hiddenMessage;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('updateNotificationSettings error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }
}
