import 'package:get/get.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/accounts_center_controller.dart';

class AccountsCenterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AccountsCenterController());
  }
}
