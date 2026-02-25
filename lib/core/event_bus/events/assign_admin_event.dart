import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class AssignAdminEvent {
  final RoomMemberCollection member;
  final String roomId;

  AssignAdminEvent({
    required this.roomId,
    required this.member,
  });
}
