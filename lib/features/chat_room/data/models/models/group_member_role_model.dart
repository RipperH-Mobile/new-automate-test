// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';

part 'group_member_role_model.g.dart';

@embedded
class GroupMemberRoleModel {
  @Enumerated(EnumType.name)
  final RoomMemberRole? role;

  final String? customAdminName;

  final GroupAdminPermissionModel? permissions;

  GroupMemberRoleModel({
    this.role,
    this.customAdminName,
    this.permissions,
  });

  factory GroupMemberRoleModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberRoleModel(
      role: RoomMemberRole.from(json['role']),
      customAdminName: json['customTitle'],
      permissions: json['permissions'] != null ? GroupAdminPermissionModel.fromJson(json['permissions']) : null,
    );
  }

  GroupMemberRoleModel copyWith({
    RoomMemberRole? role,
    String? customAdminName,
    GroupAdminPermissionModel? permissions,
  }) {
    return GroupMemberRoleModel(
      role: role ?? this.role,
      customAdminName: customAdminName ?? this.customAdminName,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  String toString() =>
      'GroupMemberRoleModel(role: $role, customAdminName: $customAdminName, permissions: $permissions)';
}
