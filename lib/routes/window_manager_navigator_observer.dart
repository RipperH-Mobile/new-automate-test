import 'package:flutter/material.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:window_manager/window_manager.dart';

class WindowManagerNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (UChatScreenUtil.instance.isDesktopPlatform && previousRoute != null) {
      if (previousRoute.settings.name == Routes.loginWelcome) {
        windowManager.setResizable(true);
      }
    }

    super.didPush(route, previousRoute);
  }
}
