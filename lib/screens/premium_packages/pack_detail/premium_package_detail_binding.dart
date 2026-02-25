import 'package:get/get.dart';
import 'package:uchat/screens/premium_packages/pack_detail/controller/premium_package_detail_controller.dart';

class PremiumPackageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PremiumPackageDetailController>(() => PremiumPackageDetailController());
  }
}
