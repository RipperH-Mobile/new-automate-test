import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/enums/app_state.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';

/// Base mixin for performance trace management.
/// Provides common functionality for starting, stopping, and managing traces.
mixin BasePerformanceTraceMixin {
  // Map to store multiple active traces
  final Map<String, PerformanceTrace> _activeTraces = {};

  /// Override this to provide a custom tag for logging
  String get tag;

  LifeCycleService get _lifeCycleService => GetIt.I<LifeCycleService>();

  /// Start a dynamic trace with optional attributes and metrics.
  ///
  /// [traceName] - Unique identifier for the trace
  /// [attributes] - Optional map of custom attributes to attach to the trace
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns the trace name if successful, null otherwise
  Future<String?> startTrace(
    String traceName, {
    Map<String, String>? attributes,
    bool ignoreStateCheck = false,
  }) async {
    try {
      if (!ignoreStateCheck && _lifeCycleService.appState != AppState.active) {
        debugPrint('$tag: App is not active. Skipping trace start for "$traceName".');
        return null;
      }

      // Check if trace already exists
      if (_activeTraces.containsKey(traceName)) {
        debugPrint('$tag: Trace "$traceName" is already active');
        return traceName;
      }

      // Start Firebase trace
      final PerformanceTrace perfTrace = usePerformance().create(traceName);
      await perfTrace.start();

      // Set custom attributes if provided
      if (attributes != null) {
        for (final entry in attributes.entries) {
          perfTrace.putAttribute(entry.key, entry.value);
        }
      }

      debugPrint('$tag: all attributes set: ${perfTrace.getAttributes()}');

      _activeTraces[traceName] = perfTrace;
      debugPrint('$tag: Trace started successfully: $traceName');

      return traceName;
    } catch (e) {
      debugPrint('$tag: Error starting trace "$traceName": $e');
      return null;
    }
  }

  /// Stop a specific trace by name.
  ///
  /// [traceName] - The identifier of the trace to stop
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns true if trace was stopped successfully, false otherwise
  Future<bool> stopTrace(
    String traceName, {
    bool ignoreStateCheck = false,
  }) async {
    try {
      if (!ignoreStateCheck && _lifeCycleService.appState != AppState.active) {
        debugPrint('$tag: App is not active. Skipping trace stop for "$traceName".');
        return false;
      }

      final trace = _activeTraces.remove(traceName);
      if (trace == null) {
        debugPrint('$tag: Trace "$traceName" not found or already stopped');
        return false;
      }

      await trace.stop();
      debugPrint('$tag: Trace stopped successfully: $traceName');

      return true;
    } catch (e) {
      debugPrint('$tag: Error stopping trace "$traceName": $e');
      return false;
    } finally {
      debugPrint('$tag: ------------------------------------------------');
    }
  }

  /// Add a custom metric to a specific trace.
  ///
  /// [traceName] - The identifier of the trace
  /// [metricName] - The name of the metric
  /// [value] - The numeric value of the metric
  bool addMetric(String traceName, String metricName, int value)  {
    try {
      final PerformanceTrace? trace = _activeTraces[traceName];
      if (trace == null) {
        debugPrint('$tag: Trace "$traceName" not found for metric "$metricName"');
        return false;
      }

      trace.incrementMetric(metricName, value);
      debugPrint('$tag: Metric added - $traceName.$metricName=$value');
      return true;
    } catch (e) {
      debugPrint('$tag: Error adding metric to trace "$traceName": $e');
      return false;
    }
  }

  /// Stop all active traces (useful for cleanup).
  ///
  /// Returns the count of traces stopped
  Future<int> stopAllTraces() async {
    try {
      final count = _activeTraces.length;
      final traceNames = List<String>.from(_activeTraces.keys);

      for (final traceName in traceNames) {
        await stopTrace(traceName);
      }

      debugPrint('$tag: All traces stopped. Count: $count');
      return count;
    } catch (e) {
      debugPrint('$tag: Error during stopAllTraces: $e');
      return 0;
    }
  }

  /// Get the count of currently active traces.
  int getActiveTraceCount() => _activeTraces.length;

  /// Check if a specific trace is active.
  ///
  /// [traceName] - The identifier of the trace
  bool isTraceActive(String traceName) => _activeTraces.containsKey(traceName);

  /// Get all active trace names.
  List<String> getActiveTraceNames() => List<String>.from(_activeTraces.keys);

  /// Get captured duration of a specific trace.
  /// [traceName] - The identifier of the trace
  Duration? getCapturedDuration(String traceName) {
    final trace = _activeTraces[traceName];
    return trace?.capturedDuration;
  }
}
