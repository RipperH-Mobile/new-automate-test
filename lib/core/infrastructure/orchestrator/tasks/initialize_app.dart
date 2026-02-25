import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/screen_protector_helper.dart';

import '../../../domain/services/implementation/meta_service_impl.dart';
import '../../../domain/services/meta_service.dart';
import '../../analytics/logger_service.dart';
import '../common/task_result.dart';

///
/// Initialize app
/// Is run before [runApp()] in main.dart
///
Future<TaskResult> initializeAppBegin() async {
  // First, load the environment variables from .env file
  // Don't move this line, If you move this line, please check and test.
  debugPrint('DotENV initiating...');
  await dotenv.load(fileName: '.env');

  // Load device meta data.
  GetIt.I.registerSingleton<MetaService>(MetaServiceImpl());
  GetIt.I<MetaService>().initialize();

  return TaskResult.next;
}

Future<TaskResult> initializeAppCore() async {
  // Configure screen protector helper
  // Default is turned off.
  if (Platform.isAndroid || Platform.isIOS) {
    await ScreenProtectorHelper.turnOff();
  }

  // Open general db instance for general purpose in app.
  await DbManager().openGeneralInstance();

  // Place after load device meta data and open general db instance
  // because it will be used in the logic.
  await AppEnv.loadConfig();

  // Set startup enable default for DEV, SIT and UAT.
  // After user login, the setting will be updated from user setting.
  // Cannot use [ConfigDb().authenticated] here because maybe not initialized.
  final generalConfigDb = ConfigDb().general;
  talker.settings.enabled = await generalConfigDb.getBoolWithDefault(
    key: ConfigDb.getEnableLogToTalkerKey(),
    defaultValue: AppEnv.isDev || AppEnv.isSit || AppEnv.isUat,
  );
  debugPrint('Talker enabled: ${talker.settings.enabled}');

  // Initialize event bus with tracking disabled by default
  // Tracking can be enabled later from troubleshoot settings
  initializeEventBus(enableTracking: false);

  // Configure notification by using OneSignal
  // Main notification handling function.
  // await configureOneSignal();

  // Configure easy loading
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.foldingCube
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withValues(alpha: 0.8)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..boxShadow = []
    ..dismissOnTap = false;

  // https://github.com/Baseflow/flutter_cached_network_image/issues/325#issuecomment-869041042
  // This increases the max size to be cached.
  // Fix image UChat network (image cache network) blinking
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 20;

  return TaskResult.next;
}
