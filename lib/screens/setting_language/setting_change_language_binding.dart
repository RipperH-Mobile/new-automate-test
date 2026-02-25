import 'package:get/get.dart';

import 'setting_change_language_controller.dart';

class SettingChangeLanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingChangeLanguageController>(SettingChangeLanguageController());
  }
}
