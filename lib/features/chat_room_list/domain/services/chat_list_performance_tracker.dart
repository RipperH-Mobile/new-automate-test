import 'package:uchat/core/infrastructure/analytics/metric/performance_trace.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';

/// Performance tracker for chat list screen.
/// Tracks various performance metrics related to chat list operations.
class ChatListPerformanceTracker {
  final PerformanceService _performanceService;

  ChatListPerformanceTracker(this._performanceService);

  /// Tracks performance when contact update event occurs.
  /// Returns a trace that should be started and stopped by the caller.
  PerformanceTrace trackContactUpdate() {
    final trace = _performanceService.newTrace('performance_screen_lag_chat_list_contact_update');
    return trace;
  }

  /// Tracks performance when fetching chat list on user loaded.
  /// Returns a trace that should be started and stopped by the caller.
  PerformanceTrace trackChatListFetch() {
    final trace = _performanceService.newTrace('performance_screen_lag_chat_list_fetch');
    return trace;
  }

  /// Starts tracking chat list fetch with user attributes.
  /// Returns a started trace that should be stopped by the caller.
  ///
  /// [userId] - The current user ID
  /// [isFirstTimeLogin] - Whether this is the first time login
  PerformanceTrace startTrackingChatListFetch({
    required String userId,
    required bool isFirstTimeLogin,
  }) {
    final trace = trackChatListFetch();
    trace.start();
    trace.putAttribute('userId', userId);
    trace.putAttribute('appState', isFirstTimeLogin ? 'signIn' : 'close');
    return trace;
  }

  /// Tracks performance when sorting room list by room database updates.
  /// Returns a trace that should be started and stopped by the caller.
  PerformanceTrace trackSortByRoomDb() {
    final trace = _performanceService.newTrace('performance_screen_lag_chat_list_sort_by_room_db');
    return trace;
  }

  /// Tracks performance when sorting room list by room subscription database updates.
  /// Returns a trace that should be started and stopped by the caller.
  PerformanceTrace trackSortByRoomSubDb() {
    final trace = _performanceService.newTrace('performance_screen_lag_chat_list_sort_by_room_sub_db');
    return trace;
  }
}
