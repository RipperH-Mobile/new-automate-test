import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';

abstract class PerformanceTracingService {
  final String tracingName;

  late PerformanceTrace activeTrace;

  PerformanceTracingService({required this.tracingName}) {
    _initializeTrace();
  }

  void _initializeTrace() {
    activeTrace = usePerformance().newTrace(tracingName);
  }

  bool _isTracing = false;

  Future<void> start() async {
    if (_isTracing) {
      // Already running, nothing to start.
      return;
    }

    _isTracing = true;
    await activeTrace.start();
  }

  Future<void> stop() async {
    if (!_isTracing) {
      // Not running, nothing to stop.
      return;
    }

    await activeTrace.stop();
    _isTracing = false;

    _initializeTrace();
  }

  void setMetric(String name, int value) {
    if (!_isTracing) {
      // Trace is not active, cannot set metric
      return;
    }
    activeTrace.setMetric(name, value);
  }

  void incrementMetric(String name, int value) {
    if (!_isTracing) {
      // Trace is not active, cannot increment metric
      return;
    }
    activeTrace.incrementMetric(name, value);
  }

  void putAttribute(String name, String value) {
    if (!_isTracing) {
      // Trace is not active, cannot put attribute
      return;
    }
    activeTrace.putAttribute(name, value);
  }
}
