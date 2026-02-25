import 'package:get/get.dart';

import 'setting_call_controller.dart';

class SettingCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingCallController>(SettingCallController());
  }
}
