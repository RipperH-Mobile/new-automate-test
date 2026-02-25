import 'package:get/get.dart';

import 'form_textbox_controller.dart';

class FormTextboxBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FormTextboxController>(FormTextboxController());
  }
}
