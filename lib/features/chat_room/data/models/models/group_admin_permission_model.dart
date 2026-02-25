// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar_community/isar.dart';

part 'group_admin_permission_model.g.dart';

@embedded
class GroupAdminPermissionModel {
  final bool? setGroupPermissions;
  final bool? changeGroupInfo;
  final bool? pinMessages;
  final bool? deleteOtherMessages;
  final bool? groupMemberSetting;
  final bool? groupTypeInviteLinkSetting;

  GroupAdminPermissionModel({
    this.setGroupPermissions,
    this.changeGroupInfo,
    this.pinMessages,
    this.deleteOtherMessages,
    this.groupMemberSetting,
    this.groupTypeInviteLinkSetting,
  });

  factory GroupAdminPermissionModel.fromJson(Map<String, dynamic> json) {
    return GroupAdminPermissionModel(
      setGroupPermissions: json['setGroupPermission'],
      changeGroupInfo: json['changeGroupInfo'],
      pinMessages: json['pinMessages'],
      deleteOtherMessages: json['deleteOtherMessages'],
      groupMemberSetting: json['groupMemberSetting'],
      groupTypeInviteLinkSetting: json['groupTypeInviteLinkSetting'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'setGroupPermission': setGroupPermissions,
      'changeGroupInfo': changeGroupInfo,
      'pinMessages': pinMessages,
      'deleteOtherMessages': deleteOtherMessages,
      'groupMemberSetting': groupMemberSetting,
      'groupTypeInviteLinkSetting': groupTypeInviteLinkSetting,
    };
  }

  @override
  String toString() {
    return 'GroupAdminPermissionModel(setGroupPermissions: $setGroupPermissions, changeGroupInfo: $changeGroupInfo, pinMessages: $pinMessages, deleteOtherMessages: $deleteOtherMessages, groupMemberSetting: $groupMemberSetting, groupTypeInviteLinkSetting: $groupTypeInviteLinkSetting)';
  }
}
