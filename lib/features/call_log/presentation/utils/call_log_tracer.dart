import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';

/// Constants for CallLog performance tracing
class CallLogTraceNames {
  static const String localCache = 'performance_screen_lag_call_log_local_cache';
  static const String fetch = 'performance_screen_lag_call_log_fetch';
  static const String delete = 'performance_screen_lag_call_log_delete';
  static const String searchContacts = 'performance_screen_lag_call_log_search_contacts';
  static const String searchCallLogs = 'performance_screen_lag_call_log_search_call_logs';
}

/// Constants for CallLog performance metrics
class CallLogMetricNames {
  static const String cacheReadTime = 'cacheReadTime';
  static const String cachedLogsCount = 'cachedLogsCount';
  static const String fetchDuration = 'fetchDuration';
  static const String callLogsCount = 'callLogsCount';
  static const String pageNumber = 'pageNumber';
  static const String totalPages = 'totalPages';
  static const String deleteDuration = 'deleteDuration';
  static const String logsDeletedCount = 'logsDeletedCount';
  static const String searchDuration = 'searchDuration';
  static const String searchResultsCount = 'searchResultsCount';
  static const String contactSearchDuration = 'contactSearchDuration';
  static const String contactSearchResultsCount = 'contactSearchResultsCount';
}

/// Constants for CallLog performance attributes
class CallLogAttributeNames {
  static const String callActionType = 'callActionType';
  static const String searchKeyword = 'searchKeyword';
  static const String searchPage = 'searchPage';
  static const String callLogId = 'callLogId';
  static const String appState = 'appState';
  static const String operationSuccess = 'operationSuccess';
}

/// Helper class for Firebase Performance tracing in CallLogScreenController.
/// Provides reusable trace wrappers to reduce boilerplate while preserving all metrics and attributes.
class CallLogTracer {
  /// Wraps a performance trace around an async operation.
  /// Handles start/stop, initial attributes, success flag, and error handling.
  /// The [body] callback receives the [PerformanceTrace] instance to record custom metrics/attributes.
  static Future<void> trace({
    required String name,
    required Future<void> Function(PerformanceTrace trace) body,
    Map<String, String>? initialAttributes,
  }) async {
    final traceInstance = PerformanceTrace.create(name);
    await traceInstance.start();

    try {
      initialAttributes?.forEach((key, value) {
        traceInstance.putAttribute(key, value);
      });

      await body(traceInstance);

      traceInstance.putAttribute(CallLogAttributeNames.operationSuccess, 'true');
    } catch (_) {
      traceInstance.putAttribute(CallLogAttributeNames.operationSuccess, 'false');
    } finally {
      traceInstance.putAttribute(
        CallLogAttributeNames.appState,
        UserController.instance.isFirstTimeLogin ? 'signIn' : 'close',
      );
      await traceInstance.stop();
    }
  }
}
