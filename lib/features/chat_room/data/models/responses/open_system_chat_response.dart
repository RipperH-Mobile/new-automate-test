import 'package:uchat/features/chat_room/domain/entities/open_system_chat_result_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class OpenSystemChatResponse {
  final RoomEntity? room;
  final RoomSubscriptionEntity? roomSub;

  OpenSystemChatResponse({
    this.room,
    this.roomSub,
  });

  factory OpenSystemChatResponse.fromMap(Map<String, dynamic> json) {
    return OpenSystemChatResponse(
      room: RoomEntity.fromJson(json),
      roomSub: RoomSubscriptionEntity.fromMap(json['mySubscription']),
    );
  }

  OpenSystemChatResultEntity toEntity() {
    return OpenSystemChatResultEntity(
      room: room!,
      roomSub: roomSub!,
    );
  }
}
