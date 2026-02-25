import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_perf_monitor/flutter_perf_monitor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uchat/utils/app_env.dart';

import 'duration.dart';
import 'fps_monitor.dart';

class PerformanceTrace {
  final String name;

  final Trace _trace;
  final DurationMetric? _durationMetric;
  final FpsMonitor? _fpsMonitor;
  ISentrySpan? sentryTrace;

  PerformanceTrace(this.name, this._trace, this._durationMetric, this._fpsMonitor, this.sentryTrace);

  ///
  /// Factory for create the performace tracing.
  /// - [useDurationMetric] is disabled when using release mode.
  /// - [useFpsMonitoring] enables FPS monitoring during the trace.
  ///
  factory PerformanceTrace.create(
    String name, {
    FirebasePerformance? performance,
    bool useDurationMetric = true,
    bool useFpsMonitoring = true,
  }) {
    DurationMetric? durationMetric;
    if (useDurationMetric && !kReleaseMode) {
      durationMetric = DurationMetric(name);
    }

    FpsMonitor? fpsMonitor;
    if (useFpsMonitoring) {
      // fpsMonitor = FpsMonitor();
    }

    final Trace trace;
    if (performance != null) {
      trace = performance.newTrace(name);
    } else {
      trace = FirebasePerformance.instance.newTrace(name);
    }

    return PerformanceTrace(name, trace, durationMetric, fpsMonitor, null);
  }

  Future<void> start() async {
    _startSentryTrace();
    await _trace.start();
    _durationMetric?.start();
    _fpsMonitor?.start();
  }

  Future<void> stop() async {
    // Stop FPS monitoring and get metrics before stopping the trace
    final fpsMetrics = _fpsMonitor?.stop();

    // Add FPS metrics to the Firebase trace
    if (fpsMetrics != null) {
      for (final entry in fpsMetrics.metricsForFirebase.entries) {
        _trace.setMetric(entry.key, entry.value);
      }
    }

    await _trace.stop();
    _durationMetric?.stop();
    await _stopSentryTrace();
  }

  void incrementMetric(String name, int value) {
    _trace.incrementMetric(name, value);
    sentryTrace?.setMeasurement(name, value);
  }

  void putMetric(String name, int value) {
    _trace.setMetric(name, value);
    sentryTrace?.setMeasurement(name, value);
  }

  /// Get current FPS metrics without stopping the monitoring
  FpsMetrics? getCurrentFpsMetrics() {
    // if (_fpsMonitor == null || !_fpsMonitor?.isMonitoring) return null;

    final elapsedMs = _fpsMonitor?.elapsedMilliseconds ?? 999;
    final fpsMonitor = _fpsMonitor?.frameCount ?? 999;
    if (elapsedMs == 0) return null;

    return FpsMetrics(
      averageFps: fpsMonitor / (elapsedMs / 1000),
      totalFrames: fpsMonitor,
      duration: elapsedMs,
      samples: List.from(_fpsMonitor!.fpsSamples),
    );
  }

  void dispose() {
    _fpsMonitor?.dispose();
  }

  void setMetric(String name, int value) {
    return _trace.setMetric(name, value);
  }

  void putAttribute(String name, String value) {
    _trace.putAttribute(name, value);
    sentryTrace?.setData(name, value);
  }

  Map<String, String> getAttributes() {
    return _trace.getAttributes();
  }

  Duration? get capturedDuration {
    return _durationMetric?.capturedDuration;
  }

  void _startSentryTrace() {
    if (!AppEnv.isSentryDebug) return;

    FlutterPerfMonitor.startMonitoring();
    sentryTrace = Sentry.startTransaction(name, name);
  }

  Future<void> _stopSentryTrace() async {
    if (!AppEnv.isSentryDebug) return;

    final metric = FlutterPerfMonitor.getCurrentMetrics();
    sentryTrace?.setMeasurement(
      'cpuUsage',
      metric.cpuUsage,
      unit: FractionSentryMeasurementUnit.percent,
    );
    sentryTrace?.setMeasurement(
      'memoryUsage',
      metric.memoryUsage / 1024 / 1024,
      unit: InformationSentryMeasurementUnit.megaByte,
    );
    FlutterPerfMonitor.stopMonitoring();
    await sentryTrace?.finish();
  }
}
