import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';

import '../models/collections/room_member_collection.dart';

class RoomMemberLocalRepositoryImpl implements RoomMemberLocalRepository {
  final RoomMemberDb roomMemberDb;

  RoomMemberLocalRepositoryImpl({required this.roomMemberDb});

  @override
  Future<RoomMemberEntity?> getFirstOtherInRoom(String roomId) async {
    final member = await roomMemberDb.getFirstOtherInRoom(roomId);
    return member?.toEntity();
  }

  @override
  Future<void> putAllRoomMember(List<RoomMemberEntity> memberList) async {
    final collection = memberList.map((e) => RoomMemberCollection.fromEntity(e)).toList();
    await roomMemberDb.putAllRoomMember(collection);
  }

  @override
  Future<void> updateAllRoomMember(List<RoomMemberEntity> memberList) async {
    final collectionList = memberList.map((e) => RoomMemberCollection.fromEntity(e)).toList();
    await roomMemberDb.updateAllRoomMember(collectionList);
  }

  @override
  Future<List<RoomMemberEntity>> getMemberWithIdInSecretChat(String accountId) async {
    final collections = await roomMemberDb.getMemberWithIdInSecretChat(accountId);
    return collections.map((e) => e.toEntity()).toList();
  }

  @override
  Future<int> countMemberByRoomId({required String roomId}) async {
    return await roomMemberDb.getMemberCount(roomId);
  }
}
