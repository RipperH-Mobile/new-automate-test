import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_forgot_password/setting_account_sent_email_forgot_password_controller.dart';

class SettingAccountSentEmailForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingAccountSentEmailForgotPasswordController(),
    );
  }
}
