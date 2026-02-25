import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IGetXWrapper {
  Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  });

  Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  });

  Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  });

  void until(RoutePredicate predicate, {int? id});

  Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id});

  Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  });

  Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  });

  void removeRoute(Route<dynamic> route, {int? id});

  Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  });

  bool get isOverlaysOpen;

  bool get isOverlaysClosed;

  void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  });

  void close(int times, [int? id]);

  Future<T?>? off<T>(
    dynamic page, {
    bool opaque = false,
    Transition? transition,
    Curve? curve,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  });

  Future<T?>? offAll<T>(
    dynamic page, {
    RoutePredicate? predicate,
    bool opaque = false,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  });

  void config(
      {bool? enableLog,
      LogWriterCallback? logWriterCallback,
      bool? defaultPopGesture,
      bool? defaultOpaqueRoute,
      Duration? defaultDurationTransition,
      bool? defaultGlobalState,
      Transition? defaultTransition});

  Future<void> updateLocale(Locale l);

  Future<void> forceAppUpdate();

  void appUpdate();

  void changeTheme(ThemeData theme);

  void changeThemeMode(ThemeMode themeMode);

  GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey);

  GlobalKey<NavigatorState>? nestedKey(dynamic key);

  GlobalKey<NavigatorState> global(int? k);

  dynamic get arguments;

  String get currentRoute;

  String get previousRoute;

  bool get isSnackbarOpen;

  void closeAllSnackbars();

  Future<void> closeCurrentSnackbar();

  bool? get isDialogOpen;

  bool? get isBottomSheetOpen;

  Route<dynamic>? get rawRoute;

  bool get isPopGestureEnable;

  bool get isOpaqueRouteDefault;

  BuildContext? get context;

  BuildContext? get overlayContext;

  ThemeData get theme;

  WidgetsBinding get engine;

  FlutterView get window;

  Locale? get deviceLocale;

  double get pixelRatio;

  Size get size;

  double get width;

  double get height;

  double get statusBarHeight;

  double get bottomBarHeight;

  double get textScaleFactor;

  TextTheme get textTheme;

  MediaQueryData get mediaQuery;

  bool get isDarkMode;

  bool get isPlatformDarkMode;

  Color? get iconColor;

  FocusNode? get focusScope;

  GlobalKey<NavigatorState> get key;

  Map<dynamic, GlobalKey<NavigatorState>> get keys;

  GetMaterialController get rootController;

  bool get defaultPopGesture;

  bool get defaultOpaqueRoute;

  Transition? get defaultTransition;

  Duration get defaultTransitionDuration;

  Curve get defaultTransitionCurve;

  Curve get defaultDialogTransitionCurve;

  Duration get defaultDialogTransitionDuration;

  Routing get routing;

  Map<String, String?> get parameters;
  set parameters(Map<String, String?> newParameters);

  CustomTransition? get customTransition;
  set customTransition(CustomTransition? newTransition);

  void resetRootNavigator();
}

class GetXWrapper {
  @visibleForTesting
  static IGetXWrapper? testMode;

