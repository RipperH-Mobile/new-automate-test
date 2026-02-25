import 'package:get/get.dart';
import 'package:uchat/features/contact/presentation/controllers/reason_refund_coin_controller.dart';

class ReasonRefundCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReasonRefundCoinController>(ReasonRefundCoinController());
  }
}
