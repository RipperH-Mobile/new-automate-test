import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/pay_store_type.dart';
import 'package:uchat/entities/enum/subscription_period_type.dart';

part 'premium_package_model.g.dart';

@embedded
class PremiumPackageModel {
  String? premiumPackageId;
  @Enumerated(EnumType.name)
  PayStoreType? payStore;
  @Enumerated(EnumType.name)
  SubscriptionPeriodType? periodType;

  String? premiumPackageName;

  DateTime? subscribeAt;
  DateTime? expireAt;
  DateTime? nextReviewAt;
  DateTime? reviewAt;

  String? googleOrderId;
  String? googleProductId;

  String? appleOrderId;
  String? appleProductId;

  bool isAutoRenew;

  DateTime? nextRefundReasonAt;

  PremiumPackageModel({
    this.premiumPackageId,
    this.payStore,
    this.periodType,
    this.premiumPackageName,
    this.subscribeAt,
    this.expireAt,
    this.nextReviewAt,
    this.reviewAt,
    this.googleOrderId,
    this.googleProductId,
    this.appleOrderId,
    this.appleProductId,
    this.isAutoRenew = true,
    this.nextRefundReasonAt,
  });

  /// Data from server
  ///
  /// ```json
  /// {
  ///   "premiumPackageId": "66f510a40ab83c1ba463837c",
  ///   "payStore": "NONE",
  ///   "periodType": "NONE",
  ///   "isAutoRenew": true,
  ///   "_id": "681c30a74adacca8dd1a9d42",
  ///   "premiumPackageName": "Free"
  /// }
  /// ```
  static PremiumPackageModel fromMap(Map<String, dynamic> json) {
    return PremiumPackageModel(
      premiumPackageId: json['premiumPackageId'],
      payStore: json['payStore'] != null ? PayStoreType.from(json['payStore']) : null,
      periodType: json['periodType'] != null ? SubscriptionPeriodType.from(json['periodType']) : null,
      premiumPackageName: json['premiumPackageName'],
      subscribeAt: json['subscribeAt'] != null ? DateTime.tryParse(json['subscribeAt'].toString()) : null,
      expireAt: json['expireAt'] != null ? DateTime.tryParse(json['expireAt'].toString()) : null,
      nextReviewAt: json['nextReviewAt'] != null ? DateTime.tryParse(json['nextReviewAt'].toString()) : null,
      reviewAt: json['reviewAt'] != null ? DateTime.tryParse(json['reviewAt'].toString()) : null,
      googleOrderId: json['googleOrderId'],
      googleProductId: json['googleProductId'],
      appleOrderId: json['appleOrderId'],
      appleProductId: json['appleProductId'],
      isAutoRenew: json['isAutoRenew'] ?? true,
      nextRefundReasonAt:
          json['nextRefundReasonAt'] != null ? DateTime.tryParse(json['nextRefundReasonAt'].toString()) : null,
    );
  }

  @override
  String toString() =>
      'PremiumPackageModel(premiumPackageId: $premiumPackageId, payStore: $payStore, periodType: $periodType)';
}
