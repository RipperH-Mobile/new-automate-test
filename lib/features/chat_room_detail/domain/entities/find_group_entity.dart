import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

class FindGroupEntity {
  final RoomEntity room;
  final List<RoomMemberEntity> members;

  FindGroupEntity({
    required this.room,
    required this.members,
  });
}
