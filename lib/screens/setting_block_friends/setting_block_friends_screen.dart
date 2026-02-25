import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_block_friends/setting_block_friends_desktop_screen.dart';
import 'package:uchat/screens/setting_block_friends/setting_block_friends_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'setting_block_friends_controller.dart';

class SettingBlockFriendsScreen extends GetView<SettingBlockFriendsController> {
  const SettingBlockFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingBlockFriendsMobileScreen();
    } else {
      return const SettingBlockFriendsDesktopScreen();
    }
  }
}
