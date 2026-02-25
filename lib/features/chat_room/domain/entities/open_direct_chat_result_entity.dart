import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class OpenDirectChatResultEntity {
  final RoomEntity room;
  final RoomSubscriptionEntity roomSub;

  OpenDirectChatResultEntity({
    required this.room,
    required this.roomSub,
  });
}
