import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uchat/widgets.dart';
import 'setting_talker_controller.dart';

class SettingTalkerScreen extends GetView<SettingTalkerController> {
  const SettingTalkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: const Color(0xFF212121),
      child: SafeArea(
        child: TalkerScreen(talker: controller.talkerInstance),
      ),
    );
  }
}
