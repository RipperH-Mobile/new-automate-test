import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class AddRoomMemberEvent {
  List<RoomMemberCollection> member; // Will contain new member only.
  String roomId;
  int? memberRequestCount;

  AddRoomMemberEvent({
    required this.roomId,
    required this.member,
    this.memberRequestCount,
  });

  @override
  String toString() => 'AddRoomMemberEvent(roomId: $roomId, memberCount: ${member.length}${memberRequestCount != null ? ', memberRequestCount: $memberRequestCount' : ''})';
}
