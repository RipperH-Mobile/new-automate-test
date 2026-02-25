import 'package:isar_community/isar.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

// import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

part 'room_member_collection.g.dart';

// final _log = useLogger();

@Collection(accessor: 'roomMember')
@Name('RoomMember')
class RoomMemberCollection {
  /// This is use for isar id only to uniquely identify each RoomMemberCollection.
  @Index(unique: true, replace: true)
  String? get localDbId {
    return '$accountId-$roomId';
  }

  Id get isarId => fastHash(localDbId!);

  // This is use to save _id data from server which is needed in some cases such as approve / reject waiting member.
  String? rowId;

  ContactModel? account;

  DateTime? joinedAt;

  DateTime? lastSeenMessageAt;

  DateTime? lastTypedAt;

  @Index()
  String? roomId;

  @Enumerated(EnumType.name)
  @Index()
  RoomType? roomType;

  GroupMemberRoleModel? groupRole;

  int? firstSequence;

  RoomMemberCollection({
    this.rowId,
    this.joinedAt,
    this.account,
    this.lastSeenMessageAt,
    this.lastTypedAt,
    this.roomId,
    this.roomType,
    this.groupRole,
    this.firstSequence,
  });

  // Convert from json to model
  factory RoomMemberCollection.fromMap(Map<String, dynamic> data) {
    GroupMemberRoleModel groupRoleModel = GroupMemberRoleModel(
      role: RoomMemberRole.from(data['role']),
      customAdminName: data['customTitle']?.toString(),
      permissions: data['permissions'] != null ? GroupAdminPermissionModel.fromJson(data['permissions']) : null,
    );
    RoomMemberCollection roomMember = RoomMemberCollection(
      rowId: data['_id'],
      joinedAt: data['joinedAt'] != null ? DateTime.parse(data['joinedAt'].toString()) : null,
      lastSeenMessageAt: strToDateTime(data['lastSeenMessageAt']),
      lastTypedAt: strToDateTime(data['lastTypedAt']),
      roomId: data['roomId'],
      roomType: RoomType.from(data['roomType']),
      groupRole: groupRoleModel,
    );

    ContactModel? account;
    if (data['account'] != null) {
      account = ContactModel.fromMap(data['account']);
      roomMember.account = account;
    }

    if (data['accountId'] != null) {
      if (account == null) {
        account = ContactModel(id: data['accountId']);
        roomMember.account = account;
      } else {
        account.id = data['accountId'];
      }
    }

    if (data['lastSeenAt'] != null) {
      if (account == null) {
        account = ContactModel(lastSeenAt: strToDateTime(data['lastSeenAt']));
        roomMember.account = account;
      } else {
        roomMember.account?.lastSeenAt = strToDateTime(data['lastSeenAt']);
      }
    }

    return roomMember;
  }

  factory RoomMemberCollection.fromEntity(RoomMemberEntity entity) {
    return RoomMemberCollection(
      joinedAt: entity.joinedAt,
      account: entity.account,
      lastSeenMessageAt: entity.lastSeenMessageAt,
      lastTypedAt: entity.lastTypedAt,
      roomId: entity.roomId,
      roomType: entity.roomType,
      groupRole: entity.groupRole,
      firstSequence: entity.firstSequence,
    );
  }

  RoomMemberEntity toEntity() {
    return RoomMemberEntity(
      account: account!,
      roomId: roomId ?? '',
      roomType: roomType ?? RoomType.direct,
      lastSeenMessageAt: lastSeenMessageAt,
      lastTypedAt: lastTypedAt,
      groupRole: groupRole,
      firstSequence: firstSequence,
      joinedAt: joinedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rowId': rowId,
      'joinedAt': joinedAt?.toIso8601String(),
      'account': account?.toMap(),
      'lastSeenMessageAt': lastSeenMessageAt?.toIso8601String(),
      'lastTypedAt': lastTypedAt?.toIso8601String(),
      'roomId': roomId,
      'roomType': roomType?.name,
      'role': groupRole?.role?.value,
      'firstSequence': firstSequence,
    };
  }

  String? get name {
    return account?.nickname ?? account?.displayName;
  }

  bool get isMe {
    return UserController.instance.currentUser()?.id == accountId;
  }

  String? get accountId {
    return account?.id;
  }

  bool get isDirect {
    return roomType == RoomType.direct;
  }

  bool get isGroup {
    return roomType == RoomType.group;
  }

  bool get isSystem {
    return roomType == RoomType.system;
  }

  bool get isAdminOrAbove {
    return groupRole?.role == RoomMemberRole.owner || groupRole?.role == RoomMemberRole.admin;
  }

  bool get isAdmin {
    return groupRole?.role == RoomMemberRole.admin;
  }

  bool get isOwner {
    return groupRole?.role == RoomMemberRole.owner;
  }

  @Index()
  String? get nameLowercase {
    return name?.toLowerCase();
  }

  void update(RoomMemberCollection member) {
    if (member.rowId != null) {
      rowId = member.rowId;
    }

    if (member.joinedAt != null) {
      joinedAt = member.joinedAt;
    }

    if (member.account != null) {
      if (account != null) {
        account?.update(member.account!);
      } else {
        account = member.account;
      }
    }

    if (member.lastSeenMessageAt != null) {
      lastSeenMessageAt = member.lastSeenMessageAt;
    }

    if (member.lastTypedAt != null) {
      lastTypedAt = member.lastTypedAt;
    }

    if (member.roomId != null) {
      roomId = member.roomId;
    }

    if (member.roomType != null) {
      roomType = member.roomType;
    }

    if (member.groupRole != null) {
      groupRole = member.groupRole;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is RoomMemberCollection && localDbId == other.localDbId;
  }

  @ignore
  @override
  int get hashCode => localDbId.hashCode;

  @override
  String toString() => 'RoomMemberCollection(id: $localDbId, '
      'rowId: $rowId, '
      'joinAt: $joinedAt, '
      'account: ${account?.id}, '
      'account name: ${account?.displayName}, '
      'lastSeenMessageAt: $lastSeenMessageAt, '
      'lastTypedAt: $lastTypedAt, '
      'roomId: $roomId, '
      'roomType: $roomType, '
      'role: $groupRole)';
}
