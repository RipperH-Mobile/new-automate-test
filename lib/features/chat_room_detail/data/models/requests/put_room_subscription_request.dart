import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class PutRoomSubscriptionRequest {
  final RoomSubscriptionEntity roomSub;
  final bool replaceData;

  PutRoomSubscriptionRequest({
    required this.roomSub,
    this.replaceData = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomSub': roomSub,
      'replaceData': replaceData,
    };
  }
}