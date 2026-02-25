import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enum/room_access_type.dart';

@immutable
class ChatRoomDetailGroupTypeSettingArgument {
  final String roomId;
  final RoomAccessType groupType;

  const ChatRoomDetailGroupTypeSettingArgument({
    required this.roomId,
    required this.groupType,
  });
}
