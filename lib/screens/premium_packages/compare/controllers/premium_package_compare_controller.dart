import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/premium_packages/pack_detail/model/premium_package_detail_argument.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';

class PremiumPackageCompareController extends GetxController {
  final premiumPackages = <PremiumPackageCollection>[].obs;
  final levelFirstPackage = 0.obs;
  final levelSecondPackage = 1.obs;
  ScrollController scrollController = ScrollController();
  final isNotOnTopScreen = false.obs;
  final List<DropdownChoiceModel> listPackage = <DropdownChoiceModel>[
    DropdownChoiceModel(choiceName: 'Free', choiceIndex: 0),
    DropdownChoiceModel(choiceName: 'Scarlet', choiceIndex: 1),
    DropdownChoiceModel(choiceName: 'Diamond', choiceIndex: 2),
    DropdownChoiceModel(choiceName: 'Black', choiceIndex: 3),
  ];

  PremiumPackagesStoreController get premiumPackagesStoreController {
    if (!Get.isRegistered<PremiumPackagesStoreController>()) {
      Get.put(PremiumPackagesStoreController());
    }

    return Get.find<PremiumPackagesStoreController>();
  }

  @override
  void onInit() {
    super.onInit();
    premiumPackages.value = premiumPackagesStoreController.premiumPackages;
    scrollController.addListener(() {
      if (scrollController.offset > 200) {
        isNotOnTopScreen.value = true;
      } else {
        isNotOnTopScreen.value = false;
      }
    });
  }

  void setLevelFirstPackage(int value) {
    levelFirstPackage(value);
  }

  void setLevelSecondPackage(int value) {
    levelSecondPackage(value);
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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

  void handleOpenPremiumPackageDetailScreenFromDialog(String id) {
    int? currentLevel = premiumPackages.firstWhereOrNull((value) => value.id == id)?.level;

    if (currentLevel == null) {
      return;
    }

    if (currentLevel != premiumPackages.length - 1) {
      currentLevel++;
    } else {
      currentLevel = premiumPackages.length - 1;
    }

    final packageId = premiumPackages[currentLevel].id;
    if (packageId == null) {
      return;
    }

    Get.toNamed(
      Routes.settingPremiumPacksDetail,
      arguments: PremiumPackageDetailArgument(packageId: packageId),
    );
  }
}

class DropdownChoiceModel {
  String choiceName;
  int choiceIndex;

  DropdownChoiceModel({
    required this.choiceName,
    required this.choiceIndex,
  });
}
