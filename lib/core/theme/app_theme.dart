import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_text_theme.dart';

class AppTheme {
  factory AppTheme.light({AppTextTheme? text}) {
    return AppTheme._internal(
      colors: AppColorsTheme.light(),
      text: text ?? AppTextTheme.sfPro(),
      brightness: Brightness.light,
      gradientColors: AppGradientTheme.light(),
    );
  }

  factory AppTheme.dark({AppTextTheme? text}) {
    return AppTheme._internal(
      colors: AppColorsTheme.dark(),
      text: text ?? AppTextTheme.sfPro(),
      brightness: Brightness.dark,
      gradientColors: AppGradientTheme.dark(),
    );
  }

  factory AppTheme.blue({AppTextTheme? text}) {
    return AppTheme._internal(
      colors: AppColorsTheme.blue(),
      text: text ?? AppTextTheme.sfPro(),
      brightness: Brightness.dark,
      gradientColors: AppGradientTheme.light(),
    );
  }

  const AppTheme._internal({
    required this.colors,
    required this.text,
    required this.brightness,
    required this.gradientColors,
  });

  final AppColorsTheme colors;
  final AppGradientTheme gradientColors;
  final AppTextTheme text;
  final Brightness brightness;

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: false,
      fontFamily: text.fontFamily,
      primaryColor: colors.backgroundPrimary,
      highlightColor: const Color(0xFFF2F6FA),
      // TODO: MOCK
      splashColor: const Color(0xFFF2F6FA),
      // TODO: MOCK
      scaffoldBackgroundColor: colors.surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
        ),
        iconTheme: IconThemeData(
          color: colors.iconPrimary,
          size: AppSize.size6,
        ),
        actionsIconTheme: IconThemeData(
          color: colors.iconPrimary,
        ),
        centerTitle: true,
        titleTextStyle: text.title1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: const Color(0xFF9BA5BF), // TODO: MOCK
          fontFamily: text.fontFamily,
        ),
      ),
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ).apply(fontFamily: text.fontFamily),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ).apply(fontFamily: text.fontFamily),
      tabBarTheme: TabBarThemeData(
        labelStyle: TextStyle(
          fontFamily: text.fontFamily,
          fontWeight: FontWeight.normal,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) {
            return TextStyle(
              fontFamily: text.fontFamily,
              fontWeight: FontWeight.normal,
            );
          },
        ),
      ),
      cupertinoOverrideTheme: const CupertinoThemeData().copyWith(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: text.fontFamily,
          ),
          tabLabelTextStyle: TextStyle(
            fontFamily: text.fontFamily,
            fontSize: 10,
          ),
          navTitleTextStyle: TextStyle(
            fontFamily: text.fontFamily,
          ),
          navActionTextStyle: TextStyle(
            fontFamily: text.fontFamily,
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
        surface: Colors.white, //TODO: MOCK
      ),
      extensions: [
        colors,
        text,
        gradientColors,
      ],
    );
  }
}
