import 'package:get/get.dart';

import 'setting_troubleshoot_controller.dart';

class SettingTroubleshootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingTroubleshootController>(SettingTroubleshootController());
  }
}
