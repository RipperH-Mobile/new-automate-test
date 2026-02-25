import 'package:get/get.dart';

import 'setting_hidden_friends_controller.dart';

class SettingHiddenFriendsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingHiddenFriendsController>(SettingHiddenFriendsController());
  }
}
