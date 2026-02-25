import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';

class OwnershipTransferredStateDataModel {
  final String roomId;
  final String newOwnerAccountId;
  final String oldOwnerAccountId;
  final GroupAdminPermissionModel? newOwnerPermissions;
  final GroupAdminPermissionModel? oldOwnerPermissions;

  OwnershipTransferredStateDataModel({
    required this.roomId,
    required this.newOwnerAccountId,
    required this.oldOwnerAccountId,
    this.newOwnerPermissions,
    this.oldOwnerPermissions,
  });

  factory OwnershipTransferredStateDataModel.fromJson(Map<String, dynamic> data) {
    return OwnershipTransferredStateDataModel(
      roomId: data['roomId'],
      newOwnerAccountId: data['newOwner']['accountId'],
      oldOwnerAccountId: data['oldOwner']['accountId'],
      newOwnerPermissions: data['newOwner']['permissions'] != null
          ? GroupAdminPermissionModel.fromJson(data['newOwner']['permissions'])
          : null,
      oldOwnerPermissions: data['oldOwner']['permissions'] != null
          ? GroupAdminPermissionModel.fromJson(data['oldOwner']['permissions'])
          : null,
    );
  }
}
