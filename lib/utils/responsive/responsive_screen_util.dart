import 'dart:io';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UChatScreenUtil {
  static final UChatScreenUtil instance = UChatScreenUtil._internal();

  factory UChatScreenUtil() => instance;

  UChatScreenUtil._internal();

  bool get isMobile => ResponsiveBreakpoints.of(Get.context!).isMobile;
  bool isMobileWithContext(context) => ResponsiveBreakpoints.of(context).isMobile;

  bool get isDesktop => ResponsiveBreakpoints.of(Get.context!).isDesktop;
  bool isDesktopWithContext(context) => ResponsiveBreakpoints.of(context).isDesktop;

  bool get isTablet => ResponsiveBreakpoints.of(Get.context!).isTablet;
  bool isTabletWithContext(context) => ResponsiveBreakpoints.of(context).isTablet;

  bool get isDesktopPlatform => Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  bool get isMobilePlatform => Platform.isAndroid || Platform.isIOS;
}
