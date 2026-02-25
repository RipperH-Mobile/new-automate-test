import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class FetchMyChatRoomRequest {
  final String roomId;

  FetchMyChatRoomRequest({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}

class FetchMyChatRoomResponse {
  RoomCollection? room;

  FetchMyChatRoomResponse({
    this.room,
  });

  factory FetchMyChatRoomResponse.fromMap(Map<String, dynamic> json) {
    final room = RoomCollection.fromMap(json);

    return FetchMyChatRoomResponse(room: room);
  }
}
