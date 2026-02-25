import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';

class ChatFolderUnreadUpdateEvent {
  final RoomSubscriptionCollection receiveRoomSubscription;

  ChatFolderUnreadUpdateEvent({required this.receiveRoomSubscription});
}
