import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';

class ChatRoomLocalCompatRepositoryImpl implements ChatRoomLocalCompatRepository {
  ChatRoomLocalCompatRepositoryImpl({
    required this.roomDb,
    required this.roomSubscriptionDb,
    required this.roomMemberDb,
  });

  final RoomDb roomDb;
  final RoomSubscriptionDb roomSubscriptionDb;
  final RoomMemberDb roomMemberDb;

  @override
  Future<RoomEntity?> getRoom(String roomId) async {
    final roomCollection = await roomDb.getRoom(roomId);
    return await roomCollection?.toEntityWithAsync();
  }

  @override
  Future<void> putOrUpdateRoom(RoomEntity room) async {
    roomDb.putOrUpdateRoom(room.toCollection());
  }

  @override
  Future<void> updateAllRoomMember(List<RoomMemberEntity> members) async {
    final collections = members.map((member) => RoomMemberCollection.fromEntity(member)).toList();
    await roomMemberDb.updateAllRoomMember(collections);
  }

  @override
  Future<RoomEntity> putRoom(
    RoomEntity room, {
    bool replaceData = false,
  }) async {
    await roomDb.putRoom(room.toCollection(), replaceData: replaceData);
    return room.copyWith();
  }
}
