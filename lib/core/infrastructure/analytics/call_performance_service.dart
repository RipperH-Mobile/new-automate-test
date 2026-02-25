import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/constants/performance_trace_names.dart';
import 'package:uchat/core/infrastructure/analytics/mixim/base_performance_trace_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/param/call_attribute_param.dart';

CallPerformanceService useCallPerformance() {
  return GetIt.I<CallPerformanceService>();
}

/// Performance tracking service for call and general application metrics.
/// Supports multiple concurrent traces with dynamic configuration.
class CallPerformanceService with BasePerformanceTraceMixin {
  static const String _tag = 'CallPerformanceService';

  @override
  String get tag => _tag;

  /// Start a call-specific trace with call attributes.
  ///
  /// [traceName] - Unique identifier for the trace
  /// [callAttributesParams] - Call-specific attributes to attach to the trace
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns the trace name if successful, null otherwise
  Future<String?> startCallTrace(
    String traceName, {
    CallAttributesParams? callAttributesParams,
    bool ignoreStateCheck = false,
  }) async {
    // Append receive method to trace name if provided
    String finalTraceName = traceName;
    if (callAttributesParams?.receivingFrom != null) {
      finalTraceName += '_${callAttributesParams!.receivingFrom!.name}';
    }

    // Convert call attributes to map
    final Map<String, String>? attributes = callAttributesParams?.toNameValuePairs();

    return await startTrace(
      finalTraceName,
      attributes: attributes,
      ignoreStateCheck: ignoreStateCheck,
    );
  }

  /// Stop a call-specific trace.
  ///
  /// [traceName] - The identifier of the trace to stop
  /// [receiveMethod] - The receive method to append to trace name
  /// [ignoreStateCheck] - Whether to skip app state validation
  ///
  /// Returns true if trace was stopped successfully, false otherwise
  Future<bool> stopCallTrace(
    String traceName, {
    bool ignoreStateCheck = false,
    ReceiveMethod? receiveMethod,
  }) async {
    // Append receive method to trace name if provided
    String finalTraceName = traceName;
    if (receiveMethod != null) {
      finalTraceName += '_${receiveMethod.name}';
    }

    return await stopTrace(
      finalTraceName,
      ignoreStateCheck: ignoreStateCheck,
    );
  }

  // ============ Legacy Methods for Backward Compatibility ============

  /// Legacy method - Start incoming call trace with trigger method.
  /// Defaults to 'performance_calling_incoming_call' trace name.
  ///
  /// [callAttributesParams] - The call attributes containing receive method
  Future<void> startPerformanceCallingIncomingCall(
    CallAttributesParams callAttributesParams,
  ) async {
    await startCallTrace(
      PerformanceTraceNames.performanceCallingIncomingCall,
      callAttributesParams: callAttributesParams,
    );
  }

  /// Legacy method - Stop incoming call trace.
  Future<void> stopPerformanceCallingIncomingCall({required ReceiveMethod receiveMethod}) async {
    await stopCallTrace(
      PerformanceTraceNames.performanceCallingIncomingCall,
      receiveMethod: receiveMethod,
    );
  }

  /// Legacy method - Start accept call to first time count start.
  /// Defaults to 'performance_calling_accept' trace name.
  /// [callAttributesParams] - The call attributes containing receive method
  Future<void> startPerformanceCallingAccept(
    CallAttributesParams callAttributesParams,
  ) async {
    await startCallTrace(
      PerformanceTraceNames.performanceCallingAccept,
      ignoreStateCheck: callAttributesParams.receivingFrom == ReceiveMethod.native,
      callAttributesParams: callAttributesParams,
    );
  }

  /// Legacy method - Stop accept call to first time count start trace.
  Future<void> stopPerformanceCallingAccept({required ReceiveMethod receiveMethod}) async {
    await stopCallTrace(
      PerformanceTraceNames.performanceCallingAccept,
      receiveMethod: receiveMethod,
    );
  }

  /// Legacy method - Start decline call to missed call display trace.
  /// Defaults to 'performance_calling_missed' trace name.
  Future<void> startPerformanceCallingMissed(
    CallAttributesParams callAttributesParams,
  ) async {
    await startCallTrace(
      PerformanceTraceNames.performanceCallingMissed,
      callAttributesParams: callAttributesParams,
    );
  }

  /// Legacy method - Stop decline call to missed call display trace.
  Future<void> stopPerformanceCallingMissed({required ReceiveMethod receiveMethod}) async {
    await stopCallTrace(
      PerformanceTraceNames.performanceCallingMissed,
      receiveMethod: receiveMethod,
    );
  }
}
