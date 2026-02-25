import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

abstract class RoomSubscriptionLocalRepository {
  Future<RoomSubscriptionEntity?> getRoomSubscriptionByRoomId({required String roomId});

  Future<RoomSubscriptionEntity?> putRoomSubscription({
    required RoomSubscriptionEntity roomSub,
    bool replaceData = false,
    bool useTxn = true,
  });
}
