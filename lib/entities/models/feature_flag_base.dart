import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';

part 'feature_flag_base.g.dart';

@embedded
class FeatureFlagBase implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  FeatureFlagBase({
    this.enabled,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static FeatureFlagBase fromMap(Map<String, dynamic> json) {
    return FeatureFlagBase(
      enabled: json['enabled'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() {
    return '[FeatureFlagBase] enabled: $enabled';
  }
}

abstract class FeatureFlagInterface {
  bool? enabled;
}

mixin class FeatureFlagContentInterface {
  CompareThemeContentModel? compareThemeContent;
  DetailThemeContentModel? detailThemeContentModel;
}
