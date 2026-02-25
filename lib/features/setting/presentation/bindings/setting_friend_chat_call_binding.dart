import 'package:get/get.dart';
import 'package:uchat/screens/setting_call/setting_call_controller.dart';
import 'package:uchat/screens/setting_friends/setting_friends_controller.dart';

class SettingFriendChatCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingFriendsController>(() => SettingFriendsController());
    Get.lazyPut<SettingCallController>(() => SettingCallController());
  }
}
