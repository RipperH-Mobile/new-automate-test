import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class RoomUpdateEvent {
  RoomCollection room; // TODO: Should change to RoomEntity

  RoomUpdateEvent({required this.room});

  @override
  String toString() => 'RoomUpdateEvent(room: $room)';
}
