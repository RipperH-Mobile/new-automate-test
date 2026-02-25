import 'dart:ui';

import 'package:get/get.dart';
import 'package:uchat/entities/services.dart';

part 'en_us.g.dart';
part 'ja_jp.g.dart';
part 'lo_la.g.dart';
part 'th_th.g.dart';
part 'zh_cn.g.dart';
part 'zh_tw.g.dart';

const enUsLocale = Locale('en', 'US');
const thLocale = Locale('th', 'TH');
const zhTwLocale = Locale('zh', 'TW');
const zhCnLocale = Locale('zh', 'CN');
const jaJpLocale = Locale('ja', 'JP');
const loLaLocale = Locale('lo', 'LA');

const fallbackLocale = enUsLocale;

const appLocaleCountryCodeKey = 'APP_LOCALE_COUNTRY_CODE';
const appLocaleLanguageCodeKey = 'APP_LOCALE_LANGUAGE_CODE';

final List<Locale> supportLocales = [
  enUsLocale,
  thLocale,
  zhTwLocale,
  zhCnLocale,
  jaJpLocale,
  loLaLocale,
];

saveLocaleSetting(Locale locale) async {
  final config = ConfigDb().general;

  await config.saveConfig(
    key: appLocaleCountryCodeKey,
    value: locale.countryCode,
  );
  await config.saveConfig(
    key: appLocaleLanguageCodeKey,
    value: locale.languageCode,
  );
}

Future<Locale?> getLocaleSetting() async {
  final config = ConfigDb().general;

  final countryCode = await config.getString(key: appLocaleCountryCodeKey);
  final languageCode = await config.getString(key: appLocaleLanguageCodeKey);

  if (countryCode != null && languageCode != null) {
    return Locale(languageCode, countryCode);
  }
  return null;
}

class Lang extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'th_TH': thTh,
        'en_US': enUs,
        'zh_TW': zhTw,
        'zh_CN': zhCn,
        'ja_JP': jaJp,
        'lo_LA': loLa,
      };
}

String getTitle(Locale locale) {
  switch (locale.toLanguageTag()) {
    case 'th-TH':
      return 'ไทย';
    case 'zh-TW':
      return '中文（繁體）';
    case 'zh-CN':
      return '中文（簡體）';
    case 'ja-JP':
      return '日本語';
    case 'lo-LA':
      return 'ລາວ';
    default:
      return 'English';
  }
}

String getEnglishTitle(Locale locale) {
  switch (locale.toLanguageTag()) {
    case 'th-TH':
      return 'Thai';
    case 'zh-TW':
      return 'Chinese (Traditional)';
    case 'zh-CN':
      return 'Chinese (Simplified)';
    case 'ja-JP':
      return 'Japanese';
    case 'lo-LA':
      return 'Lao';
    default:
      return 'English';
  }
}

String getOneSignalLangCode(Locale locale) {
  switch (locale.toLanguageTag()) {
    case 'th-TH':
      return 'th';
    case 'zh-TW':
      return 'zh-Hant';
    case 'zh-CN':
      return 'zh-Hans';
    case 'ja-JP':
      return 'ja';
    default:
      return 'en';
  }
}
