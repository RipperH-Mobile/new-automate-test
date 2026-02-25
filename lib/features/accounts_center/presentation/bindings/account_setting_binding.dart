import 'package:get/get.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/account_setting_controller.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountSettingController());
  }
}
