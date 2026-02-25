import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';

class EditGroupAdminRequest {
  final String roomId;
  final String accountId;
  final GroupAdminPermissionModel permissions;
  final String? customAdminName;

  EditGroupAdminRequest({
    required this.roomId,
    required this.accountId,
    required this.permissions,
    this.customAdminName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'accountId': accountId,
      'permissions': permissions.toJson(),
    };

    if (customAdminName != null) {
      json['customTitle'] = customAdminName;
    }

    return json;
  }

  Map<String, dynamic> toJsonWithOutRoomId() {
    Map<String, dynamic> json = {
      'permissions': permissions.toJson(),
    };

    if (customAdminName != null) {
      json['customTitle'] = customAdminName;
    }

    return json;
  }
}
