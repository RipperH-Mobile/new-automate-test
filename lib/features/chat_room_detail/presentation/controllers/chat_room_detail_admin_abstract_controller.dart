import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ChatRoomDetailAdminAbstractController extends GetxController {
  final TextEditingController customTitleController = TextEditingController();

  bool setGroupPermissionsValue = true;
  bool changeGroupInfoValue = true;
  bool pinMessagesValue = true;
  bool deleteOtherMessagesValue = true;
  bool groupMemberSettingValue = true;
  bool muteMembersValue = true;
  bool enableDisableSlowModeValue = true;
  bool groupTypeInviteLinkSetting = true;

  String customTitleErrorMsg = '';

  void onBackPressed(BuildContext context) {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Discard Edit'.tr,
      description: 'Are you sure you want to discard your changes?',
      onConfirm: () {
        Get.back();
      },
      cancelTextColor: context.theme.appColors.textLight,
      confirmTextColor: context.theme.appColors.textPrimary,
    );
  }

  void onSetGroupPermissionsChanged(bool? value) {
    setGroupPermissionsValue = value ?? false;
  }

  void onChangeGroupInfoChanged(bool? value) {
    changeGroupInfoValue = value ?? false;
  }

  void onPinMessagesChanged(bool? value) {
    pinMessagesValue = value ?? false;
  }

  void onDeleteOtherMessagesChanged(bool? value) {
    deleteOtherMessagesValue = value ?? false;
  }

  void onGroupMemberSettingChanged(bool? value) {
    groupMemberSettingValue = value ?? false;
  }

  void onMuteMembersChanged(bool? value) {
    muteMembersValue = value ?? false;
  }

  void onEnableDisableSlowModeChanged(bool? value) {
    enableDisableSlowModeValue = value ?? false;
  }

  void onGroupTypeInviteLinkSettingChanged(bool? value) {
    groupTypeInviteLinkSetting = value ?? false;
  }

  void onCustomTitleChanged(String value) {
    if (value.toLowerCase() == 'owner' || value.toLowerCase() == 'member') {
      customTitleErrorMsg = 'This title can not be used'.tr;
    } else {
      customTitleErrorMsg = '';
    }
  }
}
