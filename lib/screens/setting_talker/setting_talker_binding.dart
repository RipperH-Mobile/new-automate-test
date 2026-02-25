import 'package:get/get.dart';
import 'setting_talker_controller.dart';

class SettingTalkerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingTalkerController>(SettingTalkerController());
  }
}
