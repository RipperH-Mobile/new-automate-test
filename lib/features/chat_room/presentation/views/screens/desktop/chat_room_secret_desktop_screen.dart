import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_secret_controller.dart';
import 'package:uchat/widgets.dart';

class ChatRoomSecretDesktopScreen extends GetView<ChatRoomSecretController> {
  final String? roomTag;

  const ChatRoomSecretDesktopScreen({super.key, this.roomTag});

  @override
  Widget build(BuildContext context) {
    // TODO implement this.
    return ScaffoldBasic(
      child: Container(),
    );
  }
}
