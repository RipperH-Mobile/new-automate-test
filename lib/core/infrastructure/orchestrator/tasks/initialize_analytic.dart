import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_perf_monitor/flutter_perf_monitor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/core/infrastructure/analytics/examples/firebase_performance_setup.dart';
import 'package:uchat/utils/app_env.dart';

import '../../../di/analytic_injection.dart';
import '../common/task_result.dart';

///
/// Please run this first for logging.
///

Future<TaskResult> registerAnalytic() async {
  // Configure all firebase app from firebase_options.dart in lib/firebase
  // This is separated by env.
  await Firebase.initializeApp();

  if (AppEnv.isSentryDebug) {
    FlutterPerfMonitor.initialize();
  }
  
  await registerAnalyticSingletonDependencies();
  return TaskResult.next;
}

Future<TaskResult> initializeAnalytic() async {
  // Configure all firebase app from firebase_options.dart in lib/firebase
  // This is separated by env.

  if (!Platform.isIOS) {
    await initializeAnalyticSingletonDependencies();
    await FirebasePerformanceSetup.initialize();
    return TaskResult.next;
  }

  final isPermanentlyDenied = await Permission.appTrackingTransparency.isPermanentlyDenied;
  if (isPermanentlyDenied) {
    // If permission is permanently denied, we cannot request it again.
    // So, we just return.
    return TaskResult.next;
  }
  final status = await Permission.appTrackingTransparency.request();
  if (status.isGranted) {
    // Initialize Firebase only if permission is granted
    await initializeAnalyticSingletonDependencies();
  }

  return TaskResult.next;
}
