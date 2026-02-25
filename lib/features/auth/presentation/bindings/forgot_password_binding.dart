import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ForgotPasswordController>(
      ForgotPasswordController(
        args: Get.arguments,
      ),
    );
  }
}
