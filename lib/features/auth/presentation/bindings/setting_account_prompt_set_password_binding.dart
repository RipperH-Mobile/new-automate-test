import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_prompt_set_password_controller.dart';

class SettingAccountPromptSetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingAccountPromptSetPasswordController>(
      () => SettingAccountPromptSetPasswordController(),
    );
  }
}