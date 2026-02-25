import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'hold_chat_feature_flag_model.g.dart';

@embedded
class HoldChatFeatureFlagModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  bool? withScroll;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  HoldChatFeatureFlagModel({
    this.enabled,
    this.withScroll,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static HoldChatFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return HoldChatFeatureFlagModel(
      enabled: json['enabled'],
      withScroll: json['withScroll'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() {
    return '[HoldChatFeatureFlagModel] enabled: $enabled,'
        ' withScroll: $withScroll';
  }
}
