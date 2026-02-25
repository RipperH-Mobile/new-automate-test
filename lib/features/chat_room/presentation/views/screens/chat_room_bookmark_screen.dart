import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_bookmark_desktop_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_bookmark_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class ChatRoomBookmarkScreen extends StatelessWidget {
  /// Tag used in GetX controller's tag. Its value is roomId.
  final String roomTag;

  const ChatRoomBookmarkScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return ChatRoomBookmarkMobileScreen(roomTag: roomTag);
    } else {
      return ChatRoomBookmarkDesktopScreen(roomTag: roomTag);
    }
  }
}
