import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

abstract class RoomMemberLocalRepository {
  Future<RoomMemberEntity?> getFirstOtherInRoom(String roomId);

  Future<void> putAllRoomMember(List<RoomMemberEntity> memberList);

  Future<void> updateAllRoomMember(List<RoomMemberEntity> memberList);

  Future<List<RoomMemberEntity>> getMemberWithIdInSecretChat(String accountId);

  Future<int> countMemberByRoomId({required String roomId});
}
