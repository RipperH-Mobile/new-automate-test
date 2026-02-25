import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_hidden_chats/setting_hidden_chats_desktop_screen.dart';
import 'package:uchat/screens/setting_hidden_chats/setting_hidden_chats_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'setting_hidden_chats_controller.dart';

class SettingHiddenChatsScreen extends GetView<SettingHiddenChatsController> {
  const SettingHiddenChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingHiddenChatsMobileScreen();
    } else {
      return const SettingHiddenChatsDesktopScreen();
    }
  }
}
