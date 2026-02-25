import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/login/login_with_email_controller.dart';

class LoginWithEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginWithEmailController>(
      LoginWithEmailController(),
    );
  }
}
