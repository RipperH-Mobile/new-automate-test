import 'package:uchat/features/chat_room/domain/entities/open_direct_chat_result_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class OpenDirectChatResponse {
  final RoomEntity? room;
  final RoomSubscriptionEntity? roomSub;

  OpenDirectChatResponse({
    this.room,
    this.roomSub,
  });

  factory OpenDirectChatResponse.fromMap(Map<String, dynamic> json) {
    return OpenDirectChatResponse(
      room: RoomEntity.fromJson(json),
      roomSub: RoomSubscriptionEntity.fromMap(json['mySubscription']),
    );
  }

  OpenDirectChatResultEntity toEntity() {
    return OpenDirectChatResultEntity(
      room: room!,
      roomSub: roomSub!,
    );
  }
}
