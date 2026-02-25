import 'package:get/get.dart';

import 'setting_block_friends_controller.dart';

class SettingBlockFriendsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingBlockFriendsController>(SettingBlockFriendsController());
  }
}
