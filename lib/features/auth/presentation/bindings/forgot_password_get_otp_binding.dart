import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_get_otp_controller.dart';

class ForgotPasswordGetOtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ForgotPasswordGetOtpController>(
      ForgotPasswordGetOtpController(
        args: Get.arguments,
      ),
    );
  }
}
