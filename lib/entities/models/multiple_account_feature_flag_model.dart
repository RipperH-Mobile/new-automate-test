import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'multiple_account_feature_flag_model.g.dart';

@embedded
class MultipleAccountFeatureFlagModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  bool? canUseShortCutPasscode;
  bool? canHideFromList;
  int? maxMultipleAccount;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  MultipleAccountFeatureFlagModel({
    this.enabled,
    this.canUseShortCutPasscode,
    this.canHideFromList,
    this.maxMultipleAccount,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static MultipleAccountFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return MultipleAccountFeatureFlagModel(
      enabled: json['enabled'],
      canUseShortCutPasscode: json['canUseShortCutPasscode'],
      canHideFromList: json['canHideFromList'],
      maxMultipleAccount: json['maxMultipleAccount'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() {
    return '[MultipleAccountFeatureFlagModel] enabled: $enabled,'
        ' canUseShortCutPasscode: $canUseShortCutPasscode,'
        ' canHideFromList: $canHideFromList,'
        ' maxMultipleAccount: $maxMultipleAccount,';
  }
}
