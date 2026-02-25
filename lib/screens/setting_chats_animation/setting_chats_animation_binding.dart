import 'package:get/get.dart';

import 'setting_chats_animation_controller.dart';

class SettingChatsAnimationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingChatsAnimationController>(SettingChatsAnimationController());
  }
}
