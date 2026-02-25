import 'package:get/get.dart';
import 'package:uchat/screens/setting_premium_package/setting_premium_package_controller.dart';

class SettingPremiumPackageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingPremiumPackageController>(SettingPremiumPackageController());
  }
}
