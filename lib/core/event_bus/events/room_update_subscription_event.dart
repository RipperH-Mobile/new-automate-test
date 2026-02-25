import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class RoomUpdateSubscriptionEvent {
  RoomSubscriptionEntity roomSubscription;

  RoomUpdateSubscriptionEvent({required this.roomSubscription});

  @override
  String toString() => 'RoomUpdateSubscriptionEvent(roomSubscription: $roomSubscription)';
}
