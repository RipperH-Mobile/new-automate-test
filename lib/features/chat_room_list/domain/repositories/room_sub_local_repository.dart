import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

abstract class RoomSubLocalRepository {
  /// Return the latest direct chat rooms, possibly with a [limit].
  Future<List<RoomSubscriptionEntity>> getLatestDirectChatRooms({int limit = 999});

  /// Get a single room subscription by [roomId].
  Future<RoomSubscriptionEntity?> getRoomSubscriptionWithRoomId(String roomId);

  /// Put a room subscription.
  Future<RoomSubscriptionEntity?> putRoomSubscription(RoomSubscriptionEntity roomSub);

  /// Put a room subscription without transaction.
  Future<RoomSubscriptionEntity?> putRoomSubscriptionWithoutTxn(RoomSubscriptionEntity roomSub);

  /// Count the number of pinned rooms in all chat folders.
  Future<int> countPinedRoomAllChat();

  /// Count the number of pinned rooms in a specific chat folder.
  Future<int> countPinedRoomInFolder();
}
