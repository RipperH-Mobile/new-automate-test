import 'package:get/get.dart';

import 'setting_friends_controller.dart';

class SettingFriendsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingFriendsController>(SettingFriendsController());
  }
}
