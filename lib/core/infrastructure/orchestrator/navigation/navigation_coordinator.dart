import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/screen_lag_contact_performance_service_impl.dart';
import 'package:uchat/features/accounts_center/accounts_center_barrel.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/routes/app_pages.dart';

import '../../analytics/logger_service.dart';
import 'deep_link_handler.dart';
import 'share_handler.dart';

final roomCallRegex = RegExp(
  r'^/room/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/call$',
);

class NavigationCoordinator {
  bool _firstRouteToIsCalled = false;

  bool get firstRouteToIsCalled => _firstRouteToIsCalled;

  final _firstRouteToMemoizer = AsyncMemoizer();

  Future<void> initialize() async {}

  Future<void> firstRouteTo() async {
    await _firstRouteToMemoizer.runOnce(() => _firstRouteTo());
  }

  Future<void> _firstRouteTo() async {
    useLogger().d('firstRouteTo call...');
    if (_firstRouteToIsCalled) {
      useLogger().d('firstRouteToIsCalled()==true');
      return;
    }

    if (GetIt.I<AccountsCenterService>().haveAccount && UserController.instance.currentUser() == null) {
      useLogger().d('Going to select account screen');
      await Get.offAllNamed(Routes.selectAccount);
      // After returning from select account, go to home.
      _firstRouteToIsCalled = true;
    } else if (UserController.instance.currentUser() == null) {
      useLogger().d('currentUser() == null');
      unregisterCallingOneSignalUser();
      Get.offAllNamed(Routes.welcome);
      _firstRouteToIsCalled = true;
      return;
    }

    useLogger().d('run firstRouteTo cb');

    await ScreenLagContactPerformanceService.mainTrace.start();
    final userId = UserController.instance.currentUser()?.id ?? 'unknown';
    ScreenLagContactPerformanceService.mainTrace.putMainTraceAttribute(userId: userId, appState: 'close');

    if (Get.currentRoute != Routes.home) {
      useLogger().d('firstRouteTo cb: Check currentRoute != Routes.home');
      Get.offAllNamed(Routes.home);
    }

    useLogger().d('firstRouteTo cb: Event CheckEmailOrPasswordNotSetEvent fire');
    eventBus.fire(CheckEmailOrPasswordNotSetEvent());
    // check if previous route is roomCall, then go to that route
    if (roomCallRegex.hasMatch(Get.previousRoute)) {
      useLogger().d('Check roomCallRegex.hasMatch(Get.previousRoute)');
      Get.toNamed(Get.previousRoute);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      useLogger().d('First route to in addPostFrameCallback');

      // Check deep link
      final deepLinkHandler = GetIt.I<DeepLinkHandler>();
      final deepInitialLink = deepLinkHandler.initialLink;
      if (deepInitialLink != null) {
        useLogger().d('First route to in addPostFrameCallback initialLink() != null, $deepInitialLink');
        deepLinkHandler.processLink(deepInitialLink);
      }

      // Check if there is a share media
      final shareHandler = GetIt.I<ShareHandler>();
      final initialShareMedia = shareHandler.initialShareMedia;

      if (initialShareMedia != null) {
        useLogger().d(
          'First route to in addPostFrameCallback initialShareMedia() != null, $initialShareMedia',
        );
        shareHandler.handleShare(initialShareMedia);
      }
    });
    _firstRouteToIsCalled = true;
  }

  // Try to unregister calling OneSignal when there is no user logged in. This is to avoid leftover OneSignal user.
  // Not sure how this can happen, but just in case to prevent incoming call from showing on login screen.
  void unregisterCallingOneSignalUser() async {
    // Only unregister if there is an access token because if there is no access token, unregistering is not possible.
    if (GetIt.I<HttpCaller>().accessToken == null) return;
    await UChatCallNativeMethodChanel.instance.removeOneSignalUser();
  }
}
