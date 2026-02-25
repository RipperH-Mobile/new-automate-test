import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class UpdateAdminPermissionEvent {
  final RoomMemberCollection member;
  final String roomId;

  UpdateAdminPermissionEvent({
    required this.roomId,
    required this.member,
  });
}
