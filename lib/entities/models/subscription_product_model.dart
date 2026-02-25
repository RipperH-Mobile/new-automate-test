import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class SubscriptionProductModel {
  final String productId;
  final String title;
  final String? description;
  final double price;
  final String currency;
  final String formattedPrice;
  final String billingPeriod;
  final String basePlanId;
  final ProductDetails productDetails;

  SubscriptionProductModel({
    required this.productId,
    required this.title,
    this.description,
    required this.price,
    required this.currency,
    required this.formattedPrice,
    required this.billingPeriod,
    required this.basePlanId,
    required this.productDetails,
  });

  ProductDetailsWrapper get androidProductDetail => (productDetails as GooglePlayProductDetails).productDetails;

  SKProductWrapper get iosProductDetail => (productDetails as AppStoreProductDetails).skProduct;

  String get period {
    if (Platform.operatingSystem == 'android') {
      if (billingPeriod == 'P1W') {
        return 'week';
      } else if (billingPeriod == 'P1M') {
        return 'month';
      } else if (billingPeriod == 'P3M') {
        return '3 months';
      } else if (billingPeriod == 'P6M') {
        return '6 months';
      } else if (billingPeriod == 'P1Y') {
        return 'year';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  factory SubscriptionProductModel.fromGooglePlayProductDetails(GooglePlayProductDetails productDetails) {
    final SubscriptionOfferDetailsWrapper? subscriptionOffDetails =
        productDetails.productDetails.subscriptionOfferDetails?[productDetails.subscriptionIndex!];

    return SubscriptionProductModel(
      productId: productDetails.id,
      title: productDetails.title,
      description: productDetails.description,
      price: productDetails.rawPrice,
      currency: productDetails.currencyCode,
      formattedPrice: productDetails.price,
      billingPeriod: subscriptionOffDetails?.pricingPhases.firstOrNull?.billingPeriod ?? '',
      basePlanId: subscriptionOffDetails?.basePlanId ?? '',
      productDetails: productDetails,
    );
  }

  factory SubscriptionProductModel.fromAppStoreProductDetails(AppStoreProductDetails productDetails) {
    return SubscriptionProductModel(
      productId: productDetails.id,
      title: productDetails.title,
      description: productDetails.description,
      price: productDetails.rawPrice,
      currency: productDetails.currencyCode,
      formattedPrice: productDetails.price,
      billingPeriod: '',
      basePlanId: '',
      productDetails: productDetails,
    );
  }

  @override
  String toString() {
    return 'SubscriptionProductModel(productId: $productId, title: $title, description: $description, price: $price, currency: $currency, formattedPrice: $formattedPrice, billingPeriod: $billingPeriod, basePlanId: $basePlanId, productDetails: $productDetails)';
  }
}
