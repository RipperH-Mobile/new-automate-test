import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/screens/setting_about/setting_about_desktop_screen.dart';
import 'package:uchat/screens/setting_about/setting_about_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class SettingAboutAppScreen extends GetView<AppSettingsController> {
  const SettingAboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingAboutAppMobileScreen();
    } else {
      return const SettingAboutAppDesktopScreen();
    }
  }
}
