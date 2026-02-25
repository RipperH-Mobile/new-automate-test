import 'package:get/get.dart';

import '../arguments/passcode_arguments.dart';
import '../controllers/passcode_controller.dart';

class PasscodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PasscodeController>(
      PasscodeController(),
      tag: (Get.arguments as PasscodeArguments).controllerTag,
    );
  }
}
