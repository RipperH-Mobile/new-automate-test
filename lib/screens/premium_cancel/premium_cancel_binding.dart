import 'package:get/get.dart';
import 'package:uchat/screens/premium_cancel/premium_cancel_controller.dart';

class PremiumCancelBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PremiumCancelController>(PremiumCancelController());
  }
}
