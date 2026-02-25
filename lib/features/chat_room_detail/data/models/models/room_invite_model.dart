import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

// TODO: refactor this model
class RoomInviteModel {
  final String? id;
  final String? roomName;
  final String? photoId;
  final String? groupRef;
  final String? roomType;
  final List<RoomMemberCollection>? members;
  final DateTime? invitedAt;
  final String? invitedByAccountId;
  final String? invitedByDisplayName;
  final bool? isAccepted;

  RoomInviteModel({
    this.id,
    this.roomName,
    this.photoId,
    this.groupRef,
    this.roomType,
    this.members,
    this.invitedAt,
    this.invitedByAccountId,
    this.invitedByDisplayName,
    this.isAccepted,
  });

  factory RoomInviteModel.fromMap(Map<String, dynamic> json) {
    List<RoomMemberCollection>? members;
    if (json['members'] != null) {
      try {
        final jsonMember = json['members'] as List;
        members = jsonMember.map((e) => RoomMemberCollection.fromMap(e)).toList();
      } catch (e, stackTrace) {
        _log.e('Error parse member. (${json['members']})', e, stackTrace);
      }
    }
    var room = RoomInviteModel(
      id: json['_id'],
      roomName: json['roomName'],
      roomType: json['roomType'],
      photoId: json['photoId'],
      groupRef: json['groupRef'],
      members: members,
      invitedAt: strToDateTime(
        json['invitedAt'],
      ),
      invitedByAccountId: json['invitedByAccountId'],
    );

    if (json['invitedAccount'] != null) {
      // room.invitedByAccountId = json['invitedAccount']['accountId'];
      // room.invitedByDisplayName = json['invitedAccount']['displayName'];
      room = room.copyWith(
        invitedByAccountId: json['invitedAccount']['accountId'],
        invitedByDisplayName: json['invitedAccount']['displayName'],
      );
    }
    return room;
  }

  String get widgetKey {
    return 'ROOM-IV-$id';
  }

  @override
  String toString() {
    return '[Instance:RoomInviteModel] ID: "$id", NAME: "$roomName", TYPE: "$roomType", PHOTO_ID: "$photoId", MEMBERS: "$members"';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomInviteModel && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  // copyWith method
  RoomInviteModel copyWith({
    String? id,
    String? roomName,
    String? photoId,
    String? groupRef,
    String? roomType,
    List<RoomMemberCollection>? members,
    DateTime? invitedAt,
    String? invitedByAccountId,
    String? invitedByDisplayName,
    bool? isAccepted,
  }) {
    return RoomInviteModel(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      photoId: photoId ?? this.photoId,
      groupRef: groupRef ?? this.groupRef,
      roomType: roomType ?? this.roomType,
      members: members ?? this.members,
      invitedAt: invitedAt ?? this.invitedAt,
      invitedByAccountId: invitedByAccountId ?? this.invitedByAccountId,
      invitedByDisplayName: invitedByDisplayName ?? this.invitedByDisplayName,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }

  RoomCollection toRoomCollection() {
    return RoomCollection(
      id: id,
      roomType: RoomType.group,
      originalRoomName: roomName,
      photoId: photoId,
      groupRef: groupRef,
      isJoined: isAccepted,
    );
  }

  RoomInviteEntity toEntity() {
    return RoomInviteEntity(
      id: id,
      roomName: roomName,
      photoId: photoId,
      groupRef: groupRef,
      roomType: roomType,
      members: members?.map((e) => e.toEntity()).toList(),
      invitedAt: invitedAt,
      invitedByAccountId: invitedByAccountId,
      invitedByDisplayName: invitedByDisplayName,
      isAccepted: isAccepted,
    );
  }
}
