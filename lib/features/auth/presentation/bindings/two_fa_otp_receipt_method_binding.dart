import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_receipt_method_controller.dart';

class TwoFaOtpReceiptMethodBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TwoFaOtpReceiptMethodController>(
      TwoFaOtpReceiptMethodController(
        args: Get.arguments,
      ),
    );
  }
}
