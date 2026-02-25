import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

class GetAllRoomLastSeenEntity {
  final String roomId;
  final List<RoomMemberEntity> members;

  GetAllRoomLastSeenEntity({
    required this.roomId,
    required this.members,
  });
}
