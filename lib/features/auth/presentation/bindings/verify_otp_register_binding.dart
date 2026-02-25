import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_register_controller.dart';

class VerifyOtpRegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyOtpRegisterController>(
      VerifyOtpRegisterController(
        args: Get.arguments,
      ),
    );
  }
}
