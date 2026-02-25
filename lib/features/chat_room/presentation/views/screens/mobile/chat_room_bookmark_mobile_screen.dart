import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_bookmark_controller.dart';
import 'package:uchat/widgets.dart';

class ChatRoomBookmarkMobileScreen extends GetView<ChatRoomBookmarkController> {
  final String roomTag;

  @override
  String get tag => roomTag;

  const ChatRoomBookmarkMobileScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    // TODO implement this.
    return ScaffoldBasic(
      child: Container(),
    );
  }
}
