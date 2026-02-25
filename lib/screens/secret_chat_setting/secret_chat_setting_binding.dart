import 'package:get/get.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_arguments.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_controller.dart';

class SecretChatSettingBinding implements Bindings {
  @override
  void dependencies() {
    SecretChatSettingArguments args = Get.arguments;
    Get.put<SecretChatSettingController>(
      SecretChatSettingController(args: args),
      tag: args.roomId,
    );
  }
}
