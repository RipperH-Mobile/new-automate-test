import 'package:get/get.dart';
import 'package:uchat/screens/setting_devices_manager/setting_devices_manager_controller.dart';

class SettingDevicesManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingDevicesManagerController>(
      SettingDevicesManagerController(
        actionToken: Get.arguments,
      ),
    );
  }
}
