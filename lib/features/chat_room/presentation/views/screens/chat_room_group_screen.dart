import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_group_desktop_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_group_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class ChatRoomGroupScreen extends StatelessWidget {
  /// Tag used in GetX controller's tag. Its value is roomId.
  final String roomTag;

  const ChatRoomGroupScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return ChatRoomGroupMobileScreen(roomTag: roomTag);
    } else {
      return ChatRoomGroupDesktopScreen(roomTag: roomTag);
    }
  }
}
