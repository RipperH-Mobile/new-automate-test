import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'feature_ability_secret_room_model.g.dart';

@embedded
class FeatureAbilitySecretRoomModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  int? maxSecond;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  FeatureAbilitySecretRoomModel({
    this.enabled,
    this.maxSecond,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static FeatureAbilitySecretRoomModel fromMap(Map<String, dynamic> json) {
    return FeatureAbilitySecretRoomModel(
      enabled: json['enabled'],
      maxSecond: json['maxSecond'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() =>
      'FeatureAbilitySecretRoomModel(enabled: $enabled, maxSecond: $maxSecond, compareThemeContent : $compareThemeContent)';
}