  static Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) {
    if (testMode != null) {
      return testMode?.to<T>(
        page,
        opaque: opaque,
        transition: transition,
        curve: curve,
        duration: duration,
        id: id,
        routeName: routeName,
        fullscreenDialog: fullscreenDialog,
        arguments: arguments,
        binding: binding,
        preventDuplicates: preventDuplicates,
        popGesture: popGesture,
        gestureWidth: gestureWidth,
      );
    }
    return Get.to<T>(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      duration: duration,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      arguments: arguments,
      binding: binding,
      preventDuplicates: preventDuplicates,
      popGesture: popGesture,
      gestureWidth: gestureWidth,
    );
  }

  static Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (testMode != null) {
      return testMode?.toNamed<T>(
        page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );
    }
    return Get.toNamed<T>(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  static Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (testMode != null) {
      return testMode?.offNamed<T>(
        page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
      );
    }
    return Get.offNamed<T>(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  static void until(RoutePredicate predicate, {int? id}) {
    if (testMode != null) {
      return testMode?.until(predicate, id: id);
    }
    Get.until(predicate, id: id);
  }

  static Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id}) {
    if (testMode != null) {
      return testMode?.offUntil<T>(page, predicate, id: id);
    }
    return Get.offUntil<T>(page, predicate, id: id);
  }

  static Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (testMode != null) {
      return testMode?.offNamedUntil<T>(
        page,
        predicate,
        id: id,
        arguments: arguments,
        parameters: parameters,
      );
    }
    return Get.offNamedUntil<T>(
      page,
      predicate,
      id: id,
      arguments: arguments,
      parameters: parameters,
    );
  }

  static Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) {
    if (testMode != null) {
      return testMode?.offAndToNamed<T>(
        page,
        arguments: arguments,
        id: id,
        result: result,
        parameters: parameters,
      );
    }
    return Get.offAndToNamed<T>(
      page,
      arguments: arguments,
      id: id,
      result: result,
      parameters: parameters,
    );
  }

  static void removeRoute(Route<dynamic> route, {int? id}) {
    if (testMode != null) {
      return testMode?.removeRoute(route, id: id);
    }
    Get.removeRoute(route, id: id);
  }

  static Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    if (testMode != null) {
      return testMode?.offAllNamed<T>(
        newRouteName,
        predicate: predicate,
        arguments: arguments,
        id: id,
        parameters: parameters,
      );
    }
    return Get.offAllNamed<T>(
      newRouteName,
      predicate: predicate,
      arguments: arguments,
      id: id,
      parameters: parameters,
    );
  }

  static bool get isOverlaysOpen {
    if (testMode != null) {
      return testMode!.isOverlaysOpen;
    }
    return Get.isOverlaysOpen;
  }

  static bool get isOverlaysClosed {
    if (testMode != null) {
      return testMode!.isOverlaysClosed;
    }
    return Get.isOverlaysClosed;
  }

  static void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    if (testMode != null) {
      return testMode?.back(
        result: result,
        closeOverlays: closeOverlays,
        canPop: canPop,
        id: id,
      );
    }

    Get.back<T>(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id,
    );
  }

  static void close(int times, [int? id]) {
    if (testMode != null) {
      return testMode?.close(times, id);
    }
    Get.close(times, id);
  }

  static Future<T?>? off<T>(
    dynamic page, {
    bool opaque = false,
    Transition? transition,
    Curve? curve,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  }) {
    if (testMode != null) {
      return testMode?.off<T>(
        page,
        opaque: opaque,
        transition: transition,
        curve: curve,
        popGesture: popGesture,
        id: id,
        routeName: routeName,
        arguments: arguments,
        binding: binding,
        fullscreenDialog: fullscreenDialog,
        preventDuplicates: preventDuplicates,
        duration: duration,
        gestureWidth: gestureWidth,
      );
    }
    return Get.off<T>(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      preventDuplicates: preventDuplicates,
      duration: duration,
      gestureWidth: gestureWidth,
    );
  }

  static Future<T?>? offAll<T>(
    dynamic page, {
    RoutePredicate? predicate,
    bool opaque = false,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  }) {
    if (testMode != null) {
      return testMode?.offAll<T>(
        page,
        predicate: predicate,
        opaque: opaque,
        popGesture: popGesture,
        id: id,
        routeName: routeName,
        arguments: arguments,
        binding: binding,
        fullscreenDialog: fullscreenDialog,
        transition: transition,
        curve: curve,
        duration: duration,
        gestureWidth: gestureWidth,
      );
    }
    return Get.offAll<T>(
      page,
      predicate: predicate,
      opaque: opaque,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      curve: curve,
      duration: duration,
      gestureWidth: gestureWidth,
    );
  }

  static void config(
      {bool? enableLog,
      LogWriterCallback? logWriterCallback,
      bool? defaultPopGesture,
      bool? defaultOpaqueRoute,
      Duration? defaultDurationTransition,
      bool? defaultGlobalState,
      Transition? defaultTransition}) {
    if (testMode != null) {
      return testMode?.config(
        enableLog: enableLog,
        logWriterCallback: logWriterCallback,
        defaultPopGesture: defaultPopGesture,
        defaultOpaqueRoute: defaultOpaqueRoute,
        defaultDurationTransition: defaultDurationTransition,
        defaultGlobalState: defaultGlobalState,
        defaultTransition: defaultTransition,
      );
    }
    Get.config(
      enableLog: enableLog,
      logWriterCallback: logWriterCallback,
      defaultPopGesture: defaultPopGesture,
      defaultOpaqueRoute: defaultOpaqueRoute,
      defaultDurationTransition: defaultDurationTransition,
      defaultGlobalState: defaultGlobalState,
      defaultTransition: defaultTransition,
    );
  }

  static Future<void> updateLocale(Locale l) async {
    if (testMode != null) {
      return testMode?.updateLocale(l);
    }
    await Get.updateLocale(l);
  }

  static Future<void> forceAppUpdate() async {
    if (testMode != null) {
      return testMode?.forceAppUpdate();
    }
    await Get.forceAppUpdate();
  }

  static void appUpdate() {
    if (testMode != null) {
      return testMode?.appUpdate();
    }
    Get.appUpdate();
  }

  static void changeTheme(ThemeData theme) {
    if (testMode != null) {
      return testMode?.changeTheme(theme);
    }
    Get.changeTheme(theme);
  }

  static void changeThemeMode(ThemeMode themeMode) {
    if (testMode != null) {
      return testMode?.changeThemeMode(themeMode);
    }
    Get.changeThemeMode(themeMode);
  }

  static GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    if (testMode != null) {
      return testMode?.addKey(newKey);
    }
    return Get.addKey(newKey);
  }

  static GlobalKey<NavigatorState>? nestedKey(dynamic key) {
    if (testMode != null) {
      return testMode?.nestedKey(key);
    }
    return Get.nestedKey(key);
  }

  static GlobalKey<NavigatorState> global(int? k) {
    if (testMode != null) {
      return testMode!.global(k);
    }
    return Get.global(k);
  }

  static dynamic get arguments {
    if (testMode != null) {
      return testMode!.arguments;
    }
    return Get.arguments;
  }

  static String get currentRoute {
    if (testMode != null) {
      return testMode!.currentRoute;
    }
    return Get.currentRoute;
  }

  static String get previousRoute {
    if (testMode != null) {
      return testMode!.previousRoute;
    }
    return Get.previousRoute;
  }

  static bool get isSnackbarOpen {
    if (testMode != null) {
      return testMode!.isSnackbarOpen;
    }
    return Get.isSnackbarOpen;
  }

  static void closeAllSnackbars() {
    if (testMode != null) {
      return testMode?.closeAllSnackbars();
    }
    Get.closeAllSnackbars();
  }

  static Future<void> closeCurrentSnackbar() async {
    if (testMode != null) {
      return testMode?.closeCurrentSnackbar();
    }
    await Get.closeCurrentSnackbar();
  }

  static bool? get isDialogOpen {
    if (testMode != null) {
      return testMode?.isDialogOpen;
    }
    return Get.isDialogOpen;
  }

  static bool? get isBottomSheetOpen {
    if (testMode != null) {
      return testMode?.isBottomSheetOpen;
    }
    return Get.isBottomSheetOpen;
  }

  static Route<dynamic>? get rawRoute {
    if (testMode != null) {
      return testMode?.rawRoute;
    }
    return Get.rawRoute;
  }

  static bool get isPopGestureEnable {
    if (testMode != null) {
      return testMode!.isPopGestureEnable;
    }
    return Get.isPopGestureEnable;
  }

  static bool get isOpaqueRouteDefault {
    if (testMode != null) {
      return testMode!.isOpaqueRouteDefault;
    }
    return Get.isOpaqueRouteDefault;
  }

  static BuildContext? get context {
    if (testMode != null) {
      return testMode?.context;
    }
    return Get.context;
  }

  static BuildContext? get overlayContext {
    if (testMode != null) {
      return testMode?.overlayContext;
    }
    return Get.overlayContext;
  }

  static ThemeData get theme {
    if (testMode != null) {
      return testMode!.theme;
    }
    return Get.theme;
  }

  static WidgetsBinding get engine {
    if (testMode != null) {
      return testMode!.engine;
    }
    return Get.engine;
  }

  static FlutterView get window {
    if (testMode != null) {
      return testMode!.window;
    }
    return Get.window;
  }

  static Locale? get deviceLocale {
    if (testMode != null) {
      return testMode?.deviceLocale;
    }
    return Get.deviceLocale;
  }

  static double get pixelRatio {
    if (testMode != null) {
      return testMode!.pixelRatio;
    }
    return Get.pixelRatio;
  }

  static Size get size {
    if (testMode != null) {
      return testMode!.size;
    }
    return Get.size;
  }

  static double get width {
    if (testMode != null) {
      return testMode!.width;
    }
    return Get.width;
  }

  static double get height {
    if (testMode != null) {
      return testMode!.height;
    }
    return Get.height;
  }

  static double get statusBarHeight {
    if (testMode != null) {
      return testMode!.statusBarHeight;
    }
    return Get.statusBarHeight;
  }

  static double get bottomBarHeight {
    if (testMode != null) {
      return testMode!.bottomBarHeight;
    }
    return Get.bottomBarHeight;
  }

  static double get textScaleFactor {
    if (testMode != null) {
      return testMode!.textScaleFactor;
    }
    return Get.textScaleFactor;
  }

  static TextTheme get textTheme {
    if (testMode != null) {
      return testMode!.textTheme;
    }
    return Get.textTheme;
  }

  static MediaQueryData get mediaQuery {
    if (testMode != null) {
      return testMode!.mediaQuery;
    }
    return Get.mediaQuery;
  }

  static bool get isDarkMode {
    if (testMode != null) {
      return testMode!.isDarkMode;
    }
    return Get.isDarkMode;
  }

  static bool get isPlatformDarkMode {
    if (testMode != null) {
      return testMode!.isPlatformDarkMode;
    }
    return Get.isPlatformDarkMode;
  }

  static Color? get iconColor {
    if (testMode != null) {
      return testMode?.iconColor;
    }
    return Get.iconColor;
  }

  static FocusNode? get focusScope {
    if (testMode != null) {
      return testMode?.focusScope;
    }
    return Get.focusScope;
  }

  static GlobalKey<NavigatorState> get key {
    if (testMode != null) {
      return testMode!.key;
    }
    return Get.key;
  }

  static Map<dynamic, GlobalKey<NavigatorState>> get keys {
    if (testMode != null) {
      return testMode!.keys;
    }
    return Get.keys;
  }

  static GetMaterialController get rootController {
    if (testMode != null) {
      return testMode!.rootController;
    }
    return Get.rootController;
  }

  static bool get defaultPopGesture {
    if (testMode != null) {
      return testMode!.defaultPopGesture;
    }
    return Get.defaultPopGesture;
  }

  static bool get defaultOpaqueRoute {
    if (testMode != null) {
      return testMode!.defaultOpaqueRoute;
    }
    return Get.defaultOpaqueRoute;
  }

  static Transition? get defaultTransition {
    if (testMode != null) {
      return testMode?.defaultTransition;
    }
    return Get.defaultTransition;
  }

  static Duration get defaultTransitionDuration {
    if (testMode != null) {
      return testMode!.defaultTransitionDuration;
    }
    return Get.defaultTransitionDuration;
  }

  static Curve get defaultTransitionCurve {
    if (testMode != null) {
      return testMode!.defaultTransitionCurve;
    }
    return Get.defaultTransitionCurve;
  }

  static Curve get defaultDialogTransitionCurve {
    if (testMode != null) {
      return testMode!.defaultDialogTransitionCurve;
    }
    return Get.defaultDialogTransitionCurve;
  }

  static Duration get defaultDialogTransitionDuration {
    if (testMode != null) {
      return testMode!.defaultDialogTransitionDuration;
    }
    return Get.defaultDialogTransitionDuration;
  }

  static Routing get routing {
    if (testMode != null) {
      return testMode!.routing;
    }
    return Get.routing;
  }

  static Map<String, String?> get parameters {
    if (testMode != null) {
      return testMode!.parameters;
    }
    return Get.parameters;
  }

  static set parameters(Map<String, String?> newParameters) {
    if (testMode != null) {
      testMode!.parameters = newParameters;
      return;
    }
    Get.parameters = newParameters;
  }

  static CustomTransition? get customTransition {
    if (testMode != null) {
      return testMode?.customTransition;
    }
    return Get.customTransition;
  }

  static set customTransition(CustomTransition? newTransition) {
    if (testMode != null) {
      testMode?.customTransition = newTransition;
      return;
    }
    Get.customTransition = newTransition;
  }

  static void resetRootNavigator() {
    if (testMode != null) {
      return testMode?.resetRootNavigator();
    }
    Get.resetRootNavigator();
  }
}
