import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_subscription_mapper_extension.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';

class RoomSubscriptionLocalRepositoryImpl implements RoomSubscriptionLocalRepository {
  final RoomSubscriptionDb roomSubscriptionDb;

  RoomSubscriptionLocalRepositoryImpl({required this.roomSubscriptionDb});

  @override
  Future<RoomSubscriptionEntity?> getRoomSubscriptionByRoomId({required String roomId}) async {
    final collection = await roomSubscriptionDb.getRoomSubscriptionWithRoomId(roomId);
    return collection?.toEntity();
  }

  @override
  Future<RoomSubscriptionEntity?> putRoomSubscription({
    required RoomSubscriptionEntity roomSub,
    bool replaceData = false,
    bool useTxn = true,
  }) async {
    RoomSubscriptionCollection? result;
    if (useTxn) {
      result = await roomSubscriptionDb.putRoomSubscription(
        roomSub.toCollection(),
        replaceData: replaceData,
      );
    } else {
      result = await roomSubscriptionDb.putRoomSubscriptionWithoutTxn(
        roomSub.toCollection(),
        replaceData: replaceData,
      );
    }
    return result?.toEntity();
  }
}
