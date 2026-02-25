import 'package:get/get.dart';
import 'package:uchat/screens/setting_help_center/setting_help_center_controller.dart';

class SettingHelpCenterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingHelpCenterController>(SettingHelpCenterController());
  }
}
