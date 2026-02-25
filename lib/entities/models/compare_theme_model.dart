import 'package:isar_community/isar.dart';

part 'compare_theme_model.g.dart';

@embedded
class CompareThemeModel {
  String? titleFeatureColor;
  String? descriptionFeatureColor;
  List<String>? viewingBgBtnColor;
  String? viewingBtnDropShadowColor;
  String? viewingBtnDropShadowOpacity;
  String? viewingBtnInnerShadowColor;
  String? viewingBtnInnerShadowOpacity;
  String? featureBgEven;
  String? featureBgOdd;
  String? borderColor;

  CompareThemeModel({
    this.titleFeatureColor,
    this.descriptionFeatureColor,
    this.viewingBgBtnColor,
    this.viewingBtnDropShadowColor,
    this.viewingBtnDropShadowOpacity,
    this.viewingBtnInnerShadowColor,
    this.viewingBtnInnerShadowOpacity,
    this.featureBgEven,
    this.featureBgOdd,
    this.borderColor,
  });

  static CompareThemeModel fromMap(Map<String, dynamic> json) {
    return CompareThemeModel(
      titleFeatureColor: json['titleFeatureColor'],
      descriptionFeatureColor: json['descriptionFeatureColor'],
      viewingBgBtnColor: json['viewingBgColorBtn'] != null
          ? (json['viewingBgColorBtn'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      viewingBtnDropShadowColor: json['viewingBtnDropShadowColor'],
      viewingBtnDropShadowOpacity: json['viewingBtnDropShadowOpacity'],
      viewingBtnInnerShadowColor: json['viewingBtnInnerShadowColor'],
      viewingBtnInnerShadowOpacity: json['viewingBtnInnerShadowOpacity'],
      featureBgEven: json['featureBgEven'],
      featureBgOdd: json['featureBgOdd'],
      borderColor: json['borderColor'],
    );
  }

  @override
  String toString() =>
      'FeatureContentModel(titleFeatureColor: $titleFeatureColor, descriptionFeatureColor: $descriptionFeatureColor  ,, viewingBgBtnColor: $viewingBgBtnColor, viewingBtnDropShadowColor: $viewingBtnDropShadowColor, eatureColor, viewingBtnDropShadowOpacity: $viewingBtnDropShadowOpacity, viewingBtnInnerShadowColor: $viewingBtnInnerShadowColor, viewingBtnInnerShadowOpacity: $viewingBtnInnerShadowOpacity, featureBgEven: $featureBgEven, featureBgOdd: $featureBgOdd, borderColor: $borderColor )';
}
