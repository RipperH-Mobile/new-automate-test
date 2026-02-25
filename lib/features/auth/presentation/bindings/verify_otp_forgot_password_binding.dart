import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_forgot_password_controller.dart';

class VerifyOtpForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyOtpForgotPasswordController>(
      VerifyOtpForgotPasswordController(
        args: Get.arguments,
      ),
    );
  }
}
