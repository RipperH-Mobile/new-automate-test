import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/routes/app_pages.dart';

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.pageViewed,
        eventProperties: EventProperty.pageViewed(route: previousRoute),
        sendImmediately: true,
      );
    }

    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name == Routes.home) {
      eventBus.fire(CloseToastForceDeleteEvent());
    }
    SystemChannels.textInput.invokeMethod('TextInput.hide'); //Dismiss keyboard.
    eventBus.fire(CloseSlidablePanelEvent());

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.pageViewed,
      eventProperties: EventProperty.pageViewed(route: route),
      sendImmediately: true,
    );
    super.didStartUserGesture(route, previousRoute);
  }
}
