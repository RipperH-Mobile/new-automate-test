/// Example of how to use Firebase Performance with FPS monitoring
///
/// This file demonstrates the implementation of real-time FPS monitoring
/// during Firebase Performance traces as described in the Medium article:
/// https://medium.com/@punithsuppar7795/real-time-flutter-performance-monitoring-memory-fps-firebase-elk-integration-03ea5fa9347e

import 'package:flutter/material.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';

class PerformanceExample {
  /// Example 1: Basic usage with automatic FPS monitoring
  static Future<void> basicUsageWithFps() async {
    final performance = usePerformance();

    // Create trace with FPS monitoring enabled (default)
    final trace = performance.create('user_action_example');

    await trace.start();

    // Your code here - FPS is being monitored automatically
    await Future.delayed(const Duration(seconds: 2));

    // Stop trace - FPS metrics will be automatically added to Firebase
    await trace.stop();

    // Clean up
    trace.dispose();
  }

  /// Example 2: Using trace without FPS monitoring
  static Future<void> basicUsageWithoutFps() async {
    final performance = usePerformance();

    // Create trace without FPS monitoring
    final trace = performance.createWithoutFps('background_task');

    await trace.start();

    // Your code here
    await Future.delayed(const Duration(seconds: 1));

    await trace.stop();
    trace.dispose();
  }

  /// Example 3: Advanced usage with real-time FPS access
  static Future<void> advancedUsageWithRealTimeFps() async {
    final performance = usePerformance();

    // Create trace with FPS monitoring
    final trace = performance.createWithFps('ui_heavy_operation');

    await trace.start();

    // Simulate heavy UI operations
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 500));

      // Get current FPS metrics while trace is running
      final currentMetrics = trace.getCurrentFpsMetrics();
      if (currentMetrics != null) {
        debugPrint('Current Average FPS: ${currentMetrics.averageFps.toStringAsFixed(1)}');
        debugPrint('Frame Count: ${currentMetrics.totalFrames}');
      }
    }

    // Add custom metrics
    trace.putMetric('custom_operations', 5);

    await trace.stop();
    trace.dispose();
  }

  /// Example 4: Standalone FPS monitoring
  static Future<void> standaloneFpsMonitoring() async {
    final performance = usePerformance();

    // Create standalone FPS monitor (without Firebase trace)
    final fpsMonitor = performance.createFpsMonitor();

    fpsMonitor.start();

    // Your code here
    await Future.delayed(const Duration(seconds: 3));

    final metrics = fpsMonitor.stop();

    debugPrint('Final FPS Metrics:');
    debugPrint('Average FPS: ${metrics.averageFps.toStringAsFixed(1)}');
    debugPrint('Min FPS: ${metrics.minFps.toStringAsFixed(1)}');
    debugPrint('Max FPS: ${metrics.maxFps.toStringAsFixed(1)}');
    debugPrint('Total Frames: ${metrics.totalFrames}');
    debugPrint('Duration: ${metrics.duration}ms');

    fpsMonitor.dispose();
  }
}

/// Widget example showing FPS monitoring in a real UI scenario
class FpsMonitoringWidget extends StatefulWidget {
  const FpsMonitoringWidget({super.key});

  @override
  FpsMonitoringWidgetState createState() => FpsMonitoringWidgetState();
}

class FpsMonitoringWidgetState extends State<FpsMonitoringWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  PerformanceTrace? _trace;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _startPerformanceMonitoring();
  }

  void _startPerformanceMonitoring() async {
    final performance = usePerformance();
    _trace = performance.create('2025_performance_animation_widget');

    await _trace!.start();

    // Start animation which will be monitored for FPS
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _stopPerformanceMonitoring();
    super.dispose();
  }

  void _stopPerformanceMonitoring() async {
    if (_trace != null) {
      await _trace!.stop();
      _trace!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FPS Monitoring Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animationController.value * 2 * 3.14159,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Get current FPS while animation is running
          final metrics = _trace?.getCurrentFpsMetrics();
          if (metrics != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Current FPS: ${metrics.averageFps.toStringAsFixed(1)}',
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.speed),
      ),
    );
  }
}
