import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';

class AssignAdminStateDataModel {
  final String roomId;
  final String adminAccountIds;
  final GroupAdminPermissionModel? permissions;
  final String? customTitle;

  AssignAdminStateDataModel({
    required this.roomId,
    required this.adminAccountIds,
    this.permissions,
    this.customTitle,
  });

  factory AssignAdminStateDataModel.fromJson(Map<String, dynamic> data) {
    return AssignAdminStateDataModel(
      roomId: data['roomId'],
      adminAccountIds: data['adminAccountIds'],
      permissions: data['permissions'] != null ? GroupAdminPermissionModel.fromJson(data['permissions']) : null,
      customTitle: data['customTitle'],
    );
  }
}
