import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:uchat/entities/collections/iap_transaction_collection.dart';

@immutable
class VerifyPurchaseAndroidRequest {
  final String purchaseId;
  final String productId;
  final String status;
  final String localVerificationData;
  final String serverVerificationData;

  const VerifyPurchaseAndroidRequest({
    required this.purchaseId,
    required this.productId,
    required this.status,
    required this.localVerificationData,
    required this.serverVerificationData,
  });

  static VerifyPurchaseAndroidRequest fromPurchaseDetails(PurchaseDetails detail) {
    return VerifyPurchaseAndroidRequest(
      purchaseId: detail.purchaseID ?? '',
      productId: detail.productID,
      status: detail.status.name,
      localVerificationData: detail.verificationData.localVerificationData,
      serverVerificationData: detail.verificationData.serverVerificationData,
    );
  }

  static VerifyPurchaseAndroidRequest fromIapTransactionCollection(IapTransactionCollection data) {
    return VerifyPurchaseAndroidRequest(
      purchaseId: data.id!,
      productId: data.productId!,
      status: data.status!,
      localVerificationData: data.localVerificationData!,
      serverVerificationData: data.serverVerificationData!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': Platform.isAndroid ? purchaseId : int.tryParse(purchaseId),
      'productId': productId,
      'status': status,
      'localVerificationData': localVerificationData,
      'serverVerificationData': serverVerificationData,
    };
  }
}

@immutable
class VerifyPurchaseAppleRequest {
  final String purchaseId;
  final String productId;
  final String? serverVerificationData;

  const VerifyPurchaseAppleRequest({
    required this.purchaseId,
    required this.productId,
    this.serverVerificationData,
  });

  static VerifyPurchaseAppleRequest fromPurchaseDetails(PurchaseDetails detail) {
    return VerifyPurchaseAppleRequest(
      purchaseId: detail.purchaseID ?? '',
      productId: detail.productID,
      serverVerificationData: detail.verificationData.serverVerificationData,
    );
  }

  static VerifyPurchaseAppleRequest fromIapTransactionCollection(IapTransactionCollection data) {
    return VerifyPurchaseAppleRequest(
      purchaseId: data.id!,
      productId: data.productId!,
      serverVerificationData: data.serverVerificationData!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': Platform.isAndroid ? purchaseId : int.tryParse(purchaseId),
      'productId': productId,
    };
  }
}
