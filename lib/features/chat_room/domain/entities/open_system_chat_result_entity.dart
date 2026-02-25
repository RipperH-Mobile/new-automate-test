import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class OpenSystemChatResultEntity {
  final RoomEntity room;
  final RoomSubscriptionEntity roomSub;

  OpenSystemChatResultEntity({
    required this.room,
    required this.roomSub,
  });
}
