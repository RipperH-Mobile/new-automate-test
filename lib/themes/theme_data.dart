import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uchat/themes/text_theme.dart';

import 'color_scheme.dart';

abstract class UChatThemeData {
  UChatColorScheme getLightColorScheme();

  UChatColorScheme getDarkColorScheme();

  UChatTextTheme getTextTheme();

  ThemeData getLightThemeData();
  CupertinoThemeData getCupertinoLightThemeData();

  ThemeData getDarkThemeData();
  CupertinoThemeData getCupertinoDarkThemeData();

  final String defaultBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
  final String? fontFamily = null;
}
