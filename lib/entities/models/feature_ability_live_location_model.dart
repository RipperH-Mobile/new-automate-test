import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'feature_ability_live_location_model.g.dart';

@embedded
class FeatureAbilityLiveLocationModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  int? maxMinutes;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  FeatureAbilityLiveLocationModel({
    this.enabled,
    this.maxMinutes,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static FeatureAbilityLiveLocationModel fromMap(Map<String, dynamic> json) {
    return FeatureAbilityLiveLocationModel(
      enabled: json['enabled'],
      maxMinutes: json['maxMinutes'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() => 'FeatureAbilityLiveLocationModel(enabled: $enabled, maxMinutes: $maxMinutes)';
}
