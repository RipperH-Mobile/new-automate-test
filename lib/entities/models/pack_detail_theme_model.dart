import 'package:isar_community/isar.dart';

part 'pack_detail_theme_model.g.dart';

@embedded
class PackDetailThemeModel {
  List<String>? bgColor;
  List<String>? bgHeaderColor;
  String? bgWhatIsInclude;
  String? bgWhatIsIncludeItem;
  String? bgSubscribeBtn;
  String? shadowSubscribeBtn;
  String? subscribeDescriptionTextColor;
  List<String>? bgRectMonthly;
  String? shadowRectMonthly;
  String? decorationItemColorMonthly;
  List<String>? bgRectYearly;
  String? decorationItemColorYearly;

  PackDetailThemeModel({
    this.bgColor,
    this.bgHeaderColor,
    this.bgWhatIsInclude,
    this.bgWhatIsIncludeItem,
    this.bgSubscribeBtn,
    this.shadowSubscribeBtn,
    this.subscribeDescriptionTextColor,
    this.bgRectMonthly,
    this.shadowRectMonthly,
    this.decorationItemColorMonthly,
    this.bgRectYearly,
    this.decorationItemColorYearly,
  });

  static List<String> defaultGradient = ['#000000', '#FFFFFF'];

  static PackDetailThemeModel fromMap(Map<String, dynamic> json) {
    final tempNgColor = json['bgColor']?.map<String>((e) => e.toString()).toList() ?? defaultGradient;
    final tempBgHeader = json['bgHeaderColor']?.map<String>((e) => e.toString()).toList() ?? defaultGradient;
    final tempBgRectMonthly = json['bgRectMonthly']?.map<String>((e) => e.toString()).toList() ?? defaultGradient;
    final tempBgRectYearly = json['bgRectYearly']?.map<String>((e) => e.toString()).toList() ?? defaultGradient;

    // Linear gradient must have at least 2 colors
    // If not, add white color to the gradient
    if (tempNgColor.length < 2) {
      tempNgColor.addAll(List.generate((2 - tempNgColor.length).toInt(), (i) => '#FFFFFF'));
    }
    if (tempBgHeader.length < 2) {
      tempBgHeader.addAll(List.generate((2 - tempBgHeader.length).toInt(), (i) => '#FFFFFF'));
    }
    if (tempBgRectMonthly.length < 2) {
      tempBgRectMonthly.addAll(List.generate((2 - tempBgRectMonthly.length).toInt(), (i) => '#FFFFFF'));
    }
    if (tempBgRectYearly.length < 2) {
      tempBgRectYearly.addAll(List.generate((2 - tempBgRectYearly.length).toInt(), (i) => '#FFFFFF'));
    }

    return PackDetailThemeModel(
      bgColor: tempNgColor,
      bgHeaderColor: tempBgHeader,
      bgWhatIsInclude: json['bgWhatIsInclude'],
      bgWhatIsIncludeItem: json['bgWhatIsIncludeItem'],
      bgSubscribeBtn: json['bgSubscriptBtn'],
      shadowSubscribeBtn: json['shadowSubscriptBtn'],
      subscribeDescriptionTextColor: json['textColor'],
      bgRectMonthly: tempBgRectMonthly,
      shadowRectMonthly: json['shadowRectMonthly'],
      decorationItemColorMonthly: json['decorationItemColorMonthly'],
      bgRectYearly: tempBgRectYearly,
      decorationItemColorYearly: json['decorationItemColorYearly'],
    );
  }

  @override
  String toString() =>
      'FeatureContentModel(bgColor: $bgColor, bgHeaderColor: $bgHeaderColor, bgWhatIsInclude: $bgWhatIsInclude  , bgWhatIsIncludeItem: $bgWhatIsIncludeItem, bgSubscripeBtn: $bgSubscribeBtn, shadowSubscripeBtn: $shadowSubscribeBtn, subscripeDescriptionTextColor: $subscribeDescriptionTextColor, bgRectMonthly: $bgRectMonthly, shadowRectMonthly: $shadowRectMonthly, decorationItemColorMonthly: $decorationItemColorMonthly, bgRectYearly: $bgRectYearly, decorationItemColorYearly: $decorationItemColorYearly)';
}
