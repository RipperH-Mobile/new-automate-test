import 'package:get/get.dart';

import 'setting_chats_controller.dart';

class SettingChatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingChatsController>(SettingChatsController());
  }
}
