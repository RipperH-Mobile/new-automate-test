import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_login_controller.dart';

class VerifyOtpLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyOtpLoginController>(
      VerifyOtpLoginController(
        args: Get.arguments,
      ),
    );
  }
}
