import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

class ChatRoomDetailAdminEditArgument {
  final String roomId;
  final RoomMemberEntity member;

  ChatRoomDetailAdminEditArgument({
    required this.roomId,
    required this.member,
  });
}
