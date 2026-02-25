import 'package:get/get.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_arguments.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_controller.dart';

class SecretChatSettingDurationBinding implements Bindings {
  @override
  void dependencies() {
    SecretChatSettingArguments? args = Get.arguments;
    if (args != null) {
      if (!Get.isRegistered<SecretChatSettingController>(tag: args.roomId)) {
        Get.put<SecretChatSettingController>(
          SecretChatSettingController(args: args),
          tag: args.roomId,
        );
      }
    }
  }
}
