import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_link_email_controller.dart';

class VerifyOtpLinkEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyOtpLinkEmailController>(
      VerifyOtpLinkEmailController(
        args: Get.arguments,
      ),
    );
  }
}
