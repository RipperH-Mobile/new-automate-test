import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

class RoomInviteEntity {
  final String? id;
  final String? roomName;
  final String? photoId;
  final String? groupRef;
  final String? roomType;
  final List<RoomMemberEntity>? members;
  final DateTime? invitedAt;
  final String? invitedByAccountId;
  final String? invitedByDisplayName;
  final bool? isAccepted;

  RoomInviteEntity({
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

  String get widgetKey {
    return 'ROOM-IV-$id';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomInviteEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
