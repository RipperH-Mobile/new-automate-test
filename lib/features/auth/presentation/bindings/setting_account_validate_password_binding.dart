import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_validate_password/setting_account_validate_password_controller.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';

class SettingAccountValidatePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountValidatePasswordController>(
      SettingAccountValidatePasswordController(
        args: Get.arguments,
        forgotPasswordFlowManager: GetIt.I<SettingAccountForgotPasswordFlowManager>(),
      ),
    );
  }
}
