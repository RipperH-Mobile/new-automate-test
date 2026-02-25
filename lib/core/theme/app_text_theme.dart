import 'package:flutter/material.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle heading4;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle subtitle1;
  final TextStyle body1;
  final TextStyle body1Bold;
  final TextStyle body2;
  final TextStyle body2Bold;
  final TextStyle body3;
  final TextStyle body3Bold;
  final TextStyle body4;
  final TextStyle body4Bold;
  final TextStyle caption1;
  final TextStyle caption1Bold;
  final TextStyle caption2;
  final TextStyle caption2Bold;
  final TextStyle button1;
  final TextStyle button1Bold;
  final TextStyle button2;
  final TextStyle button2Bold;
  final String fontFamily;

  const AppTextTheme({
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.heading4,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.subtitle1,
    required this.body1,
    required this.body1Bold,
    required this.body2,
    required this.body2Bold,
    required this.body3,
    required this.body3Bold,
    required this.body4,
    required this.body4Bold,
    required this.caption1,
    required this.caption1Bold,
    required this.caption2,
    required this.caption2Bold,
    required this.button1,
    required this.button1Bold,
    required this.button2,
    required this.button2Bold,
    required this.fontFamily,
  });

  factory AppTextTheme.sfPro() {
    final fontFamily = 'SF Pro';
    return AppTextTheme(
      heading1: TextStyle(
        fontSize: 32,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
      ),
      heading2: TextStyle(
        fontSize: 26,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 26,
      ),
      heading3: TextStyle(
        fontSize: 24,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
      ),
      heading4: TextStyle(
        fontSize: 20,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
      ),
      title1: TextStyle(
        fontSize: 18,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 18,
      ),
      title2: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      title3: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      subtitle1: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 15,
      ),
      body1: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      body1Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      body2: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 15,
      ),
      body2Bold: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 15,
      ),
      body3: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 14,
      ),
      body3Bold: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 14,
      ),
      body4: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 13,
      ),
      body4Bold: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 13,
      ),
      caption1: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
      ),
      caption1Bold: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
      ),
      caption2: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 11,
      ),
      caption2Bold: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 11,
      ),
      button1: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 17,
      ),
      button1Bold: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      button2: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      button2Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      fontFamily: fontFamily,
    );
  }

  factory AppTextTheme.thonburi() {
    const fontFamily = 'Thonburi';
    return const AppTextTheme(
      heading1: TextStyle(
        fontSize: 32,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
      ),
      heading2: TextStyle(
        fontSize: 26,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 26,
      ),
      heading3: TextStyle(
        fontSize: 24,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
      ),
      heading4: TextStyle(
        fontSize: 20,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
      ),
      title1: TextStyle(
        fontSize: 18,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 18,
      ),
      title2: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      title3: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      subtitle1: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 15,
      ),
      body1: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      body1Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      body2: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 15,
      ),
      body2Bold: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 15,
      ),
      body3: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 14,
      ),
      body3Bold: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 14,
      ),
      body4: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 13,
      ),
      body4Bold: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 13,
      ),
      caption1: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
      ),
      caption1Bold: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
      ),
      caption2: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 11,
      ),
      caption2Bold: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 11,
      ),
      button1: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 17,
      ),
      button1Bold: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      button2: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      button2Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      fontFamily: fontFamily,
    );
  }

  factory AppTextTheme.roboto() {
    final fontFamily = 'roboto';
    return AppTextTheme(
      heading1: TextStyle(
        fontSize: 32,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
      ),
      heading2: TextStyle(
        fontSize: 26,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 26,
      ),
      heading3: TextStyle(
        fontSize: 24,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
      ),
      heading4: TextStyle(
        fontSize: 20,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
      ),
      title1: TextStyle(
        fontSize: 18,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 18,
      ),
      title2: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      title3: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      subtitle1: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 15,
      ),
      body1: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      body1Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      body2: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 15,
      ),
      body2Bold: TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 15,
      ),
      body3: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 14,
      ),
      body3Bold: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 14,
      ),
      body4: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 13,
      ),
      body4Bold: TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 13,
      ),
      caption1: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
      ),
      caption1Bold: TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
      ),
      caption2: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 18 / 11,
      ),
      caption2Bold: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 18 / 11,
      ),
      button1: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 17,
      ),
      button1Bold: TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 17,
      ),
      button2: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      button2Bold: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      fontFamily: fontFamily,
    );
  }

  @override
  AppTextTheme copyWith({
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? heading4,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? subtitle1,
    TextStyle? body1,
    TextStyle? body1Bold,
    TextStyle? body2,
    TextStyle? body2Bold,
    TextStyle? body3,
    TextStyle? body3Bold,
    TextStyle? body4,
    TextStyle? body4Bold,
    TextStyle? caption1,
    TextStyle? caption1Bold,
    TextStyle? caption2,
    TextStyle? caption2Bold,
    TextStyle? button1,
    TextStyle? button1Bold,
    TextStyle? button2,
    TextStyle? button2Bold,
    String? fontFamily,
  }) {
    return AppTextTheme(
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      heading3: heading3 ?? this.heading3,
      heading4: heading4 ?? this.heading4,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      subtitle1: subtitle1 ?? this.subtitle1,
      body1: body1 ?? this.body1,
      body1Bold: body1Bold ?? this.body1Bold,
      body2: body2 ?? this.body2,
      body2Bold: body2Bold ?? this.body2Bold,
      body3: body3 ?? this.body3,
      body3Bold: body3Bold ?? this.body3Bold,
      body4: body4 ?? this.body4,
      body4Bold: body4Bold ?? this.body4Bold,
      caption1: caption1 ?? this.caption1,
      caption1Bold: caption1Bold ?? this.caption1Bold,
      caption2: caption2 ?? this.caption2,
      caption2Bold: caption2Bold ?? this.caption2Bold,
      button1: button1 ?? this.button1,
      button1Bold: button1Bold ?? this.button1Bold,
      button2: button2 ?? this.button2,
      button2Bold: button2Bold ?? this.button2Bold,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  AppTextTheme lerp(ThemeExtension<AppTextTheme>? other, double t) {
    return this;
  }
}
