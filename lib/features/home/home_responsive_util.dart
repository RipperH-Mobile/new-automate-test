import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtil {
  static double widthScaleFactor(BuildContext context) {
    double baseWidth = 430;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / baseWidth;
  }

  static double heightScaleFactor(BuildContext context) {
    double baseHeight = 932;
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight / baseHeight;
  }

  static double textScaleFactor(BuildContext context) {
    // Alternatively, use MediaQuery.of(context).textScaleFactor for default scaling
    double baseFontSize = 11;
    double standardScreenFontSize = 16;
    return baseFontSize / standardScreenFontSize;
  }

  static double scaledIconSize(BuildContext context) {
    double baseIconSize = 24;
    return baseIconSize.spMin;
  }

  static double scaledBarSize(BuildContext context) {
    double baseBarSize = 60;
    return baseBarSize.spMin;
  }

  static double scaledFontSize(BuildContext context, double baseFontSize) {
    return baseFontSize.spMin;
  }

  static double scaledPadding(BuildContext context, double referencePadding) {
    return referencePadding.spMin;
  }
}
