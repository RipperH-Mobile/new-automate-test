import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:system_date_time_format/system_date_time_format.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uchat/features/call/presentation/call_presentation.dart';
import 'package:uchat/lang/lang.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/routes/chat_room_navigator_observer.dart';
import 'package:uchat/routes/navigator_observer.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/dimensions.dart';

import '../../presentation/widgets/privacy_protection_overlay.dart';
import '../../theme/app_theme.dart';
import '../analytics/logger_service.dart';

class App {
  static late final Locale? deviceLocale;
  static late final Locale? savedLocale;
  static late final Locale? initLocale;

  static Future<void> initialize() async {
    deviceLocale = Get.deviceLocale;
    savedLocale = await getLocaleSetting();
    initLocale = savedLocale ?? deviceLocale;
  }

  static Future<void> run() async {
    if (AppEnv.isSentryDebug) {
      await SentryFlutter.init(
        (options) {
          options.dsn = AppEnv.sentryDsn;
          options.tracesSampleRate = 1.0;
          options.profilesSampleRate = 1.0;
        },
        appRunner: () => runApp(
          App.buildApp(),
        ),
      );
    } else {
      runApp(
        App.buildApp(),
      );
    }
  }

  static Widget appBuilder(BuildContext context, Widget? child) {
    // _log.d('App Builder... ${MediaQuery.of(context).size}');
    const breakPoints = <Breakpoint>[Breakpoint(start: 0, end: double.infinity, name: MOBILE)];

    return ResponsiveBreakpoints.builder(
      breakpoints: breakPoints,
      child: ScreenUtilInitWidget(
        child: FlutterEasyLoading(
          child: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              const FloatingCallScreen(),
              const PrivacyProtectionOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildApp() {
    return SDTFScope(
      child: GetMaterialApp(
        navigatorObservers: [
          DismissKeyboardNavigationObserver(),
          TalkerRouteObserver(talker),
          ChatRoomNavigatorObserver(),
        ],
        debugShowCheckedModeBanner: !AppEnv.isProd,
        color: UTheme.color.scaffoldBackground,
        title: 'UChat Messenger'.tr,
        locale: App.initLocale,
        fallbackLocale: enUsLocale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportLocales,
        translations: Lang(),
        initialRoute: Routes.home,
        getPages: AppPages.getRoutes(),
        builder: App.appBuilder,
        theme: AppTheme.light().themeData,
        darkTheme: AppTheme.dark().themeData,
        themeMode: ThemeMode.light,
        onReady: App.onReady,
        onInit: App.onInit,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  static void onReady() {
    useLogger().d('App On Ready.......');
  }

  static void onInit() async {
    useLogger().d('App On Init.......');
  }
}
