import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';

class AcceptGroupInviteResponse {
  final RoomCollection room;
  final RoomSubscriptionCollection roomSub;

  AcceptGroupInviteResponse({
    required this.room,
    required this.roomSub,
  });

  static AcceptGroupInviteResponse fromJson(Map<String, dynamic> data) {
    return AcceptGroupInviteResponse(
      room: RoomCollection.fromMap(data),
      roomSub: RoomSubscriptionCollection.fromMap(data['mySubscription']),
    );
  }
}
