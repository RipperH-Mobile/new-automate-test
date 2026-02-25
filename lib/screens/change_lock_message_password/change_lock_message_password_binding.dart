import 'package:get/get.dart';
import 'package:uchat/screens/change_lock_message_password/change_lock_message_password_controller.dart';

class ChangeLockMessagePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangeLockMessagePasswordController>(ChangeLockMessagePasswordController());
  }
}
