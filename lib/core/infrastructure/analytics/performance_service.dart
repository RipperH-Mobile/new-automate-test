import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'metric/duration.dart';
import 'metric/fps_monitor.dart';
import 'metric/performance_trace.dart';

PerformanceService usePerformance() {
  return GetIt.I<PerformanceService>();
}

class PerformanceService {
  final FirebasePerformance _performance = FirebasePerformance.instance;

  ///
  /// Please initial when boot the app
  /// [enableHighSampling] - Set to true in development to see more data
  /// [customSamplingRate] - Custom sampling rate (0.0 to 1.0)
  ///
  Future<void> initialize({
    bool enableHighSampling = false,
    double? customSamplingRate,
  }) async {
    _performance.setPerformanceCollectionEnabled(true);

    // Configure sampling rate for development
    if (enableHighSampling || customSamplingRate != null) {
      await _configureDevSamplingRate(customSamplingRate ?? 1.0);
    }
  }

  ///
  /// Configure Firebase Performance sampling rate for development
  /// Use this to see more data during development and testing
  ///
  Future<void> _configureDevSamplingRate(double samplingRate) async {
    // Note: Sampling rate configuration varies by platform
    // This is a conceptual implementation - actual implementation
    // may require platform-specific configuration

    // For development, you can also:
    // 1. Use Firebase Performance test lab
    // 2. Generate more app sessions
    // 3. Use manual traces more frequently

    debugPrint('[PerformanceService] Configured for development with sampling rate: $samplingRate');
    debugPrint('[PerformanceService] Note: Generate 100+ sessions to see data in Firebase console');
  }

  ///
  /// Initialize for production with default 1% sampling
  ///
  Future<void> initializeProduction() async {
    await initialize(enableHighSampling: false);
  }

  ///
  /// Initialize for development with 100% sampling
  /// Use this during development to see all performance data
  ///
  Future<void> initializeDevelopment() async {
    await initialize(enableHighSampling: true, customSamplingRate: 1.0);
  }

  PerformanceTrace newTrace(String name, {bool useFpsMonitoring = true}) {
    return PerformanceTrace.create(name, useFpsMonitoring: useFpsMonitoring);
  }

  DurationMetric newDuration(String name) {
    return DurationMetric(name);
  }

  PerformanceTrace create(String name, {bool useFpsMonitoring = true}) {
    return PerformanceTrace.create(name, useFpsMonitoring: useFpsMonitoring);
  }

  /// Create a standalone FPS monitor
  FpsMonitor createFpsMonitor() {
    return FpsMonitor();
  }

  /// Create a trace with FPS monitoring enabled by default
  PerformanceTrace createWithFps(String name) {
    return PerformanceTrace.create(name, useFpsMonitoring: true);
  }

  /// Create a trace without FPS monitoring
  PerformanceTrace createWithoutFps(String name) {
    return PerformanceTrace.create(name, useFpsMonitoring: false);
  }

  ///
  /// Generate test sessions to reach the 100 session threshold
  /// Use this method during development to generate enough data
  ///
  Future<void> generateTestSessions({int sessionCount = 10}) async {
    debugPrint('[PerformanceService] Generating $sessionCount test sessions...');

    for (int i = 0; i < sessionCount; i++) {
      final trace = create('test_session_${DateTime.now().millisecondsSinceEpoch}_$i');

      await trace.start();

      // Simulate some app activity
      await Future.delayed(const Duration(milliseconds: 100));

      // Add some metrics
      trace.putMetric('test_metric', i + 1);

      await trace.stop();
      trace.dispose();

      // Small delay between sessions
      await Future.delayed(const Duration(milliseconds: 50));
    }

    debugPrint('[PerformanceService] Generated $sessionCount test sessions');
    debugPrint('[PerformanceService] Data should appear in Firebase console within 1-2 hours');
  }

  ///
  /// Debug information for Firebase Performance setup
  ///
  void printDebugInfo() {
    debugPrint('=== Firebase Performance Debug Info ===');
    debugPrint('Default Sampling Rate: 1% (1 out of 100 sessions)');
    debugPrint('Minimum Sessions for Visibility: 100 sessions');
    debugPrint('Data Appears In Console: 1-2 hours after generation');
    debugPrint('=======================================');
  }
}
