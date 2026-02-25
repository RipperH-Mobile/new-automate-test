import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/core/infrastructure/analytics/metric/fps_monitor.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FpsMonitor Tests', () {
    late FpsMonitor fpsMonitor;

    setUp(() {
      fpsMonitor = FpsMonitor();
    });

    tearDown(() {
      fpsMonitor.dispose();
    });

    test('should initialize correctly', () {
      expect(fpsMonitor.isMonitoring, false);
      expect(fpsMonitor.frameCount, 0);
      expect(fpsMonitor.fpsSamples, isEmpty);
    });

    test('should start monitoring', () {
      fpsMonitor.start();
      expect(fpsMonitor.isMonitoring, true);
    });

    test('should stop monitoring and return metrics', () async {
      fpsMonitor.start();

      // Simulate some time passing
      await Future.delayed(const Duration(milliseconds: 100));

      final metrics = fpsMonitor.stop();

      expect(fpsMonitor.isMonitoring, false);
      expect(metrics, isA<FpsMetrics>());
      expect(metrics.duration, greaterThan(0));
    });

    test('should calculate FPS metrics correctly', () {
      final metrics = FpsMetrics(
        averageFps: 60.0,
        totalFrames: 120,
        duration: 2000,
        samples: [58.0, 60.0, 62.0],
      );

      expect(metrics.averageFps, 60.0);
      expect(metrics.totalFrames, 120);
      expect(metrics.minFps, 58.0);
      expect(metrics.maxFps, 62.0);

      final firebaseMetrics = metrics.metricsForFirebase;
      expect(firebaseMetrics['avg_fps'], 60);
      expect(firebaseMetrics['min_fps'], 58);
      expect(firebaseMetrics['max_fps'], 62);
      expect(firebaseMetrics['total_frames'], 120);
      expect(firebaseMetrics['duration_ms'], 2000);
    });

    test('should handle empty metrics', () {
      final emptyMetrics = FpsMetrics.empty();

      expect(emptyMetrics.averageFps, 0.0);
      expect(emptyMetrics.totalFrames, 0);
      expect(emptyMetrics.samples, isEmpty);
      expect(emptyMetrics.minFps, 0.0);
      expect(emptyMetrics.maxFps, 0.0);
    });
  });
}
