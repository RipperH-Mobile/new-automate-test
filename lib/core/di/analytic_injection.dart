import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/amplitude_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/taxonomy_empty_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/screen_lag_contact_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/screen_lag_notification_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/utils/app_env.dart';

import '../infrastructure/analytics/crashlytics_service.dart';
import '../infrastructure/analytics/logger_service.dart';
import '../infrastructure/analytics/performance_service.dart';

///
/// Register singleton dependencies for analytics.
/// This function registers the LoggerService,
/// PerformanceService, and CrashlyticsService as singletons in the GetIt service locator.
///
Future<void> registerAnalyticSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<LoggerService>(LoggerService());
  getIt.registerSingleton<PerformanceService>(PerformanceService());
  getIt.registerSingleton<CrashlyticsService>(CrashlyticsService());
  getIt.registerSingleton<CallPerformanceService>(CallPerformanceService());
  getIt.registerSingleton<ScreenLagNotificationService>(ScreenLagNotificationService());

  registerScreenLagContactPerformanceService();
  registerSendingMsgPerformanceService();

  if (AppEnv.amplitudeApiKey.isNotEmpty) {
    getIt.registerSingleton<TaxonomyService>(
      AmplitudeServiceImpl(
        AppEnv.amplitudeApiKey,
        getIt<LoggerService>(),
      ),
    );
  } else {
    getIt.registerSingleton<TaxonomyService>(
      TaxonomyEmptyServiceImpl(),
    );
  }
}

///
/// Initialize singleton dependencies for analytics.
/// This function initializes the LoggerService,
/// PerformanceService, and CrashlyticsService.
///
Future<void> initializeAnalyticSingletonDependencies() async {
  final getIt = GetIt.instance;

  await getIt<CrashlyticsService>().initialize();
}

Future<void> initializeLoggerSingletonDependencies() async {
  final getIt = GetIt.instance;

  getIt<LoggerService>().initialize();
}
