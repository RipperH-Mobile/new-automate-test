import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_scheme.dart';
import '../text_theme.dart';
import '../theme_data.dart';

class OriginsTheme implements UChatThemeData {
  UChatColorScheme uLight = UChatColorScheme();
  UChatColorScheme uDark = UChatColorScheme();

  @override
  String? get fontFamily => null;

  @override
  ThemeData getLightThemeData() {
    final textTheme = getTextTheme();

    return ThemeData(
      useMaterial3: false,
      fontFamily: fontFamily,
      primaryColor: uLight.primary,
      highlightColor: uLight.highlightColor,
      splashColor: uLight.splashColor,
      scaffoldBackgroundColor: uLight.background,
      appBarTheme: AppBarTheme(
        backgroundColor: uLight.appBar,
        iconTheme: IconThemeData(
          color: uLight.onAppBar,
          size: 20.0,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        titleTextStyle: textTheme.appBarTitle.copyWith(
          color: uLight.onAppBar,
          fontFamily: fontFamily,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: uLight.inputHint,
          fontFamily: fontFamily,
        ),
      ),
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ).apply(fontFamily: fontFamily),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ).apply(fontFamily: fontFamily),
      tabBarTheme: TabBarThemeData(
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            return TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.normal,
            );
          },
        ),
      ),
      cupertinoOverrideTheme: const CupertinoThemeData().copyWith(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: fontFamily,
          ),
          tabLabelTextStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 10,
          ),
          navTitleTextStyle: TextStyle(
            fontFamily: fontFamily,
          ),
          navActionTextStyle: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(surface: uLight.background),
    );
  }

  @override
  ThemeData getDarkThemeData() {
    return getLightThemeData();
  }

  @override
  UChatColorScheme getLightColorScheme() {
    return UChatColorScheme();
  }

  @override
  UChatColorScheme getDarkColorScheme() {
    return UChatColorScheme();
  }

  @override
  UChatTextTheme getTextTheme() {
    return UChatTextTheme(
      messageUnreadCount: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
      ),
    );
  }

  @override
  String get defaultBlurHash => 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  @override
  CupertinoThemeData getCupertinoDarkThemeData() {
    return CupertinoThemeData(
      scaffoldBackgroundColor: uLight.background,
      primaryColor: uLight.primary,
      textTheme: CupertinoTextThemeData(
        primaryColor: uLight.onBackground,
        textStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        actionTextStyle: TextStyle(
          color: uLight.onBackground,
          fontWeight: FontWeight.normal,
        ),
        navActionTextStyle: TextStyle(
          color: uLight.onBackground,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  CupertinoThemeData getCupertinoLightThemeData() {
    return getCupertinoDarkThemeData();
  }
}
