import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_language/setting_change_language_desktop_screen.dart';
import 'package:uchat/screens/setting_language/setting_change_language_mobile_screen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'setting_change_language_controller.dart';

class SettingChangeLanguageScreen extends GetView<SettingChangeLanguageController> {
  const SettingChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (UChatScreenUtil.instance.isMobile) {
      return const SettingChangeLanguageMobileScreen();
    } else {
      return const SettingChangeLanguageDesktopScreen();
    }
  }
}
