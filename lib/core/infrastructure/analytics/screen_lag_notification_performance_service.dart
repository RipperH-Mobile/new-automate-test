import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/constants/performance_trace_names.dart';
import 'package:uchat/core/infrastructure/analytics/mixim/base_performance_trace_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/enum/source_performance_state.dart';
import 'package:uchat/core/infrastructure/analytics/param/screen_lag_perf_attribute_param.dart';

ScreenLagNotificationService useLagNotiPerformance() {
  return GetIt.I<ScreenLagNotificationService>();
}

class ScreenLagNotificationService with BasePerformanceTraceMixin {
  static const String _tag = 'ScreenLagNotificationService';

  @override
  String get tag => _tag;

  bool isAlreadyStarted(String traceName) {
    return startedTraces.contains(traceName);
  }

  /// Check if a trace is already started.
  List<String> startedTraces = <String>[];

  /// Start a screen lag trace with optional attributes.
  ///
  /// [traceName] - Unique identifier for the trace
  /// [attributesParams] - Screen lag attributes to attach to the trace
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns the trace name if successful, null otherwise
  Future<String?> startScreenLagNotiTrace(
    String traceName, {
    ScreenLagPerfAttributeParams? attributesParams,
    bool ignoreStateCheck = false,
  }) async {
    // Append source state to trace name if provided
    String finalTraceName = traceName;
    if (attributesParams?.sourcePerformanceState != null) {
      finalTraceName += '_${attributesParams!.sourcePerformanceState!.value}';
    }

    // Check if the trace is already started
    if (isAlreadyStarted(finalTraceName)) {
      debugPrint('$tag: Trace "$finalTraceName" is already started');
      return finalTraceName;
    }

    // Convert attributes to map
    final Map<String, String>? attributes = attributesParams?.toNameValuePairs();

    await startTrace(
      finalTraceName,
      attributes: attributes,
      ignoreStateCheck: ignoreStateCheck,
    );

    startedTraces.add(finalTraceName);
    return finalTraceName;
  }

  /// Stop a screen lag trace.
  ///
  /// [traceName] - The identifier of the trace to stop
  /// [sourcePerformanceState] - The source state to append to trace name
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns true if trace was stopped successfully, false otherwise
  Future<bool> stopScreenLagNotiTrace(
    String traceName, {
    bool ignoreStateCheck = false,
    SourcePerformanceState? sourcePerformanceState,
  }) async {
    // Append source state to trace name if provided
    String finalTraceName = traceName;
    if (sourcePerformanceState != null) {
      finalTraceName += '_${sourcePerformanceState.value}';
    }

    return await stopTrace(
      finalTraceName,
      ignoreStateCheck: ignoreStateCheck,
    );
  }

  // ============ Legacy Methods for Backward Compatibility ============
  Future<void> startPerformanceScreenLagNoti(
    ScreenLagPerfAttributeParams attributesParams,
  ) async {
    await startScreenLagNotiTrace(
      PerformanceTraceNames.performanceScreenLagNotificationCenter,
      attributesParams: attributesParams,
    );
  }

  /// track first render metric
  /// [attributesParams] - Screen lag attributes to attach to the trace
  void trackFirstRenderMetric(
    SourcePerformanceState sourcePerformanceState,
  ) {
    final String finalTraceName =
        PerformanceTraceNames.performanceScreenLagNotificationCenter + ('_${sourcePerformanceState.value}');
    final Duration? processDuration = getCapturedDuration(finalTraceName);
    addMetric(finalTraceName, 'first_render_time_ms', processDuration?.inMilliseconds ?? 0);
  }

  /// Legacy method - Stop incoming call trace.
  Future<void> stopPerformanceScreenLagNoti({required SourcePerformanceState sourcePerformanceState}) async {
    await stopScreenLagNotiTrace(
      PerformanceTraceNames.performanceScreenLagNotificationCenter,
      sourcePerformanceState: sourcePerformanceState,
    );
  }
}
