import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class UpdateRoomMemberEvent {
  final List<RoomMemberCollection> members; // Will contain updated member only.
  final String roomId;

  UpdateRoomMemberEvent({
    required this.roomId,
    required this.members,
  });

  @override
  String toString() => 'UpdateRoomMemberEvent(roomId: $roomId, memberCount: ${members.length})';
}
