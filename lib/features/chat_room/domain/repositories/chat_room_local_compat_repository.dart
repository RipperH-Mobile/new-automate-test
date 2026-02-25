import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

abstract class ChatRoomLocalCompatRepository {
  Future<RoomEntity?> getRoom(String roomId);
  Future<void> putOrUpdateRoom(RoomEntity room);
  Future<void> updateAllRoomMember(List<RoomMemberEntity> members);
  Future<RoomEntity> putRoom(RoomEntity room, {bool replaceData});
}
