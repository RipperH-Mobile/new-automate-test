import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'feature_ability_pin_model.g.dart';

@embedded
class FeatureAbilityPinModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  int? maxPin;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  FeatureAbilityPinModel({
    this.enabled,
    this.maxPin,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static FeatureAbilityPinModel fromMap(Map<String, dynamic> json) {
    return FeatureAbilityPinModel(
      enabled: json['enabled'],
      maxPin: json['maxPin'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() => 'FeatureAbilityPinModel(enabled: $enabled, maxPin: $maxPin)';
}
