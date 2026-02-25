import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class FpsMonitor {
  int _frameCount = 0;
  late Stopwatch _stopwatch;
  double _fps = 0.0;
  bool _isMonitoring = false;
  Timer? _fpsTimer;

  // Store FPS samples for calculating average, min, max
  final List<double> _fpsSamples = [];

  // Callback to track frame rendering
  late FrameCallback _frameCallback;

  // Getters for accessing internal state
  bool get isMonitoring => _isMonitoring;

  int get frameCount => _frameCount;

  int get elapsedMilliseconds => _stopwatch.elapsedMilliseconds;

  List<double> get fpsSamples => _fpsSamples;

  void start() {
    if (_isMonitoring) return;

    _frameCount = 0;
    _fpsSamples.clear();
    _stopwatch = Stopwatch()..start();
    _isMonitoring = true;

    // Start monitoring frames
    _startFrameCallback();

    // Sample FPS every second
    _fpsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isMonitoring) {
        _sampleCurrentFps();
      }
    });

    debugPrint('[FpsMonitor] Started FPS monitoring');
  }

  void _startFrameCallback() {
    _frameCallback = (timeStamp) {
      if (_isMonitoring) {
        _frameCount++;
        SchedulerBinding.instance.scheduleFrameCallback(_frameCallback);
      }
    };
    SchedulerBinding.instance.scheduleFrameCallback(_frameCallback);
  }

  void _sampleCurrentFps() {
    if (_stopwatch.elapsedMilliseconds > 0) {
      final currentFps = _frameCount / (_stopwatch.elapsedMilliseconds / 1000);
      _fpsSamples.add(currentFps);
    }
  }

  FpsMetrics stop() {
    if (!_isMonitoring) return FpsMetrics.empty();

    _isMonitoring = false;
    _fpsTimer?.cancel();
    _stopwatch.stop();

    // Calculate final FPS
    if (_stopwatch.elapsedMilliseconds > 0) {
      _fps = _frameCount / (_stopwatch.elapsedMilliseconds / 1000);
    }

    // Sample one last time
    _sampleCurrentFps();

    final metrics = FpsMetrics(
      averageFps: _fps,
      totalFrames: _frameCount,
      duration: _stopwatch.elapsedMilliseconds,
      samples: List.from(_fpsSamples),
    );

    debugPrint('[FpsMonitor] Stopped FPS monitoring - Average FPS: ${metrics.averageFps.toStringAsFixed(1)}');

    return metrics;
  }

  void dispose() {
    _fpsTimer?.cancel();
    _isMonitoring = false;
  }
}

class FpsMetrics {
  final double averageFps;
  final int totalFrames;
  final int duration; // milliseconds
  final List<double> samples;

  FpsMetrics({
    required this.averageFps,
    required this.totalFrames,
    required this.duration,
    required this.samples,
  });

  factory FpsMetrics.empty() {
    return FpsMetrics(
      averageFps: 0.0,
      totalFrames: 0,
      duration: 0,
      samples: [],
    );
  }

  double get minFps => samples.isEmpty ? 0.0 : samples.reduce((a, b) => a < b ? a : b);

  double get maxFps => samples.isEmpty ? 0.0 : samples.reduce((a, b) => a > b ? a : b);

  Map<String, int> get metricsForFirebase => {
        'avg_fps': averageFps.round(),
        'min_fps': minFps.round(),
        'max_fps': maxFps.round(),
        'total_frames': totalFrames,
        'duration_ms': duration,
      };
}
