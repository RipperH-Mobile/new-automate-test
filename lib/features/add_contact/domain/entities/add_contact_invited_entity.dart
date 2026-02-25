import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class AddContactInvitedEntity {
  String? id;
  String? name;
  String? senderName;
  String? senderId;
  String? avatarId;
  bool? isFriendRequest;
  bool? isGroupInvite;
  DateTime? invitedAt;
  List<RoomMemberCollection>? members;
  String? groupRef;
  CentralNotiType? type;

  AddContactInvitedEntity({
    this.id,
    this.name,
    this.senderName,
    this.senderId,
    this.avatarId,
    this.isFriendRequest,
    this.isGroupInvite,
    this.invitedAt,
    this.members,
    this.groupRef,
    this.type,
  });

  RoomCollection toRoomCollection() {
    return RoomCollection(
      id: id,
      roomType: isFriendRequest == true ? RoomType.direct : RoomType.group,
      originalRoomName: name,
      photoId: avatarId,
      groupRef: groupRef,
    );
  }
}
