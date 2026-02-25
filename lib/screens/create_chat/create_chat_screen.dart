import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/create_chat/create_chat_desktop_screen.dart';
import 'package:uchat/screens/create_chat/create_chat_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'create_chat_controller.dart';

class CreateChatScreen extends GetView<CreateChatController> {
  const CreateChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const CreateChatMobileScreen();
    } else {
      return const CreateChatDesktopScreen();
    }
  }
}
