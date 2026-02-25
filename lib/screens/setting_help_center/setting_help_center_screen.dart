import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_controller.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_desktop_screen.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class SettingHelpCenterScreen extends GetView<SettingHelpCenterController> {
  const SettingHelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingHelpCenterMobileScreen();
    } else {
      return const SettingHelpCenterDesktopScreen();
    }
  }
}
