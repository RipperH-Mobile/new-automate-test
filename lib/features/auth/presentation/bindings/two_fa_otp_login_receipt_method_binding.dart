import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_receipt_method_controller.dart';

class TwoFaOtpLoginReceiptMethodBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TwoFaOtpLoginReceiptMethodController>(
      TwoFaOtpLoginReceiptMethodController(
        args: Get.arguments,
      ),
    );
  }
}
