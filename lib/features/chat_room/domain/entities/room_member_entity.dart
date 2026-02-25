import 'package:flutter/cupertino.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';

class RoomMemberEntity {
  final String roomId;
  final RoomType roomType;
  final DateTime? joinedAt;
  final DateTime? lastSeenMessageAt;
  final DateTime? lastTypedAt;

  // TODO: change to GroupMemberRoleEntity
  final GroupMemberRoleModel? groupRole;
  final int? firstSequence;

  // TODO: change to ContactEntity
  final ContactModel account;

  const RoomMemberEntity({
    required this.roomId,
    required this.roomType,
    required this.account,
    this.joinedAt,
    this.lastSeenMessageAt,
    this.lastTypedAt,
    this.groupRole,
    this.firstSequence,
  });

  String get localDbId => '${account.id}-$roomId';

  String? get name => account.nickname ?? account.displayName;

  String? get shortName {
    final characters = name?.characters;
    if (characters != null && characters.length > 15) {
      final short = characters.take(10);

      return '$short...';
    } else {
      return name;
    }
  }

  String? get nameLowercase => name?.toLowerCase();

  bool get isDirect => roomType == RoomType.direct;

  bool get isGroup => roomType == RoomType.group;

  bool get isSystem => roomType == RoomType.system;

  bool get isAdminOrAbove => groupRole?.role == RoomMemberRole.owner || groupRole?.role == RoomMemberRole.admin;

  bool get isAdmin => groupRole?.role == RoomMemberRole.admin;

  bool get isOwner => groupRole?.role == RoomMemberRole.owner;

  bool get ableSetGroupPermission {
    if (isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.setGroupPermissions == true;
    }

    return false;
  }

  bool get ableChangeGroupInfo {
    if (isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.changeGroupInfo == true;
    }

    return false;
  }

  bool get ablePinMessages {
    if (isDirect || isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.pinMessages == true;
    }

    return false;
  }

  bool get ableDeleteOtherMessages {
    if (isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.deleteOtherMessages == true;
    }

    return false;
  }

  bool get ableToAccessGroupMemberSetting {
    if (isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.groupMemberSetting == true;
    }

    return false;
  }

  bool get ableToAccessGroupTypeInviteLinkSetting {
    if (isOwner) {
      return true;
    }

    if (isAdmin) {
      return groupRole?.permissions?.groupTypeInviteLinkSetting == true;
    }

    return false;
  }

  RoomMemberEntity copyWith({
    ContactModel? account,
    String? roomId,
    RoomType? roomType,
    DateTime? joinedAt,
    DateTime? lastSeenMessageAt,
    DateTime? lastTypedAt,
    DateTime? lastSeenAt,
    GroupMemberRoleModel? groupRole,
    int? firstSequence,
  }) {
    return RoomMemberEntity(
      account: account ?? this.account,
      roomId: roomId ?? this.roomId,
      roomType: roomType ?? this.roomType,
      joinedAt: joinedAt ?? this.joinedAt,
      lastSeenMessageAt: lastSeenMessageAt ?? this.lastSeenMessageAt,
      lastTypedAt: lastTypedAt ?? this.lastTypedAt,
      groupRole: groupRole ?? this.groupRole,
      firstSequence: firstSequence ?? this.firstSequence,
    );
  }

  @override
  String toString() {
    return 'RoomMemberEntity{roomId: $roomId, roomType: $roomType, joinedAt: $joinedAt, lastSeenMessageAt: $lastSeenMessageAt, lastTypedAt: $lastTypedAt, role: $groupRole, firstSequence: $firstSequence, account: $account}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RoomMemberEntity && runtimeType == other.runtimeType && localDbId == other.localDbId;
  }

  @override
  int get hashCode => localDbId.hashCode;
}
