import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/themes/bai_jamjuree/bai_jamjuree_theme.dart';
import 'package:uchat/themes/color_scheme.dart';
import 'package:uchat/themes/noto/noto_looped_theme.dart';
import 'package:uchat/themes/noto/noto_theme.dart';
import 'package:uchat/themes/text_theme.dart';

import 'origins/origins_theme.dart';
import 'theme_data.dart';

// const boxUsingThemeKey = 'using_theme';
const boxUsingThemeKey = 'THEME_USING';
// const boxThemeModeKey = 'theme_mode';
const boxThemeModeKey = 'THEME_MODE';

const themeModeSystem = 'system';
const themeModeDark = 'dark';
const themeModeLight = 'light';

class UTheme {
  // Singleton pattern
  static final UTheme instance = UTheme._internal();

  factory UTheme() => instance;

  UTheme._internal() {
    loadThemeConfig();
  }

  static UserController get userCtl {
    return Get.find<UserController>();
  }

  // Helper
  static UChatColorScheme get color => UTheme().currentColorScheme!;

  static UChatTextTheme get textTheme => UTheme().currentTextTheme!;

  static ThemeData get themeData => Get.theme;

  static String? get fontFamily {
    if (userCtl.previewFont == true) {
      return UTheme().currentTheme?.fontFamily ?? '';
    }
    return '';
  }

  static String? get messageFontFam {
    if (userCtl.previewFont == true) {
      return UTheme().themeName == 'Origins' ? null : 'notoSansThaiLooped';
    }
    return null;
  }

  final configGeneral = ConfigDb().general;

  // Theme operation

  UChatThemeData? currentTheme;
  UChatColorScheme? currentColorScheme;
  UChatTextTheme? currentTextTheme;
  ThemeData? currentThemeData;
  CupertinoThemeData? currentCupertinoThemeData;

  String? themeMode;
  String? themeName;

  UChatThemeData getTheme() {
    return currentTheme!;
  }

  UChatThemeData get current {
    return currentTheme!;
  }

  void loadThemeConfig() {
    themeName = configGeneral.getStringSync(key: boxUsingThemeKey);
    if (themeName == null) {
      themeName = 'Origins';
      configGeneral.saveConfigSync(key: boxUsingThemeKey, value: themeName);
    }

    themeMode = configGeneral.getStringSync(key: boxThemeModeKey);
    if (themeMode == null) {
      themeMode = themeModeSystem;
      configGeneral.saveConfigSync(key: boxThemeModeKey, value: themeMode);
    }

    if (themeName == 'Origins') {
      currentTheme = OriginsTheme();
    } else if (themeName == 'Noto') {
      // This is temporary
      currentTheme = NotoTheme();
    } else if (themeName == 'NotoLooped') {
      // This is temporary
      currentTheme = NotoLoopedTheme();
    } else if (themeName == 'BaiJamjuree') {
      // This is temporary
      currentTheme = BaiJamjureeTheme();
    }

    loadTheme();
  }

  void loadTheme() {
    currentTextTheme = currentTheme!.getTextTheme();

    if (themeMode == themeModeSystem) {
      if (Get.isPlatformDarkMode) {
        currentColorScheme = currentTheme!.getDarkColorScheme();
        currentThemeData = currentTheme!.getDarkThemeData();
        currentCupertinoThemeData = currentTheme!.getCupertinoDarkThemeData();
      } else {
        currentColorScheme = currentTheme!.getLightColorScheme();
        currentThemeData = currentTheme!.getLightThemeData();
        currentCupertinoThemeData = currentTheme!.getCupertinoLightThemeData();
      }
    } else if (themeMode == themeModeDark) {
      currentColorScheme = currentTheme!.getDarkColorScheme();
      currentThemeData = currentTheme!.getDarkThemeData();
      currentCupertinoThemeData = currentTheme!.getCupertinoDarkThemeData();
    } else {
      currentColorScheme = currentTheme!.getLightColorScheme();
      currentThemeData = currentTheme!.getLightThemeData();
      currentCupertinoThemeData = currentTheme!.getCupertinoLightThemeData();
    }
  }

  // This is temporary
  void changeTheme(String font) async {
    if (font == 'Noto') {
      configGeneral.saveConfigSync(key: boxUsingThemeKey, value: 'Noto');
    } else if (font == 'NotoLooped') {
      configGeneral.saveConfigSync(key: boxUsingThemeKey, value: 'NotoLooped');
    } else if (font == 'BaiJamjuree') {
      configGeneral.saveConfigSync(key: boxUsingThemeKey, value: 'BaiJamjuree');
    } else {
      configGeneral.saveConfigSync(key: boxUsingThemeKey, value: 'Origins');
    }

    loadThemeConfig();
    Get.changeThemeMode(ThemeMode.light);
    Get.changeTheme(currentThemeData!);
    await Get.forceAppUpdate();
  }
}
