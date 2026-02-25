import 'package:get/get.dart';
import 'package:uchat/features/accounts_center/presentation/controllers/select_account_controller.dart';

class SelectAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SelectAccountController>(SelectAccountController());
  }
}
