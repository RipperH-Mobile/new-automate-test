import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/presentation/controllers/login/login_password_controller.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';

class LoginPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginPasswordController>(
      LoginPasswordController(
        args: Get.arguments,
        forgotPasswordFlowManager: GetIt.I<SettingAccountForgotPasswordFlowManager>(),
      ),
    );
  }
}
