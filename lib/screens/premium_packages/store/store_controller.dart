import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/premium_packages/pack_detail/model/premium_package_detail_argument.dart';
import 'package:uchat/screens/premium_packages/repositories/premium_package_repository.dart';

final _log = useLogger();

class PremiumPackagesStoreController extends GetxController {
  static PremiumPackagesStoreController get instance => Get.find<PremiumPackagesStoreController>();

  final _premiumPackageTestRepository = PremiumPackageRepository();
  final premiumPackages = <PremiumPackageCollection>[].obs;
  final isInitial = true.obs;

  SubscriptionController get subscriptionController => SubscriptionController.instance;

  void handleBack() {
    Get.back();
  }

  Future<void> fetchPremiumPackage() async {
    try {
      isInitial(true);
      final premiumPackage = await _premiumPackageTestRepository.getAllPremiumPackage(isForceGetFromServer: true);
      premiumPackages.assignAll(premiumPackage);
    } catch (e, stacktrace) {
      _log.e('fetchPremiumPackage error.', e, stacktrace);
    } finally {
      isInitial(false);
    }
  }

  void handleOpenPremiumPackageDetailScreen(int index) {
    final packageId = premiumPackages[index].id;
    if (packageId == null) {
      return;
    }

    Get.toNamed(
      Routes.settingPremiumPacksDetail,
      arguments: PremiumPackageDetailArgument(packageId: packageId),
    );
  }
}
