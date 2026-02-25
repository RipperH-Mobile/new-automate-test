import 'package:isar_community/isar.dart';

part 'dialog_theme_model.g.dart';

@embedded
class DialogThemeModel {
  String? titleTextColor;
  String? subTitleTextColor;
  String? descriptionColor;
  List<String>? buttonColor;
  String? textRightButtonColor;
  String? linkUrl;

  DialogThemeModel({
    this.titleTextColor,
    this.subTitleTextColor,
    this.descriptionColor,
    this.buttonColor,
    this.textRightButtonColor,
    this.linkUrl,
  });

  static DialogThemeModel fromMap(Map<String, dynamic> json) {
    List<String> buttonColor = (json['buttonColor'] as List<dynamic>).map((e) => e as String).toList();

    // Linear gradient must have at least 2 colors
    // If not, add white color to the gradient
    if (buttonColor.length < 2) {
      buttonColor.addAll(List.generate((2 - buttonColor.length).toInt(), (i) => '#FFFFFF'));
    }

    return DialogThemeModel(
      buttonColor:
          json['buttonColor'] != null ? (json['buttonColor'] as List<dynamic>).map((e) => e as String).toList() : null,
      titleTextColor: json['titleTextColor'],
      subTitleTextColor: json['subTitleTextColor'],
      descriptionColor: json['descriptionColor'],
      textRightButtonColor: json['textRightButtonColor'],
      linkUrl: json['linkUrl'],
    );
  }

  @override
  String toString() =>
      'DialogThemeModel(titleTextColor: $titleTextColor, buttonColor: $buttonColor, subTitleTextColor: $subTitleTextColor, descriptionColor: $descriptionColor, textRightButtonColor: $textRightButtonColor, linkUrl: $linkUrl )';
}
