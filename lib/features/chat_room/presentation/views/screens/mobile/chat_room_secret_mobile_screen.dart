import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_secret_controller.dart';
import 'package:uchat/widgets.dart';

class ChatRoomSecretMobileScreen extends GetView<ChatRoomSecretController> {
  final String roomTag;

  @override
  String get tag => roomTag;

  const ChatRoomSecretMobileScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    // TODO implement this.
    return ScaffoldBasic(
      child: Container(),
    );
  }
}
