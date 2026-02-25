import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_secret_desktop_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_secret_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class ChatRoomSecretScreen extends StatelessWidget {
  /// Tag used in GetX controller's tag. Its value is roomId.
  final String roomTag;

  const ChatRoomSecretScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {

    if (UChatScreenUtil.instance.isMobile) {
      return ChatRoomSecretMobileScreen(roomTag: roomTag);
    } else {
      return ChatRoomSecretDesktopScreen(roomTag: roomTag);
    }
  }
}
