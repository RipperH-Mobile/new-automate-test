import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class CreateGroupChatResponse {
  RoomCollection room;

  CreateGroupChatResponse({
    required this.room,
  });

  static CreateGroupChatResponse fromMap(Map<String, dynamic> data) {
    return CreateGroupChatResponse(
      room: RoomCollection.fromMap(data),
    );
  }
}
