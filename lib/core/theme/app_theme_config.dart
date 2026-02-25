import 'package:uchat/core/theme/app_theme.dart';
import 'package:uchat/core/theme/app_text_theme.dart';

class AppThemeConfig {
  // Singleton pattern
  static final AppThemeConfig instance = AppThemeConfig._internal();

  factory AppThemeConfig() => instance;

  AppThemeConfig._internal() {
    loadThemeConfig();
  }

  AppTheme? currentTheme;

  void loadThemeConfig() {
    AppTextTheme currentTextTheme = AppTextTheme.sfPro();
    currentTheme = AppTheme.light(text: currentTextTheme);
  }
}
