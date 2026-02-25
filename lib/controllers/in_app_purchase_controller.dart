import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/screens/premium_packages/dialog/dialog_premium_package.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

/// Purchase error code
/// 1 : Purchase error from App store / Play store such as payment failed.
/// 2 : Verify purchase result from backend is null.
/// 3 : Calling complete purchase failed.
/// 4 : Purchase request to App store / Play store failed.
/// 5 : Purchase request to App store / Play store failed with IapError
/// 6 : Purchase request to App store / Play store failed with PlatformException
/// 7 : Purchase request to App store / Play store failed with unknown Exception
/// 8 : Unknown ApiException error from verify purchase.
/// 9 : Unknown Exception error from verify purchase.

class InAppPurchaseController extends GetxController {
  static InAppPurchaseController get instance => Get.find();

  UserEntity? get currentUser => UserController.instance.currentUser();

  final iapTransactionDb = IapTransactionDb();

  bool isRetrying = false;

  /// `showSuccessDialog` for check the requirement show one time when user subscribe
  /// skip to show success dialog if its renew.
  bool showSuccessDialog = false;
  DateTime recentlySubscribeDate = DateTime.now().toLocal();

  /// List of [PurchaseDetails] to temporary save purchase data when local db or socket
  /// is not connected yet.
  List<PurchaseDetails> purchaseBuffer = [];

  StreamSubscription? inAppPurchaseSub;
  StreamSubscription? userCheckedSub;

  String currentSubscriptionProductId = '';

  // Timer for UChatLoading timeout when buying Coin on iOS
  Timer? iOSCloseUChatLoadingTimer;
  StreamSubscription? _coinsUpdateSub;

  // Purchase deduplication fields
  final Set<String> _processedPurchaseIds = <String>{};

  final iosSubscriptionPackageIds = [
    'scarlet_monthly',
    'Scarlet_1_year',
    'Black_monthly',
    'Black_1_year',
    'Diamond_monthly',
    'Diamond_1_year',
  ];

  final androidSubscriptionPackageIds = [
    'scarlet_1month_test',
    'scarlet_1year_test',
    'diamond_1month_test',
    'diamond_1year_test',
    'black_1month_test',
    'black_1year_test_2',
  ];

