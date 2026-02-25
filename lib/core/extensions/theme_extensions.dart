import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_text_theme.dart';

extension ThemeDataExtended on ThemeData {
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppGradientTheme get appGradientColors => extension<AppGradientTheme>()!;
  AppTextTheme get appTexts => extension<AppTextTheme>()!;
}
