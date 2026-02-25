import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/set_up_password/setup_password_controller.dart';

class SetupPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SetupPasswordController>(
      SetupPasswordController(),
    );
  }
}
