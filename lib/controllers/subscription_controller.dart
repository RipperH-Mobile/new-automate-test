import 'dart:io';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/screens/premium_packages/repositories/premium_package_repository.dart';
import 'package:uchat/widgets.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find<SubscriptionController>();

  final _log = useLogger();
  bool isPurchasePendingAccDiff = false;
  final user = Get.find<UserController>();
  final inAppPurchaseCtl = InAppPurchaseController.instance;
  final RxList<SubscriptionProductModel> products = <SubscriptionProductModel>[].obs;

  List<String> get iosSubscriptionPackageIds => inAppPurchaseCtl.iosSubscriptionPackageIds;

  List<String> get androidSubscriptionPackageIds => inAppPurchaseCtl.androidSubscriptionPackageIds;

  Future<void> onInitSubscriptionData() async {
    try {
      if (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isWeb) {
        return;
      }
      await fetchInitialData();
    } catch (e, stackTrace) {
      _log.e('Error on onInitSubscriptionData', e, stackTrace);
    }
  }

  // Check with in app purchase service as well.
  SubscriptionProductModel? getActualPackageData(PremiumPackageCollection target, bool isMonthly) {
    return products.firstWhereOrNull(
      (e) {
        final c1 = e.productId.toLowerCase().contains(target.name!.toLowerCase());
        final c2 = e.productId.toLowerCase().contains(isMonthly == true ? '_1month' : '_1year');

        // ios
        final c3 = e.productId.toLowerCase().contains(isMonthly == true ? '_monthly' : '1_year');

        return c1 && (c2 || c3);
      },
    );
  }

  Future<void> handleIosManageSubscription() async {
    try {
      if (GetPlatform.isIOS) {
        final result = await GetIt.I<NativeMethodChannelService>().invokeMethod('iosManageSubscription');
        _log.d('result: $result');
      }
    } catch (e, stackTrace) {
      _log.e('Error on handleIosManageSubscription', e, stackTrace);
    }
  }

  Future<bool> checkPurchasePendingAccDiff() async {
    try {
      if (GetPlatform.isIOS || GetPlatform.isMacOS) {
        final receipt = await GetIt.I<NativeMethodChannelService>().invokeMethod('checkPurchasePendingAccDiff');

        if (receipt == null) return false;

        final data = await PremiumPackageRepository().checkIOSReceiptSubscription(receipt: receipt);
        _log.d(
          'checkPurchasePendingAccDiff checking response data ; ${data.toString()}\n'
          'originalAccountIdentifier: ${data.originalAccountIdentifier} == ${user.currentUser()?.id}\n'
          'isActiveSubscription: ${data.isActiveSubscription} \n'
          'username: ${data.username}',
        );

        if (data.originalAccountIdentifier == null ||
            data.originalAccountIdentifier == user.currentUser()?.id ||
            data.isActiveSubscription != true) {
          return false;
        }
      }
    } on ApiException catch (e, stackTrace) {
      // TODO: remove when service deploy to SIT
      _log.w('Warning this endpoint is not deploy on service checkPurchasePendingAccDiff', e, stackTrace);
      if (e.code == 404) {
        return false;
      }
    } catch (e, stackTrace) {
      _log.e('Error on checkPurchasePendingAccDiff', e, stackTrace);
    }

    return true;
  }

  Future<void> fetchInitialData() async {
    try {
      final packageIds =
          (Platform.isIOS || GetPlatform.isMacOS) ? iosSubscriptionPackageIds : androidSubscriptionPackageIds;
      final rawProductDetails = await inAppPurchaseCtl.getProductDetails(packageIds);
      rawProductDetails.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      //   final rawProductDetails = await inAppPurchaseCtl.getProductDetails(['black_test']);
      for (final product in rawProductDetails) {
        late SubscriptionProductModel detail;

        if (Platform.operatingSystem == 'android') {
          detail = SubscriptionProductModel.fromGooglePlayProductDetails(product as GooglePlayProductDetails);
          // _log.d('detail android: ${detail.productId}, ${detail.basePlanId}, ${detail.period}');
          products.add(detail);
        } else if (Platform.operatingSystem == 'ios' || GetPlatform.isMacOS) {
          /// iOS
          detail = SubscriptionProductModel.fromAppStoreProductDetails(product as AppStoreProductDetails);
          products.add(detail);

          // _log.d(
          //     'detail ios: ${product.title.toString()}, ${product.price.toString()}, ${product.description.toString()}');
        }
      }

      products.refresh();
    } catch (e, stackTrace) {
      _log.e('Error on fetchInitialData', e, stackTrace);
    }
  }

  Future<void> subscribe(SubscriptionProductModel? product) async {
    if (product == null) {
      UChatDialog.showUnknownProcessRequest();
      return;
    }

    if (UserController.instance.isCrossDoingProcess) {
      UChatDialog.showBlockCrossPlatformProcess();
      return;
    }

    if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      await UChatLoading.show(status: 'Checking...'.tr);
      try {
        isPurchasePendingAccDiff = await checkPurchasePendingAccDiff();
      } catch (e, stackTrace) {
        _log.e('Error on checkPurchasePendingAccDiff', e, stackTrace);
      } finally {
        await UChatLoading.hide();
      }
    }

    if (isPurchasePendingAccDiff == true) {
      UChatDialog.showExceptionDialog(
        title: 'Purchase Pending'.tr,
        description: 'You have already subscribed, either here or on another account. Please check back later.'.tr,
      );
      return;
    }
    try {
      if (GetPlatform.isAndroid) {
        inAppPurchaseCtl.buySubscription(product.productDetails);
      } else if (GetPlatform.isIOS || GetPlatform.isMacOS) {
        inAppPurchaseCtl.buySubscription(product.productDetails);
        // inAppPurchaseCtl.buyConsumable(product.productId);
      } else {
        UChatDialog.showUnknownProcessRequest();
      }
    } catch (e, stackTrace) {
      _log.e('Error on subscribe', e, stackTrace);
    }
  }

  int packageTierLevelCheck(String packageName, String period) {
    // packageName = scarlet, diamond, black
    // period = monthly, yearly
    // scarlet monthly = 1
    // scarlet yearly = 2
    // diamond monthly = 3
    // diamond yearly = 4
    // black monthly = 5
    // black yearly = 6

    if (packageName.toLowerCase().contains('scarlet') == true) {
      if (period.toLowerCase().contains('month') == true) {
        return 1;
      } else {
        return 2;
      }
    } else if (packageName.toLowerCase().contains('diamond') == true) {
      if (period.toLowerCase().contains('month') == true) {
        return 3;
      } else {
        return 4;
      }
    } else if (packageName.toLowerCase().contains('black') == true) {
      if (period.toLowerCase().contains('month') == true) {
        return 5;
      } else {
        return 6;
      }
    }
    return 0;
  }
}
