/// Firebase Performance Setup Example
///
/// This file shows how to properly initialize Firebase Performance
/// to avoid the "no sessions" issue in development

import 'package:flutter/foundation.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';

class FirebasePerformanceSetup {
  /// Initialize Firebase Performance based on build mode
  static Future<void> initialize() async {
    final performance = usePerformance();

    if (kDebugMode || kProfileMode) {
      // Development Mode: High sampling rate to see data immediately
      await performance.initializeDevelopment();

      // Generate test sessions to reach the 100 session threshold
      // await _generateDevelopmentSessions(performance);
    } else {
      // Production Mode: Default 1% sampling rate
      await performance.initializeProduction();
    }

    // Print debug information
    performance.printDebugInfo();
  }

  /// Generate sessions for development to reach Firebase's threshold
  static Future<void> _generateDevelopmentSessions(PerformanceService performance) async {
    debugPrint('🔥 Generating development sessions for Firebase Performance...');

    try {
      // Generate 150 sessions to ensure we exceed the 100 session minimum
      await performance.generateTestSessions(sessionCount: 150);

      debugPrint('✅ Generated development sessions successfully');
      debugPrint('📊 Data should appear in Firebase Console within 1-2 hours');
    } catch (e) {
      debugPrint('❌ Failed to generate development sessions: $e');
    }
  }

  /// Test Firebase Performance configuration
  static Future<void> runDiagnostics() async {
    final performance = usePerformance();

    debugPrint('\n=== Firebase Performance Diagnostics ===');

    // Test trace creation
    try {
      final testTrace = performance.create('diagnostic_test_trace');
      await testTrace.start();

      // Simulate some work
      await Future.delayed(const Duration(milliseconds: 100));
      testTrace.putMetric('test_metric', 42);

      await testTrace.stop();
      testTrace.dispose();

      debugPrint('✅ Trace creation and execution: SUCCESS');
    } catch (e) {
      debugPrint('❌ Trace creation failed: $e');
    }

    // Test FPS monitoring
    try {
      final fpsTrace = performance.createWithFps('diagnostic_fps_test');
      await fpsTrace.start();

      await Future.delayed(const Duration(milliseconds: 200));

      final fpsMetrics = fpsTrace.getCurrentFpsMetrics();
      if (fpsMetrics != null) {
        debugPrint('✅ FPS monitoring: SUCCESS (${fpsMetrics.averageFps.toStringAsFixed(1)} FPS)');
      } else {
        debugPrint('⚠️  FPS monitoring: No metrics available');
      }

      await fpsTrace.stop();
      fpsTrace.dispose();
    } catch (e) {
      debugPrint('❌ FPS monitoring failed: $e');
    }

    debugPrint('========================================\n');
  }
}

/// Add this to your main.dart file
///
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Initialize Firebase
///   await Firebase.initializeApp();
///
///   // Setup Firebase Performance (fixes "no sessions" issue)
///   await FirebasePerformanceSetup.initialize();
///
///   // Optional: Run diagnostics in debug mode
///   if (kDebugMode) {
///     await FirebasePerformanceSetup.runDiagnostics();
///   }
///
///   runApp(MyApp());
/// }
/// ```
