import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_change_password_controller.dart';

class SettingAccountPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountChangePasswordController>(
      SettingAccountChangePasswordController(),
    );
  }
}
