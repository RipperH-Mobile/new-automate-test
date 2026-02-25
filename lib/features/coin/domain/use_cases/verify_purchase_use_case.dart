import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/coin/data/models/payloads/verify_purchase_payload.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyPurchaseParams<T> {
  final T purchaseDetails;

  const VerifyPurchaseParams({
    required this.purchaseDetails,
  });

  VerifyPurchaseAndroidRequest toAndroidRequest() {
    if (purchaseDetails is! PurchaseDetails) {
      throw ArgumentError('purchaseDetails must be of type PurchaseDetails');
    }

    final detail = purchaseDetails as PurchaseDetails;

    return VerifyPurchaseAndroidRequest(
      purchaseId: detail.purchaseID ?? '',
      productId: detail.productID,
      status: detail.status.name,
      localVerificationData: detail.verificationData.localVerificationData,
      serverVerificationData: detail.verificationData.serverVerificationData,
    );
  }

  VerifyPurchaseAppleRequest toAppleRequest() {
    if (purchaseDetails is! PurchaseDetails) {
      throw ArgumentError('purchaseDetails must be of type PurchaseDetails');
    }

    final detail = purchaseDetails as PurchaseDetails;

    return VerifyPurchaseAppleRequest(
      purchaseId: detail.purchaseID ?? '',
      productId: detail.productID,
      serverVerificationData: detail.verificationData.serverVerificationData,
    );
  }

  VerifyPurchaseAppleRequest fromSKPayment() {
    if (purchaseDetails is! SKPaymentTransactionWrapper) {
      throw ArgumentError('purchaseDetails must be of type SKPaymentTransactionWrapper');
    }

    final detail = purchaseDetails as SKPaymentTransactionWrapper;

    return VerifyPurchaseAppleRequest(
      purchaseId: detail.transactionIdentifier ?? '',
      productId: detail.payment.productIdentifier,
    );
  }
}

class VerifyPurchaseUseCase extends SimpleUseCase<bool, VerifyPurchaseParams> {
  final CoinRemoteRepository coinRemoteRepository;

  VerifyPurchaseUseCase({
    required this.coinRemoteRepository,
  });

  @override
  Future<bool> call(VerifyPurchaseParams params) async {
    if (Platform.isAndroid) {
      final request = params.toAndroidRequest();
      final response = await coinRemoteRepository.verifyPurchaseAndroid(request);
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      if (params.purchaseDetails is SKPaymentTransactionWrapper) {
        final request = params.fromSKPayment();
        final response = await coinRemoteRepository.verifyPurchaseApple(request);
        if (response != null) {
          return true;
        } else {
          return false;
        }
      }

      final request = params.toAppleRequest();
      final response = await coinRemoteRepository.verifyPurchaseApple(request);
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }
}
