import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/login_welcome/login_welcome_controller.dart';

class LoginWelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginWelcomeController>(
      LoginWelcomeController(
        args: Get.arguments,
      ),
    );
  }
}
