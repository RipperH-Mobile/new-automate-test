import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/in_app_purchase_controller.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/domain/events/coin_update_event.dart';
import 'package:uchat/features/coin/domain/events/start_announcement_event.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_coin_packages_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/fetch_my_coin_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/get_coin_ads_use_case.dart';
import 'package:uchat/features/coin/domain/use_cases/get_coin_promotion_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class CoinStoreIds {
  static const String coinBalance = 'coinBalance';
  static const String coinItemList = 'coinItemList';
  static const String coinAds = 'coinAds';
}

class CoinStoreController extends GetxController {
  int coinBalance = 0;
  int sandboxCoinBalance = 0;
  List<CoinPackageEntity> coinPackages = [];

  bool isLoadingMyCoin = true;
  bool isLoadingCoinPackages = true;
  bool isLoadingCoinAds = true;

  String coinAdsText = '';

  StreamSubscription? _startCoinPromotionAnnouncementSub;
  StreamSubscription? _coinsUpdateSub;

  InAppPurchaseController get inAppPurchaseCtl => InAppPurchaseController.instance;

  @override
  void onInit() {
    super.onInit();

    _startCoinPromotionAnnouncementSub = eventBus.on<StartAnnouncementEvent>().listen(
      (event) {
        onShowCoinPromotionDialog();
      },
    );

    _coinsUpdateSub = eventBus.on<CoinUpdateEvent>().listen(onUpdateCoinEvent);

    fetchInitialMyCoin();
    fetchInitialPackages();
    onShowCoinPromotionDialog();
    verifyAllPendingPurchase();
    onGetCoinAds();
    actionTracking();
  }

  @override
  void onClose() {
    _startCoinPromotionAnnouncementSub?.cancel();
    _coinsUpdateSub?.cancel();
    super.onClose();
  }

  void onGoToCoinHistory() {
    Get.toNamed(Routes.coinHistory);
  }

  void actionTracking() {
    final previousPage = Get.previousRoute;
    String entryPoint = 'unknown';

    if (previousPage.startsWith('/sticker')) {
      entryPoint = 'sticker page';
    } else {
      entryPoint = 'setting page';
    }

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.coinStoreViewed,
      eventProperties: EventProperty.coinStoreViewed(entryPoint),
    );
  }

  Future<void> fetchInitialMyCoin() async {
    try {
      final myCoin = await GetIt.I<FetchMyCoinUseCase>().call(NoParams());
      coinBalance = myCoin?.coins ?? 0;
      sandboxCoinBalance = myCoin?.sandboxCoin ?? 0;
    } on FailedHostLookupException catch (_) {
      await UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      Get.back();
    } catch (e, stackTrace) {
      _log.e('Error fetching my coin', e, stackTrace);
    } finally {
      isLoadingMyCoin = false;
      update([CoinStoreIds.coinBalance]);
    }
  }

  Future<void> fetchInitialPackages() async {
    try {
      final packages = await GetIt.I<FetchCoinPackagesUseCase>().call(NoParams());
      if (packages.isEmpty) {
        _log.w('No coin packages found');
        return;
      }
      final packageIds = packages.map((e) => e.productId).toSet();
      final productDetails = await inAppPurchaseCtl.getProductDetails(packageIds.toList());

      for (final detail in productDetails) {
        final packageIndex = packages.indexWhere((pkg) => pkg.productId == detail.id);
        if (packageIndex != -1) {
          packages[packageIndex] = packages[packageIndex].copyWith(
            price: detail.rawPrice,
            currencyCode: detail.currencyCode,
            currencySymbol: detail.currencySymbol,
          );
        } else {
          packages.removeAt(packageIndex);
        }
      }

      coinPackages.assignAll(packages);
    } catch (e, stackTrace) {
      _log.e('Error fetching coin packages', e, stackTrace);
    } finally {
      isLoadingCoinPackages = false;
      update([CoinStoreIds.coinItemList]);
    }
  }

  Future<void> onGetCoinAds() async {
    try {
      if (isLoadingCoinAds == false) {
        isLoadingCoinAds = true;
        update([CoinStoreIds.coinAds]);
      }

      final coinAds = await GetIt.I<GetCoinAdsUseCase>().call(GetCoinAdsParams(currentRoute: Get.currentRoute));

      if (coinAds == null) {
        return;
      }

      final texts = coinAds.getText(Get.locale?.languageCode ?? 'EN');
      if (texts.isEmpty) {
        return;
      }

      coinAdsText = texts;
    } catch (e, stackTrace) {
      _log.e('Error fetching coin ads', e, stackTrace);
    } finally {
      isLoadingCoinAds = false;
      update([CoinStoreIds.coinAds]);
    }
  }

  Future<void> onShowCoinPromotionDialog() async {
    try {
      final coinPromotion = await GetIt.I<GetCoinPromotionUseCase>().call(
        GetCoinPromotionParams(currentRoute: Get.currentRoute),
      );

      if (coinPromotion == null) {
        return;
      }

      if (coinPromotion.image?.isEmpty == true) {
        _log.w('Coin promotion has no image');
        return;
      }

      await UChatNewDialog.showCoinPromotion(coinPromotion: coinPromotion);
    } catch (e, stackTrace) {
      _log.e('Error showing coin promotion dialog', e, stackTrace);
    }
  }

  Future<void> buyCoinPackage(CoinPackageEntity coinPackage) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.coinPackageSelected,
      eventProperties: EventProperty.coinPackageSelected(coinPackage.coin),
    );

    inAppPurchaseCtl.buyConsumable(coinPackage.productId, coinPackage.coin);
  }

  Future<void> onUpdateCoinEvent(CoinUpdateEvent event) async {
    final coinAccount = event.coinUpdateResponse.account;
    final transaction = event.coinUpdateResponse.transaction;

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.coinPurchaseCompleted,
      eventProperties: EventProperty.coinPurchaseCompleted(transaction.id, transaction.amount),
    );

    coinBalance = coinAccount.coins;
    sandboxCoinBalance = coinAccount.sandboxCoin;
    update([CoinStoreIds.coinBalance]);
  }

  Future<void> verifyAllPendingPurchase() async {
    try {
      await inAppPurchaseCtl.verifyAllPendingPurchase();
    } catch (e, stackTrace) {
      _log.w('Error verifying pending purchases', e, stackTrace);
    }
  }
}
