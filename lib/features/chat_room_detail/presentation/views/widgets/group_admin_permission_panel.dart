import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/row_menu/uchat_switch_row_menu.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class GroupAdminPermissionPanel extends StatelessWidget {
  final bool setGroupPermissionsValue;
  final bool changeGroupInfoValue;
  final bool pinMessagesValue;
  final bool deleteOtherMessagesValue;
  final bool groupMemberSettingValue;
  final bool groupTypeInviteLinkSetting;

  final Function(bool?) onSetGroupPermissionsChanged;
  final Function(bool?) onChangeGroupInfoChanged;
  final Function(bool?) onPinMessagesChanged;
  final Function(bool?) onDeleteOtherMessagesChanged;
  final Function(bool?) onGroupMemberSettingChanged;
  final Function(bool?) onGroupTypeSettingChanged;

  final String? controllerTag;

  const GroupAdminPermissionPanel({
    super.key,
    required this.setGroupPermissionsValue,
    required this.changeGroupInfoValue,
    required this.pinMessagesValue,
    required this.deleteOtherMessagesValue,
    required this.groupMemberSettingValue,
    required this.groupTypeInviteLinkSetting,
    required this.onSetGroupPermissionsChanged,
    required this.onChangeGroupInfoChanged,
    required this.onPinMessagesChanged,
    required this.onDeleteOtherMessagesChanged,
    required this.onGroupMemberSettingChanged,
    required this.onGroupTypeSettingChanged,
    this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: SettingFrameContainer.withChildren(
        context: context,
        children: [
          UChatSwitchRowMenu(
            onTap: onSetGroupPermissionsChanged,
            value: setGroupPermissionsValue,
            title: 'Set Group Permissions'.tr,
            borderRadiusTop: true,
            hasBorder: false,
          ),
          UChatSwitchRowMenu(
            onTap: onChangeGroupInfoChanged,
            value: changeGroupInfoValue,
            title: 'Change Group Info'.tr,
            hasBorder: false,
          ),
          UChatSwitchRowMenu(
            onTap: onPinMessagesChanged,
            value: pinMessagesValue,
            title: 'Pin Messages'.tr,
            hasBorder: false,
          ),
          UChatSwitchRowMenu(
            onTap: onDeleteOtherMessagesChanged,
            value: deleteOtherMessagesValue,
            title: 'Delete Other Messages'.tr,
            hasBorder: false,
          ),
          UChatSwitchRowMenu(
            onTap: onGroupMemberSettingChanged,
            value: groupMemberSettingValue,
            title: 'Group Member Setting'.tr,
            hasBorder: false,
          ),
          UChatSwitchRowMenu(
            onTap: onGroupTypeSettingChanged,
            value: groupTypeInviteLinkSetting,
            title: 'Group Type & Invite Link Setting'.tr,
            hasBorder: false,
          ),
        ],
      ),
    );
  }
}
