import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/screens/setting_notification/setting_notification_mobile_screen.dart';

class SettingNotificationScreen extends GetView<SettingNotificationController> {
  const SettingNotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SettingNotificationMobileScreen();
  }
}
