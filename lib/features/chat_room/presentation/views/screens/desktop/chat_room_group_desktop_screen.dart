import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_group_controller.dart';
import 'package:uchat/widgets.dart';

class ChatRoomGroupDesktopScreen extends GetView<ChatRoomGroupController> {
  final String? roomTag;

  const ChatRoomGroupDesktopScreen({super.key, this.roomTag});

  @override
  Widget build(BuildContext context) {
    // TODO implement this.
    return ScaffoldBasic(
      child: Container(),
    );
  }
}
