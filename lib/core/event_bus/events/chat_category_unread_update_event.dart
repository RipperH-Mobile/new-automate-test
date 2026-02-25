import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';

class ChatCategoryUnreadUpdateEvent {
  final RoomSubscriptionCollection receiveRoomSubscription;

  ChatCategoryUnreadUpdateEvent({required this.receiveRoomSubscription});

  @override
  String toString() => 'ChatCategoryUnreadUpdateEvent(receiveRoomSubscription: $receiveRoomSubscription)';
}
