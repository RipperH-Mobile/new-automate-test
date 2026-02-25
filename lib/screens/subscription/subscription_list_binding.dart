import 'package:get/get.dart';
import 'package:uchat/controllers.dart';

class SubscriptionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubscriptionController>(SubscriptionController());
  }
}
