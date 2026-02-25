import 'package:get/get.dart';
import 'package:uchat/screens/premium_packages/compare/controllers/premium_package_compare_controller.dart';

class PremiumPackageCompareBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PremiumPackageCompareController>(PremiumPackageCompareController());
  }
}
