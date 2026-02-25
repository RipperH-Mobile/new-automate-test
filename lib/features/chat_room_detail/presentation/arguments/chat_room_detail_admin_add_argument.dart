import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';

class ChatRoomDetailAdminAddArgument {
  final String roomId;
  final RoomDetailMemberAndPendingModel member;

  ChatRoomDetailAdminAddArgument({
    required this.roomId,
    required this.member,
  });
}
