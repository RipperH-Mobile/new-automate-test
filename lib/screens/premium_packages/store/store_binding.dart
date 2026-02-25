import 'package:get/get.dart';
import 'store_controller.dart';

class PremiumPackagesStoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PremiumPackagesStoreController>(PremiumPackagesStoreController());
  }
}