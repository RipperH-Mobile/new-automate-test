import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class RevokeAdminEvent {
  final RoomMemberCollection member;
  final String roomId;

  RevokeAdminEvent({
    required this.roomId,
    required this.member,
  });
}
