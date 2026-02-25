import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_model.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/dialog_theme_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/chat_folder_feature_flag_model.dart';
import 'package:uchat/entities/models/feature_ability_live_location_model.dart';
import 'package:uchat/entities/models/feature_ability_pin_model.dart';
import 'package:uchat/entities/models/feature_ability_secret_room_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';
import 'package:uchat/entities/models/hold_chat_feature_flag_model.dart';
import 'package:uchat/entities/models/multiple_account_feature_flag_model.dart';
import 'package:uchat/entities/models/premium_package_language_model.dart';
import 'package:uchat/entities/models/feature_model.dart';
import 'package:uchat/entities/models/pack_detail_theme_model.dart';
import 'package:uchat/entities/models/store_theme_model.dart';
import 'package:uchat/utils/datetime.dart';

import 'package:uchat/utils/fast_hash.dart';

part 'premium_package_collection.g.dart';

@Collection(accessor: 'premiumPackages')
@Name('PremiumPackage')
class PremiumPackageCollection {
  @Index(unique: true)
  String? id;

  Id get isarId => fastHash(id!);

  String? name;

  FeatureModel? features;

  String? appleRef;

  String? googleRef;

  DateTime? updateAt;

  bool? isPublish;
  int? level;

  double? monthlyPrice;
  double? yearlyPrice;

  String? linkUrl;
  CompareThemeModel? compareTheme;
  StoreThemeModel? storeTheme;
  PackDetailThemeModel? packDetailTheme;
  DialogThemeModel? dialogTheme;

  PremiumPackageCollection({
    required this.id,
    this.name,
    this.features,
    this.appleRef,
    this.googleRef,
    this.updateAt,
    this.isPublish,
    this.level,
    this.monthlyPrice,
    this.yearlyPrice,
    this.linkUrl,
    this.compareTheme,
    this.storeTheme,
    this.packDetailTheme,
    this.dialogTheme,
  });

  void update(PremiumPackageCollection other) {
    if (other.id != null) {
      id = other.id;
    }

    if (other.name != null) {
      name = other.name;
    }
    if (other.features != null) {
      features = other.features;
    }

    if (other.appleRef != null) {
      appleRef = other.appleRef;
    }

    if (other.googleRef != null) {
      googleRef = other.googleRef;
    }

    if (other.updateAt != null) {
      updateAt = other.updateAt;
    }
    if (other.isPublish != null) {
      isPublish = other.isPublish;
    }
    if (other.level != null) {
      level = other.level;
    }
    if (other.monthlyPrice != null) {
      monthlyPrice = other.monthlyPrice;
    }
    if (other.yearlyPrice != null) {
      yearlyPrice = other.yearlyPrice;
    }
    if (other.linkUrl != null) {
      linkUrl = other.linkUrl;
    }
    if (other.compareTheme != null) {
      compareTheme = other.compareTheme;
    }
    if (other.storeTheme != null) {
      storeTheme = other.storeTheme;
    }
    if (other.packDetailTheme != null) {
      packDetailTheme = other.packDetailTheme;
    }
    if (other.dialogTheme != null) {
      dialogTheme = other.dialogTheme;
    }
  }

  PremiumPackageCollection copyWith({
    String? id,
    String? name,
    FeatureModel? features,
    String? appleRef,
    String? googleRef,
    DateTime? updateAt,
    bool? isPublish,
    int? level,
    double? monthlyPrice,
    double? yearlyPrice,
    String? linkUrl,
    CompareThemeModel? compareTheme,
    StoreThemeModel? storeTheme,
    PackDetailThemeModel? packDetailTheme,
    DialogThemeModel? dialogTheme,
  }) {
    return PremiumPackageCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      features: features ?? this.features,
      appleRef: appleRef ?? this.appleRef,
      googleRef: googleRef ?? this.googleRef,
      updateAt: updateAt ?? this.updateAt,
      isPublish: isPublish ?? this.isPublish,
      level: level ?? this.level,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      yearlyPrice: yearlyPrice ?? this.yearlyPrice,
      linkUrl: linkUrl ?? this.linkUrl,
      compareTheme: compareTheme ?? this.compareTheme,
      storeTheme: storeTheme ?? this.storeTheme,
      packDetailTheme: packDetailTheme ?? this.packDetailTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'features': features,
      'appleRef': appleRef,
      'googleRef': googleRef,
      'updateAt': updateAt.toString(),
      'isPublish': isPublish,
      'level': level,
      'monthlyPrice': monthlyPrice,
      'yearlyPrice': yearlyPrice,
      'linkUrl': linkUrl,
      'compareTheme': compareTheme,
      'storeTheme': storeTheme,
      'packDetailTheme': packDetailTheme,
      'dialogTheme': dialogTheme,
    };
  }

  factory PremiumPackageCollection.fromMap(Map<String, dynamic> map) {
    return PremiumPackageCollection(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      appleRef: map['appleRef'] != null ? map['appleRef'] as String : null,
      googleRef: map['googleRef'] != null ? map['googleRef'] as String : null,
      updateAt: map['updatedAt'] != null ? strToDateTime(map['updatedAt']) : null,
      isPublish: map['isPublish'] != null ? map['isPublish'] as bool : false,
      monthlyPrice: map['priceByMonth'] != null
          ? (map['priceByMonth'] is int ? (map['priceByMonth'] as int).toDouble() : map['priceByMonth'] as double)
          : null,
      yearlyPrice: map['priceByYear'] != null
          ? (map['priceByYear'] is int ? (map['priceByYear'] as int).toDouble() : map['priceByYear'] as double)
          : null,
      linkUrl: map['linkUrl'] != null ? map['linkUrl'] as String : null,
      level: map['level'] != null ? map['level'] as int : null,
      features: map['features'] != null ? FeatureModel.fromMap(map['features']) : null,
      compareTheme: map['compareTheme'] != null ? CompareThemeModel.fromMap(map['compareTheme']) : null,
      storeTheme: map['storeTheme'] != null ? StoreThemeModel.fromMap(map['storeTheme']) : null,
      packDetailTheme: map['detailTheme'] != null ? PackDetailThemeModel.fromMap(map['detailTheme']) : null,
      dialogTheme: map['dialogTheme'] != null ? DialogThemeModel.fromMap(map['dialogTheme']) : null,
    );
  }

  String toJsonString() => json.encode(toMap());

  @override
  String toString() {
    return 'PremiumPackageCollection(id: $id, name: $name, features: $features, appleRef: $appleRef, googleRef: $googleRef, updateAt: $updateAt, isPublish: $isPublish, level: $level)';
  }

  @override
  bool operator ==(covariant PremiumPackageCollection other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