  @override
  void onInit() {
    _coinsUpdateSub = eventBus.on<CoinUpdateEvent>().listen((event) {
      // This is used to hide UChatLoading for iOS only because verify purchase for iOS need to wait for state to confirm
      // that purchase is completed
      // CoinUpdateEvent came from UPDATE_COIN state which should mean that purchase is verified and completed and UChatLoading
      // can be closed.
      if (Platform.isIOS) {
        UChatLoading.hide();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    inAppPurchaseSub?.cancel();
    _coinsUpdateSub?.cancel();
    // Reset passcodePrevent to false just in case something happen and
    // preventActivate stuck to true forever.
    iOSCloseUChatLoadingTimer?.cancel();
    _processedPurchaseIds.clear();

    super.onClose();
  }

  void initInAppPurchase() async {
    final isAvailable = await isStoreAvailable();
    if (!isAvailable) return;
    if (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isWeb) {
      return;
    }

    inAppPurchaseSub = InAppPurchase.instance.purchaseStream.listen((event) {
      handlePurchaseEvent(event);
    });
  }

  bool isSubscriptionProduct(String productId) {
    if (productId.isEmpty) return false;
    return androidSubscriptionPackageIds.contains(productId) || iosSubscriptionPackageIds.contains(productId);
  }

  void setCurrentSubscriptionProductId({String? productId}) async {
    final isAvailable = await isStoreAvailable();
    if (!isAvailable) return;
    if (productId != null) {
      currentSubscriptionProductId = productId;
    } else {
      final user = UserController.instance.currentUser();
      if (user != null) {
        final premiumPackage = user.premiumPackage;
        if (premiumPackage != null) {
          if (GetPlatform.isIOS || GetPlatform.isMacOS) {
            currentSubscriptionProductId = premiumPackage.appleProductId ?? '';
          }

          if (GetPlatform.isAndroid) {
            currentSubscriptionProductId = premiumPackage.googleProductId ?? '';
          }
        }
      }
    }
  }

  void handlePurchaseEvent(List<PurchaseDetails> purchaseList) async {
    for (final purchase in purchaseList) {
      final purchaseId = purchase.purchaseID ?? '';

      if (purchaseId.isEmpty || _processedPurchaseIds.contains(purchaseId)) {
        continue;
      }

      _processedPurchaseIds.add(purchaseId);

      _log.d(
        'purchaseId is $purchaseId status is ${purchase.status}, error is ${purchase.error}, productId is ${purchase.productID}, transactionDate ${purchase.transactionDate}, -> pendingCompletePurchase is ${purchase.pendingCompletePurchase}',
      );

      if (isSubscriptionProduct(purchase.productID)) {
        await handleSubscriptionPurchase(purchase);
        await removeTransactionFromLocalDb(purchaseId);
      } else {
        if (purchase.status == PurchaseStatus.pending) {
          continue;
        } else {
          await handleCoinPurchase(purchase);
        }
      }
    }
  }

  Future<void> handleCoinPurchase(PurchaseDetails purchase) async {
    bool valid = false;
    if (purchase.status == PurchaseStatus.error) {
      handleInAppPurchaseError(purchase);
    } else if (purchase.status == PurchaseStatus.canceled) {
      await UChatLoading.hide();
      UChatNewDialog.showCancelPurchase(context: Get.context!);
    } else if (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored) {
      _log.d(
        'purchase data: purchaseID: ${purchase.purchaseID}, \n'
        'source: ${purchase.verificationData.source} , \n'
        'productID: ${purchase.productID}\n'
        'serverVerificationData: ${purchase.verificationData.serverVerificationData.length}, \n'
        'localVerificationData: ${purchase.verificationData.localVerificationData.length}, \n',
      );

      try {
        final socketCaller = GetIt.I<SocketCaller>();
        final httpCaller = GetIt.I<HttpCaller>();
        if (DbManager.instance.authenticatedInstance == null ||
            (!socketCaller.isConnected && httpCaller.accessToken == null)) {
          // If db is not initialized or when both socket is not connected and
          // http caller doesn't have a token should mean that this is when app open.
          // In this case save purchase data in purchaseBuffer to use it after
          // local db, socket and http caller has finished initializing in UserCheckEvent
          // subscription.
          purchaseBuffer.add(purchase);
          return;
        } else {
          // Otherwise save purchase in local db just in case.
          await saveTransactionToLocalDb(purchase);
        }

        // After purchase is complete remove purchase data from local db.
        await removeTransactionFromLocalDb(purchase.purchaseID ?? '');

        /// This statement is used for coin purchase
        valid = await GetIt.I<VerifyPurchaseUseCase>()
            .call(VerifyPurchaseParams<PurchaseDetails>(purchaseDetails: purchase));
        if (valid) {
          UChatLoading.success();
        } else {
          await UChatLoading.hide();
          UChatDialog.showExceptionDialog(
            description: 'Purchase failed error code = @errorCode'.trParams({
              'errorCode': '2',
            }),
          );
          GetIt.I<TaxonomyService>().sendEvent(
            EventName.coinPurchaseFailed,
            eventProperties: EventProperty.coinPurchaseFailed(
              '2',
              0,
              'INVALID_PURCHASE',
              'verifyPurchase to server failed with invalid purchase',
            ),
          );
        }
      } on ApiException catch (e, stackTrace) {
        _log.e('verifyPurchase ApiException error', e, stackTrace);
        await UChatLoading.hide();
        if (e.type == 'ERR_COIN_DUPLICATE_TOPUP') {
          // This error is very unlikely to happen here but just in case.
          // This means purchase is already verified. Just hide loading ui
          // and do nothing here.
          _log.w('This purchase ${purchase.purchaseID} is already verified.');
          // Remove purchase data because purchase is already complete.
          await removeTransactionFromLocalDb(purchase.purchaseID ?? '');
        } else if (e.type == 'ERR_COIN_TOPUP') {
          // Verify failed, This purchase is invalid.
          _log.w('This purchase ${purchase.purchaseID} is invalid.');
          // Remove purchase data because purchase is invalid.
          await removeTransactionFromLocalDb(purchase.purchaseID ?? '');
        } else if (e.type == 'ERR_COIN_PACKAGE_NOT_FOUND' || e.code == 413) {
          _log.w('This purchase ${purchase.purchaseID} service is not provide.');
          await removeTransactionFromLocalDb(purchase.purchaseID ?? '');
        } else {
          _log.e('verifyPurchase ApiException error', e, stackTrace);
          UChatDialog.showExceptionDialog(
            description: 'Purchase failed error code = @errorCode'.trParams({
              'errorCode': '8',
            }),
          );

          GetIt.I<TaxonomyService>().sendEvent(
            EventName.coinPurchaseFailed,
            eventProperties: EventProperty.coinPurchaseFailed(
              '8',
              0,
              'ApiException',
              'Purchase failed with ApiException',
            ),
          );
        }
      } catch (e, stackTrace) {
        _log.e('verifyPurchase error', e, stackTrace);

        await UChatLoading.hide();
        handleException(e, onUnknownException: () {
          UChatDialog.showExceptionDialog(
            description: 'Purchase failed error code = @errorCode'.trParams({
              'errorCode': '9',
            }),
          );
        });

        GetIt.I<TaxonomyService>().sendEvent(
          EventName.coinPurchaseFailed,
          eventProperties: EventProperty.coinPurchaseFailed(
            '9',
            0,
            'UnknownException',
            'Purchase failed with UnknownException',
          ),
        );
      }
    }
    _log.d('pendingCompletePurchase is ${purchase.pendingCompletePurchase}');
    try {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.coinPurchaseValidated,
        eventProperties: EventProperty.coinPurchaseValidated(
          purchase.productID,
          purchase.status.name,
          purchase.pendingCompletePurchase,
        ),
      );
      if ((purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored) && valid) {
        await InAppPurchase.instance.completePurchase(purchase);
        await UChatLoading.success();
      }
    } catch (e, stackTrace) {
      _log.e(
        'completePurchase purchaseId: ${purchase.purchaseID} productId : ${purchase.productID} error : ',
        e,
        stackTrace,
      );
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '3',
        }),
      );
    } finally {
      if (Platform.isIOS) {
        // For iOS wait for state from server to confirm that purchase is completed and coin is added to account before
        // closing UChatLoading but use timeout to close UChatLoading in case state is not received.
        iOSCloseUChatLoadingTimer = Timer(const Duration(seconds: 5), () {
          UChatLoading.hide();
        });
      } else {
        await UChatLoading.hide();
      }
    }
  }

  Future<void> handleSubscriptionPurchase(PurchaseDetails purchase) async {
    String code = '1';
    try {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.error:
          code = '2';
          showSuccessDialog = false;
          await handleInAppPurchaseError(purchase);
          await UChatLoading.hide();
          break;
        case PurchaseStatus.purchased:
          code = '3';
          // handleSubscriptionEvent(purchase);
          await completeHandlePurchase(purchase);
          break;
        case PurchaseStatus.restored:
          code = '4';
          showSuccessDialog = false;
          // handleSubscriptionEvent(purchase);
          await completeHandlePurchase(purchase);
          await UChatLoading.hide();
          break;
        case PurchaseStatus.canceled:
          showSuccessDialog = false;
          await UChatLoading.hide();
          UChatNewDialog.showCancelPurchase(context: Get.context!);
          break;
      }
    } catch (e, stackTrace) {
      showSuccessDialog = false;
      _log.e('handleSubscriptionPurchase error', e, stackTrace);
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': code,
        }),
      );
      await UChatLoading.hide();
    }
  }

  Future<void> completeHandlePurchase(PurchaseDetails purchase) async {
    try {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.coinPurchaseValidated,
        eventProperties: EventProperty.coinPurchaseValidated(
          purchase.productID,
          purchase.status.name,
          purchase.pendingCompletePurchase,
        ),
      );
      await InAppPurchase.instance.completePurchase(purchase);
      if (showSuccessDialog) {
        await UChatLoading.hide();
        await UChatLoading.show(status: 'syncing with server...'.tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> handleInAppPurchaseError(PurchaseDetails purchase) async {
    _log.e(
      'purchaseID: ${purchase.purchaseID} error: (${purchase.error?.code}) message=${purchase.error?.message} detail=${purchase.error?.details}',
    );
    await UChatLoading.hide();

    if (purchase.error != null && purchase.error?.details != null) {
      UChatDialog.showExceptionDialog(
        description: purchase.error?.details ?? '',
      );
    } else {
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '1',
        }),
      );
    }
    if (Platform.isAndroid && purchase.error?.message == 'BillingResponse.itemAlreadyOwned') {
      // Trigger retry verify purchase to finish previous purchase.
      await retryVerifyAndroidPurchase();
    }
  }

  void handleSubscriptionEventV2(String productId) {
    showDialogSuccess(productId);
    setCurrentSubscriptionProductId(productId: productId);
  }

  void showDialogSuccess(String packageName) {
    if (packageName.toLowerCase().contains('scarlet')) {
      UChatDialog.showCustomDialog<void, PremiumPackagesStoreController>(
        child: (_) => const DialogPremiumPackage(
          level: 1,
        ),
        init: PremiumPackagesStoreController(),
        barrierDismissible: false,
        bgDialogColor: Colors.transparent,
      );
    } else if (packageName.toLowerCase().contains('diamond')) {
      UChatDialog.showCustomDialog<void, PremiumPackagesStoreController>(
        child: (_) => const DialogPremiumPackage(
          level: 2,
        ),
        init: PremiumPackagesStoreController(),
        barrierDismissible: false,
        bgDialogColor: Colors.transparent,
      );
    } else if (packageName.toLowerCase().contains('black')) {
      UChatDialog.showCustomDialog<void, PremiumPackagesStoreController>(
        child: (_) => const DialogPremiumPackage(
          level: 3,
        ),
        init: PremiumPackagesStoreController(),
        barrierDismissible: false,
        bgDialogColor: Colors.transparent,
      );
    }
  }

  Future<void> saveTransactionToLocalDb(PurchaseDetails purchase) async {
    await iapTransactionDb.putTransaction(IapTransactionCollection(
      id: purchase.purchaseID,
      productId: purchase.productID,
      status: purchase.status.name,
      localVerificationData: purchase.verificationData.localVerificationData,
      serverVerificationData: purchase.verificationData.serverVerificationData,
    ));
  }

  Future<void> removeTransactionFromLocalDb(String purchaseId) async {
    await iapTransactionDb.deleteTransactionWithId(purchaseId);
    purchaseBuffer.removeWhere((element) => element.purchaseID == purchaseId);
  }

  /// Get all pending purchase and send verify request to backend.
  /// Used when open coin screen.
  Future<void> verifyAllPendingPurchase() async {
    final isAvailable = await isStoreAvailable();
    if (!isAvailable) return;
    if (isRetrying) {
      return;
    }
    if (Platform.isAndroid) {
      await retryVerifyAndroidPurchase();
    } else if (Platform.isIOS) {
      await retryVerifyIosPurchase();
    }
    isRetrying = false;
  }

  Future<void> savePurchaseBufferToLocalDb() async {
    final isAvailable = await isStoreAvailable();
    if (!isAvailable) return;

    for (final purchase in purchaseBuffer) {
      await saveTransactionToLocalDb(purchase);
    }
    purchaseBuffer.clear();
  }

  Future<bool> isStoreAvailable() async {
    return await InAppPurchase.instance.isAvailable();
  }

  /// Get product details from App store or Play store.
  /// Return detail of products in [productIdList] if it exists in App store or Play store.
  Future<List<ProductDetails>> getProductDetails(List<String> productIdList) async {
    try {
      final res = await InAppPurchase.instance.queryProductDetails(productIdList.toSet());

      if (res.notFoundIDs.isNotEmpty) {
        _log.w('product detail of these id not found : ${res.notFoundIDs}');
      }

      return res.productDetails;
    } catch (e, stackTrace) {
      _log.e('getProductDetails error', e, stackTrace);
      rethrow;
    }
  }

  /// Buy a consumable
  /// Status and result of each purchase can be tracked in [inAppPurchaseSub]
  void buyConsumable(String productId, int coin) async {
    _log.d('buyConsumable called : $productId');
    if (!(await isStoreAvailable())) {
      _log.e('Store is not available.');
      return;
    }
    try {
      await UChatLoading.show(status: 'processing'.tr);
      final product = ProductDetails(
        id: productId,
        title: '',
        description: '',
        price: '',
        rawPrice: 0,
        currencyCode: '',
      );

      final purchaseParam = PurchaseParam(
        productDetails: product,
        applicationUserName: UserController.instance.currentUser()?.purchaseRefId ?? '',
      );

      // Prevent passcode screen from showing up after payment is completed.
      eventBus.fire(PasscodePreventEvent(preventActivate: true));

      final requestPurchaseSuccess = await InAppPurchase.instance.buyConsumable(
        purchaseParam: purchaseParam,
        // Disable auto consume on Android, consume will be done from server side.
        autoConsume: Platform.isAndroid ? false : true,
      );
      if (!requestPurchaseSuccess) {
        _log.w('buyConsumable request failed !');
        UChatDialog.showExceptionDialog(
          description: 'Purchase failed error code = @errorCode'.trParams({
            'errorCode': '4',
          }),
        );
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.coinPurchaseFailed,
          eventProperties: EventProperty.coinPurchaseFailed('4', coin, '4', 'buyConsumable request failed'),
        );
      } else {
        // Log the purchase event for analytics
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.coinPurchaseInitiated,
          eventProperties: EventProperty.coinPurchaseInitiated(coin),
        );
      }
    } on IAPError catch (e, stackTrace) {
      _log.e('buyConsumable failed with IAPError', e, stackTrace);
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '5',
        }),
      );
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.coinPurchaseFailed,
        eventProperties: EventProperty.coinPurchaseFailed('5', coin, 'IAPError', 'buyConsumable failed with IAPError'),
      );
    } on PlatformException catch (e, stackTrace) {
      if (e.code.contains('purchase_cancelled')) {
        // User cancelled purchase, do nothing.
        UChatNewDialog.showCancelPurchase(context: Get.context!);
        return;
      }

      _log.e('buyConsumable failed with PlatformException', e, stackTrace);
      if (Platform.isIOS) {
        // In iOS if somehow completePurchase is not called and same product id
        // is bought again native will throw PlatformError with this code.
        if (e.code == 'storekit_duplicate_product_object') {
          await retryVerifyIosPurchase();
        } else if (e.code.contains('networkError') || e.code == 'storekit2_failed_to_fetch_product') {
          // Sometimes when network is offline storekit will throw PlatformException with a code networkError and a
          // bunch of native error codes.
          // Other times it throw storekit2_failed_to_fetch_product when it can not reach App Store.
          // But in both cases we show you are offline dialog.
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
          return;
        }
      }
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '6',
        }),
      );
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.coinPurchaseFailed,
        eventProperties: EventProperty.coinPurchaseFailed(
          '6',
          coin,
          'PlatformException',
          'buyConsumable failed with PlatformException',
        ),
      );
    } catch (e, stackTrace) {
      _log.e('buyConsumable failed', e, stackTrace);
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '7',
        }),
      );
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.coinPurchaseFailed,
        eventProperties: EventProperty.coinPurchaseFailed(
          '7',
          coin,
          'UnknownException',
          'buyConsumable failed with UnknownException',
        ),
      );
    } finally {
      await UChatLoading.hide();
    }
  }

  /// Buy a non consumable
  /// Status and result of each purchase can be tracked in [inAppPurchaseSub]
  Future<void> buySubscription(ProductDetails productDetails) async {
    _log.d('buySubscription called : ${productDetails.id}');
    if (!(await isStoreAvailable())) {
      _log.e('Store is not available.');
      return;
    }
    try {
      recentlySubscribeDate = DateTime.now().toLocal();
      showSuccessDialog = true;
      await UChatLoading.show(status: 'processing'.tr);

      PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: UserController.instance.currentUser()?.purchaseRefId ?? '',
      );

      if (GetPlatform.isAndroid) {
        final addition = InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        final purchases = await addition.queryPastPurchases();
        GooglePlayPurchaseDetails? oldGooglePlayPurchaseDetails;
        for (final purchase in purchases.pastPurchases) {
          if (purchase.status == PurchaseStatus.purchased) {
            oldGooglePlayPurchaseDetails = purchase;
            break;
          }
        }

        _log.d(
            'oldGooglePlayPurchaseDetails purchase complete: ${oldGooglePlayPurchaseDetails?.pendingCompletePurchase}');
        _log.d('oldGooglePlayPurchaseDetails: ${oldGooglePlayPurchaseDetails?.billingClientPurchase.originalJson}');
        _log.d('currentUserId: ${UserController.instance.currentUser()?.purchaseRefId}');

        if (oldGooglePlayPurchaseDetails != null) {
          final changeType = checkSubscriptionChangeAndroid(oldGooglePlayPurchaseDetails.productID, productDetails.id);
          ReplacementMode replacementNode = ReplacementMode.withTimeProration;
          if (changeType == -1) {
            replacementNode = ReplacementMode.deferred;
          }

          purchaseParam = GooglePlayPurchaseParam(
            productDetails: productDetails,
            applicationUserName: UserController.instance.currentUser()?.purchaseRefId ?? '',
            changeSubscriptionParam: ChangeSubscriptionParam(
              oldPurchaseDetails: oldGooglePlayPurchaseDetails,
              replacementMode: replacementNode,
            ),
          );
        } else {
          purchaseParam = GooglePlayPurchaseParam(
            productDetails: productDetails,
            applicationUserName: UserController.instance.currentUser()?.purchaseRefId ?? '',
          );
        }
      } else if (GetPlatform.isIOS) {
        var paymentWrapper = SKPaymentQueueWrapper();
        var transactions = await paymentWrapper.transactions();
        List<String> checkTransactions = [];
        for (SKPaymentTransactionWrapper purchase in transactions) {
          if (purchase.originalTransaction?.transactionIdentifier != null) {
            checkTransactions.add(purchase.originalTransaction!.transactionIdentifier!);
          }
        }

        // TODO: if service check checkTransactions is not contain this current user id
        // TODO: then show dialog can not buy subscription

        purchaseParam = AppStorePurchaseParam(
          productDetails: productDetails,
          applicationUserName: UserController.instance.currentUser()?.purchaseRefId ?? '',
        );
      }
      // Prevent passcode screen from showing up after payment is completed.
      eventBus.fire(PasscodePreventEvent(preventActivate: true));

      final requestPurchaseSuccess = await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      if (!requestPurchaseSuccess) {
        _log.w('buySubscription request failed !');
        await UChatLoading.hide();
        UChatDialog.showExceptionDialog(
          description: 'Purchase failed error code = @errorCode'.trParams({
            'errorCode': '4',
          }),
        );
      }
    } on IAPError catch (e, stackTrace) {
      showSuccessDialog = false;
      _log.e('buySubscription failed with IAPError : ', e, stackTrace);
      await UChatLoading.hide();
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '5',
        }),
      );
    } on PlatformException catch (e, stackTrace) {
      showSuccessDialog = false;
      _log.e('buySubscription failed with PlatformException : ', e, stackTrace);
      String description = 'Purchase failed error code = @errorCode'.trParams({
        'errorCode': '6',
      });
      if (Platform.isIOS) {
        // In iOS if somehow completePurchase is not called and same product id
        // is bought again native will throw PlatformError with this code.

        if (e.code == 'storekit_duplicate_product_object') {
          await retryVerifyIosPurchase();
          description =
              '${'There is a pending transaction for the same product identifier. Please either wait for it to be finished.'.tr} ${'Purchase failed error code = @errorCode'.trParams({
                'errorCode': '6',
              })}.';
        } else if (e.code.contains('networkError') || e.code == 'storekit2_failed_to_fetch_product') {
          // Sometimes when network is offline storekit will throw PlatformException with a code networkError and a
          // bunch of native error codes.
          // Other times it throw storekit2_failed_to_fetch_product when it can not reach App Store.
          // But in both cases we show you are offline dialog.
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
          return;
        }
      }
      await UChatLoading.hide();
      UChatDialog.showExceptionDialog(
        description: description,
      );
    } catch (e, stackTrace) {
      showSuccessDialog = false;
      _log.e('buySubscription failed : ', e, stackTrace);
      await UChatLoading.hide();
      UChatDialog.showExceptionDialog(
        description: 'Purchase failed error code = @errorCode'.trParams({
          'errorCode': '7',
        }),
      );
    }
  }

  int checkSubscriptionChangeAndroid(String oldProductId, String newProductId) {
    final hasProductId = androidSubscriptionPackageIds.contains(newProductId);
    if (hasProductId == false) {
      return 0;
    }

    final oldProductIndex = androidSubscriptionPackageIds.indexOf(oldProductId);
    final newProductIndex = androidSubscriptionPackageIds.indexOf(newProductId);

    if (oldProductIndex == -1 || newProductIndex == -1) {
      return 0;
    }

    if (oldProductIndex < newProductIndex) {
      return 1;
    } else if (oldProductIndex > newProductIndex) {
      return -1;
    }

    return 0;
  }

  /// ***
  /// For debug / dev only
  /// Call this function and [retryCompleteIosPurchase] to clear all pending transaction.
  /// ONLY when debugging to fix storekit_duplicate_product_object error because
  /// /// this function will complete purchase without verification.
  /// ***
  ///
  /// Call this function to remove all pending transaction in ios.
  /// This should fix storekit_duplicate_product_object error when user buy consumable
  /// successfully.
  Future<void> clearIosTransaction() async {
    var paymentWrapper = SKPaymentQueueWrapper();
    var transactions = await paymentWrapper.transactions();
    for (SKPaymentTransactionWrapper transaction in transactions) {
      _log.d('completing transaction : ${transaction.transactionIdentifier}');
      await paymentWrapper.finishTransaction(transaction);
    }
  }

  /// ***
  /// For debug / dev only
  /// consumePurchase should be handled by backend.
  /// ***
  ///
  /// Call this function to consume [purchase] consumable in Android.
  /// This should fix BillingResponse.itemAlreadyOwned error.
  Future<void> consumeAndroidConsumable(PurchaseDetails purchase) async {
    final InAppPurchaseAndroidPlatformAddition androidAddition =
        InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    await androidAddition.consumePurchase(purchase);
  }

  /// ***
  /// For debug / dev only
  /// Call this function and [clearIosTransaction] to clear all pending transaction.
  /// ONLY when debugging to fix storekit_duplicate_product_object error because
  /// this function will complete purchase without verification.
  /// ***
  ///
  /// Call this function to remove all pending transaction in ios.
  /// This should fix storekit_duplicate_product_object error when transaction is not
  /// completed but completePurchase is not called.
  Future<void> retryCompleteIosPurchase(String productId) async {
    // This purchase variable is used to complete purchase only. All data
    // in this variable is placeholder data.
    _log.d('retryCompleteIosPurchased called : $productId');
    PurchaseDetails purchase = AppStorePurchaseDetails(
      productID: productId,
      verificationData: PurchaseVerificationData(
        localVerificationData: '',
        serverVerificationData: '',
        source: '',
      ),
      transactionDate: '',
      status: PurchaseStatus.error,
      skPaymentTransaction: SKPaymentTransactionWrapper(
        payment: SKPaymentWrapper(productIdentifier: productId),
        transactionState: SKPaymentTransactionStateWrapper.failed,
      ),
    );
    // Calling completePurchase here to finish that product purchase flow
    // If completePurchase is not called, buying this productId will always
    // throw PlatformError.
    await InAppPurchase.instance.completePurchase(purchase);
  }

  /// Get all pending transaction from native then get verify data from local db
  /// then send it to backend to verify purchase.
  Future<void> retryVerifyAndroidPurchase() async {
    final InAppPurchaseAndroidPlatformAddition androidAddition =
        InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    final pastPurchaseList = (await androidAddition.queryPastPurchases()).pastPurchases;
    _log.d('pastPurchase length is ${pastPurchaseList.length}');
    for (GooglePlayPurchaseDetails purchase in pastPurchaseList) {
      _log.d('retrying verify purchase. purchaseId : ${purchase.purchaseID}');
      if (isSubscriptionProduct(purchase.productID)) {
        continue;
      }

      try {
        await GetIt.I<VerifyPurchaseUseCase>().call(VerifyPurchaseParams<PurchaseDetails>(purchaseDetails: purchase));
      } catch (e, stackTrace) {
        _log.e(
          'retryVerifyAndroidPurchase for purchase ${purchase.purchaseID} error',
          e,
          stackTrace,
        );
      }
    }
  }

  /// Get all pending transaction from native then get verify data from local db
  /// then send it to backend to verify purchase.
  Future<void> retryVerifyIosPurchase() async {
    _log.d('retrying verify purchase. iosSubscriptionPackageIds : ${iosSubscriptionPackageIds.map((e) => "$e, ")}');
    var paymentWrapper = SKPaymentQueueWrapper();
    var transactions = await paymentWrapper.transactions();
    for (SKPaymentTransactionWrapper purchase in transactions) {
      _log.d(
          'retrying verify purchase. length ${transactions.length} transactionId : ${purchase.transactionIdentifier}, transactionState : ${purchase.transactionState.name}, ${purchase.transactionState.index}');
      try {
        if (purchase.transactionIdentifier == null ||
            isSubscriptionProduct(purchase.payment.productIdentifier) == true) {
          // If transactionIdentifier is null, This purchase is cancelled and can be
          // finish immediately.
          _log.d('retrying isSubscriptionProduct productIdentifier: ${purchase.payment.productIdentifier}');
          _log.d('retrying verify purchase. transactionState : ${purchase.transactionState.name}');
          paymentWrapper.finishTransaction(purchase);
          continue;
        } else {
          // Otherwise query transaction data from local db and send data to server
          // to verify purchase.
          final transaction = await iapTransactionDb.getTransactionWithId(
            purchase.transactionIdentifier ?? '-',
          );

          _log.d('retrying verify purchase. transaction : $transaction ${transaction.toString()}');
          _log.d('retrying verify purchase. purchase : ${purchase.toString()}');
          final result = await GetIt.I<VerifyPurchaseUseCase>().call(
            VerifyPurchaseParams<SKPaymentTransactionWrapper>(purchaseDetails: purchase),
          );
          if (result != false) {
            await paymentWrapper.finishTransaction(purchase);
          }

          /// Because server doesn't need serverVerification data anymore (server can use purchaseId to query purchase
          /// data directly from app store) This transaction != null check is not necessary.
          /// Transaction collection is not needed anymore and can be remove but keep it for now.
          // if (transaction != null) {
          //   final result = await CoinService.instance.verifyPurchaseApple(
          //     VerifyPurchaseAppleRequest.fromIapTransactionCollection(transaction),
          //   );
          //   if (result != null) {
          //     await paymentWrapper.finishTransaction(purchase);
          //     await iapTransactionDb.deleteTransactionWithId(transaction.id!);
          //   }
          // } else {
          //   // This warning might be a false positive log. Caused by triggering retry
          //   // when purchase process is not completed yet.
          //   // Otherwise If it is not that case this mean verification data from App Store
          //   // is lost. Manual check from order id or some other data from admin side is needed to fix this.
          //   await paymentWrapper.finishTransaction(purchase);
          //   _log.w('Transaction with id ${purchase.transactionIdentifier} not found in local db.');
          // }
        }
      } on ApiException catch (e, stackTrace) {
        // TODO: Check this !!!!
        if (e.type == 'ERR_COIN_PACKAGE_NOT_FOUND' || e.code == 413) {
          await paymentWrapper.finishTransaction(purchase);
          final transaction = await iapTransactionDb.getTransactionWithId(
            purchase.transactionIdentifier ?? '-',
          );
          if (transaction != null) {
            await iapTransactionDb.deleteTransactionWithId(transaction.id!);
          }
        }
        if (e.type == 'ERR_COIN_DUPLICATE_TOPUP') {
          // The retry transaction is already verified in server so this transaction can be finished.
          await paymentWrapper.finishTransaction(purchase);
        } else {
          _log.e(
            'retryVerifyIosPurchase for purchase ${purchase.transactionIdentifier} error : ',
            e,
            stackTrace,
          );
        }
      } catch (e, stackTrace) {
        _log.e(
          'retryVerifyIosPurchase for purchase ${purchase.transactionIdentifier} error : ',
          e,
          stackTrace,
        );
      }
    }
  }

  /// Call this to go to Coin screen and open store bottom sheet immediately.
  Future<void> jumpToCoinStore() async {
    Get.toNamed(Routes.coinStore);
  }
}
