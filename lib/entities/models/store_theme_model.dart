import 'package:isar_community/isar.dart';

part 'store_theme_model.g.dart';

@embedded
class StoreThemeModel {
  String? textPrimaryColor;
  String? textSecondaryColor;
  String? textDesColor;
  String? textParamColor;
  String? bgColor;
  String? shadowColor;
  String? borderColor;
  String? bgItemColor1;
  String? bgItemColor2;
  List<String>? bgChipHeaderColor;
  String? textChipHeaderColor;
  String? shadowChipHeaderColor;
  String? advertisementText;

  StoreThemeModel({
    this.textPrimaryColor,
    this.textSecondaryColor,
    this.textDesColor,
    this.textParamColor,
    this.bgColor,
    this.shadowColor,
    this.borderColor,
    this.bgItemColor1,
    this.bgItemColor2,
    this.bgChipHeaderColor,
    this.textChipHeaderColor,
    this.shadowChipHeaderColor,
    this.advertisementText,
  });

  static StoreThemeModel fromMap(Map<String, dynamic> json) {
    return StoreThemeModel(
      textPrimaryColor: json['textPrimaryColor'],
      textSecondaryColor: json['textSecondaryColor'],
      textDesColor: json['textDesColor'],
      textParamColor: json['textParamColor'],
      bgColor: json['bgColor'],
      shadowColor: json['shadowColor'],
      borderColor: json['borderColor'],
      bgItemColor1: json['bgItemColor1'],
      bgItemColor2: json['bgItemColor2'],
      bgChipHeaderColor: json['bgChipHeaderColor'] != null
          ? (json['bgChipHeaderColor'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      textChipHeaderColor: json['textChipHeaderColor'],
      shadowChipHeaderColor: json['shadowChipHeaderColor'],
      advertisementText: json['advertisementText'],
    );
  }

  @override
  String toString() =>
      'FeatureContentModel(textPrimaryColor: $textPrimaryColor, textSecondaryColor: $textSecondaryColor,, textDesColor: $textDesColor, textParamColor: $textParamColor, bgColor: $bgColor, shadowColor: $shadowColor, borderColor: $borderColor, bgItemColor1: $bgItemColor1, bgItemColor2: $bgItemColor2, bgChipHeaderColor: $bgChipHeaderColor, textChipHeaderColor: $textChipHeaderColor, shadowChipHeaderColor: $shadowChipHeaderColor)';
}
