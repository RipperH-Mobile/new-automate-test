import 'package:get/get.dart';

import 'setting_hidden_chats_controller.dart';

class SettingHiddenChatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingHiddenChatsController>(SettingHiddenChatsController());
  }
}
