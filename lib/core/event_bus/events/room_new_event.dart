import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class RoomNewEvent {
  RoomCollection room;

  RoomNewEvent({required this.room});

  @override
  String toString() => 'RoomNewEvent(room: $room)';
}
