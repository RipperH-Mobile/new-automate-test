import 'package:get/get.dart';

import 'setting_chats_sound_controller.dart';

class SettingChatsSoundBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingChatsSoundController>(
      SettingChatsSoundController(
        args: Get.arguments,
      ),
    );
  }
}
