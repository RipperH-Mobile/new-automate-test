import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingFriendsController extends GetxController {
  final isMobile = UChatScreenUtil.instance.isMobile;

  final isAllowAddFriendsByPhoneNumber = true.obs;
  final isAllowAddFriendsByUsername = true.obs;
  final isAllowGroupMembersToAddFriends = true.obs;

  StreamSubscription? _userUpdateSubscription;

  AppSettingsController get appSettingsController => Get.find<AppSettingsController>();

  @override
  void onInit() {
    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.accountSettings?.friend?.allowFriendAdd?.canAddByPhoneNumber != isAllowAddFriendsByPhoneNumber() &&
          event.user.accountSettings?.friend?.allowFriendAdd?.canAddByPhoneNumber != null) {
        isAllowAddFriendsByPhoneNumber(event.user.accountSettings?.friend?.allowFriendAdd?.canAddByPhoneNumber);
      }
      if (event.user.accountSettings?.friend?.allowFriendAdd?.canAddByUsername != isAllowAddFriendsByUsername() &&
          event.user.accountSettings?.friend?.allowFriendAdd?.canAddByUsername != null) {
        isAllowAddFriendsByUsername(event.user.accountSettings?.friend?.allowFriendAdd?.canAddByUsername);
      }
      if (event.user.accountSettings?.friend?.allowFriendAdd?.canAddFromGroup != isAllowGroupMembersToAddFriends() &&
          event.user.accountSettings?.friend?.allowFriendAdd?.canAddFromGroup != null) {
        isAllowGroupMembersToAddFriends(event.user.accountSettings?.friend?.allowFriendAdd?.canAddFromGroup);
      }
    });

    checkAllowAddByPhoneNumber();
    checkAllowAddByUsername();
    checkAllowGroupMembersToAddFriends();
    super.onInit();
  }

  @override
  void onClose() async {
    await _userUpdateSubscription?.cancel();
    super.onClose();
  }

  void handleBack() {
    Get.back();
  }

  void checkAllowAddByPhoneNumber() {
    isAllowAddFriendsByPhoneNumber(
      UserController.instance.currentUser()?.accountSettings?.friend?.allowFriendAdd?.canAddByPhoneNumber ?? true,
    );
  }

  void checkAllowAddByUsername() {
    isAllowAddFriendsByUsername(
      UserController.instance.currentUser()?.accountSettings?.friend?.allowFriendAdd?.canAddByUsername ?? true,
    );
  }

  void checkAllowGroupMembersToAddFriends() {
    isAllowGroupMembersToAddFriends(
      UserController.instance.currentUser()?.accountSettings?.friend?.allowFriendAdd?.canAddFromGroup ?? true,
    );
  }

  void handleToggleAllowAddFriend(bool? value) async {
    try {
      if (value == null) return;
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickAllowToAddFriend,
          eventProperties: EventProperty.clickAllowToAddFriend(value ? 'enabled' : 'disabled'));
      await UChatLoading.show(status: 'Saving...'.tr);

      await AccountService.instance.updateAccountSetting(
        UpdateAccountSettingRequest.create(
          friend: FriendSettingsModel(
            allowFriendAdd: AllowFriendAddModel(
              canAddByPhoneNumber: value,
              canAddByUsername: value,
              canAddFromGroup: value,
            ),
          ),
        ),
      );
      isAllowAddFriendsByUsername.value = value;
      isAllowAddFriendsByPhoneNumber.value = value;
      isAllowGroupMembersToAddFriends.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleAllowAddFriend error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleToggleAllowAddFriendByPhoneNumber(bool? value) async {
    try {
      if (value == null) return;
      await UChatLoading.show(status: 'Saving...'.tr);

      await AccountService.instance.updateAccountSetting(
        UpdateAccountSettingRequest.create(
          friend: FriendSettingsModel(
            allowFriendAdd: AllowFriendAddModel(
              canAddByPhoneNumber: value,
            ),
          ),
        ),
      );

      isAllowAddFriendsByPhoneNumber.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleAllowAddFriendByPhoneNumber error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleToggleAllowGroupMemberToAddFriends(bool? value) async {
    try {
      if (value == null) return;
      await UChatLoading.show(status: 'Saving...'.tr);

      await AccountService.instance.updateAccountSetting(
        UpdateAccountSettingRequest.create(
          friend: FriendSettingsModel(
            allowFriendAdd: AllowFriendAddModel(canAddFromGroup: value),
          ),
        ),
      );
      isAllowGroupMembersToAddFriends.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleAllowGroupMemberToAddFriends error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleHiddenAccount() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickHiddenAccount);
    if (isMobile) {
      Get.toNamed(Routes.settingFriendHidden);
    } else {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingFriendHidden);
    }
  }

  void handleBlockAccount() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickBlockedAccount);
    if (isMobile) {
      Get.toNamed(Routes.settingFriendBlock);
    } else {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingFriendBlock);
    }
  }
}
