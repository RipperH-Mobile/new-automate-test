// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

@immutable
class CoinPackageEntity {
  final String id;
  final String platform;
  final String productId;
  final int coin;
  final int bonus;
  final DateTime createdAt;
  final int purchased;
  final Map<String, String> description;
  final Map<String, String> image;
  final bool? isRecommended;
  final bool? isPromotion;
  final bool? isBestSeller;
  final double price;
  final String currencySymbol;
  final String currencyCode;

  const CoinPackageEntity({
    required this.id,
    required this.platform,
    required this.productId,
    required this.coin,
    this.bonus = 0,
    required this.createdAt,
    this.purchased = 0,
    required this.description,
    required this.image,
    this.isRecommended = false,
    this.isPromotion = false,
    this.isBestSeller = false,
    this.price = 0,
    this.currencySymbol = '',
    this.currencyCode = '',
  });

  factory CoinPackageEntity.fromMap(Map<String, dynamic> json) {
    // Provide a default empty map if the image or description is null.
    Map<String, String> description = {};
    Map<String, String> image = {};

    if (json['description'] != null) {
      description = Map<String, String>.from(json['description']);
    }
    if (json['image'] != null) {
      image = Map<String, String>.from(json['image']);
    }
    return CoinPackageEntity(
      id: json['_id'],
      platform: json['platform'],
      productId: json['productId'],
      coin: json['coin'],
      bonus: json['bonus'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      purchased: json['purchased'] ?? 0,
      description: description,
      image: image,
      isRecommended: json['isRecommended'],
      isPromotion: json['isPromotion'],
      isBestSeller: json['isBestSeller'],
    );
  }

  CoinPackageEntity copyWith({
    String? id,
    String? platform,
    String? productId,
    int? coin,
    int? bonus,
    DateTime? createdAt,
    int? purchased,
    Map<String, String>? description,
    Map<String, String>? image,
    bool? isRecommended,
    bool? isPromotion,
    bool? isBestSeller,
    double? price,
    String? currencySymbol,
    String? currencyCode,
  }) {
    return CoinPackageEntity(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      productId: productId ?? this.productId,
      coin: coin ?? this.coin,
      bonus: bonus ?? this.bonus,
      createdAt: createdAt ?? this.createdAt,
      purchased: purchased ?? this.purchased,
      description: description ?? this.description,
      image: image ?? this.image,
      isRecommended: isRecommended ?? this.isRecommended,
      isPromotion: isPromotion ?? this.isPromotion,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      price: price ?? this.price,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  @override
  String toString() {
    return 'CoinPackageEntity(id: $id, platform: $platform, productId: $productId, coin: $coin, bonus: $bonus, createdAt: $createdAt, purchased: $purchased, description: $description, image: $image, isRecommended: $isRecommended, isPromotion: $isPromotion, isBestSeller: $isBestSeller, price: $price, currencySymbol: $currencySymbol, currencyCode: $currencyCode)';
  }

  @override
  bool operator ==(covariant CoinPackageEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.platform == platform && other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ platform.hashCode ^ productId.hashCode;
  }

  bool get isBadgeVisible {
    return (isRecommended ?? false) || (isPromotion ?? false) || (isBestSeller ?? false);
  }

  String get badgeText {
    if (isRecommended ?? false) {
      return 'Recommended'.tr;
    } else if (isPromotion ?? false) {
      return 'Promotion'.tr;
    } else if (isBestSeller ?? false) {
      return 'Best seller'.tr;
    }
    return '';
  }

  bool get hasBonusCoin {
    return bonus > 0;
  }
}
