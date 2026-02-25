import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class RoomListRequest {
  RoomListRequest();

  Map<String, dynamic> toJson() {
    return {};
  }
}

class RoomListResponse {
  List<RoomCollection>? rooms;

  RoomListResponse({
    this.rooms,
  });

  factory RoomListResponse.fromMap(Map<String, dynamic> json) {
    List<dynamic> roomRows = json['rows'];
    List<RoomCollection> rooms = [];

    for (final element in roomRows) {
      rooms.add(RoomCollection.fromMap(element));
    }

    return RoomListResponse(rooms: rooms);
  }
}
