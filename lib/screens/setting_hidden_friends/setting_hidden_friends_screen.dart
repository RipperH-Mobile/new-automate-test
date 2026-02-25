import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_hidden_friends/setting_hidden_friends_desktop_screen.dart';
import 'package:uchat/screens/setting_hidden_friends/setting_hidden_friends_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'setting_hidden_friends_controller.dart';

class SettingHiddenFriendsScreen extends GetView<SettingHiddenFriendsController> {
  const SettingHiddenFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingHiddenFriendsMobileScreen();
    } else {
      return const SettingHiddenFriendsDesktopScreen();
    }
  }
}
