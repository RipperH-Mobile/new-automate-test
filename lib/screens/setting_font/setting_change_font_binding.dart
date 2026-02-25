import 'package:get/get.dart';
import 'package:uchat/screens/setting_font/setting_change_font_controller.dart';

class SettingChangeFontBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingChangeFontController>(SettingChangeFontController());
  }
}
