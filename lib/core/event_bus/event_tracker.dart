import 'dart:collection';
import 'dart:convert';
import 'dart:math';

/// Tracks event bus activity for debugging and troubleshooting
class EventTracker {
  static const int defaultMaxHistorySize = 1000;

  final int maxHistorySize;
  final Queue<TrackedEvent> _eventHistory = Queue();
  final Map<String, EventStatistics> _eventStatistics = {};

  bool _isEnabled = false;

  EventTracker({
    this.maxHistorySize = defaultMaxHistorySize,
    bool enabled = false,
  }) : _isEnabled = enabled;

  /// Set whether tracking is enabled
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    if (!enabled) {
      clearHistory();
    }
  }

  /// Get whether tracking is enabled
  bool get isEnabled => _isEnabled;

  /// Track when an event is fired
  void trackEventFired({
    required dynamic event,
    required DateTime timestamp,
    required String eventType,
  }) {
    if (!_isEnabled) return;

    final trackedEvent = TrackedEvent(
      event: event,
      eventType: eventType,
      timestamp: timestamp,
      status: EventStatus.fired,
    );

    _addToHistory(trackedEvent);
    _updateStatistics(eventType, EventStatus.fired);
  }

  /// Track when an event is successfully executed
  void trackEventExecuted({
    required dynamic event,
    required Duration duration,
    required int listenerCount,
  }) {
    if (!_isEnabled) return;

    // Find the most recent fired event of this type and update its status
    final eventType = event.runtimeType.toString();
    for (var i = _eventHistory.length - 1; i >= 0; i--) {
      final trackedEvent = _eventHistory.elementAt(i);
      if (trackedEvent.event == event && trackedEvent.status == EventStatus.fired) {
        trackedEvent.executionDuration = duration;
        trackedEvent.listenerCount = listenerCount;
        trackedEvent.status = EventStatus.executed;
        break;
      }
    }

    _updateStatistics(eventType, EventStatus.executed, duration: duration);
  }

  /// Track when an event encounters an error
  void trackEventError({
    required dynamic event,
    required Object error,
    required StackTrace stackTrace,
    required Duration duration,
  }) {
    if (!_isEnabled) return;

    final eventType = event.runtimeType.toString();

    // Find the most recent fired event of this type and update its status
    for (var i = _eventHistory.length - 1; i >= 0; i--) {
      final trackedEvent = _eventHistory.elementAt(i);
      if (trackedEvent.event == event && trackedEvent.status == EventStatus.fired) {
        trackedEvent.executionDuration = duration;
        trackedEvent.status = EventStatus.error;
        trackedEvent.error = error;
        trackedEvent.stackTrace = stackTrace;
        break;
      }
    }

    _updateStatistics(eventType, EventStatus.error, duration: duration);
  }

  /// Track listener registration
  void trackListenerRegistration({
    required String eventType,
    required int listenerCount,
  }) {
    if (!_isEnabled) return;

    final stats = _eventStatistics[eventType] ?? EventStatistics(eventType: eventType);
    stats.currentListenerCount = listenerCount;
    stats.maxListenerCount = max(stats.maxListenerCount, listenerCount);
    _eventStatistics[eventType] = stats;
  }

  /// Track listener removal
  void trackListenerRemoval({
    required String eventType,
    required int remainingListeners,
  }) {
    if (!_isEnabled) return;

    final stats = _eventStatistics[eventType];
    if (stats != null) {
      stats.currentListenerCount = remainingListeners;
    }
  }

  /// Add event to history with size limit
  void _addToHistory(TrackedEvent event) {
    _eventHistory.add(event);

    // Maintain max history size
    while (_eventHistory.length > maxHistorySize) {
      _eventHistory.removeFirst();
    }
  }

  /// Update statistics for an event type
  void _updateStatistics(String eventType, EventStatus status, {Duration? duration}) {
    final stats = _eventStatistics[eventType] ?? EventStatistics(eventType: eventType);

    switch (status) {
      case EventStatus.fired:
        stats.firedCount++;
        stats.lastFired = DateTime.now();
        break;
      case EventStatus.executed:
        stats.executedCount++;
        if (duration != null) {
          stats.totalExecutionTime += duration;
          stats.minExecutionTime = stats.minExecutionTime == null
              ? duration
              : Duration(
                  microseconds: min(
                    stats.minExecutionTime!.inMicroseconds,
                    duration.inMicroseconds,
                  ),
                );
          stats.maxExecutionTime = stats.maxExecutionTime == null
              ? duration
              : Duration(
                  microseconds: max(
                    stats.maxExecutionTime!.inMicroseconds,
                    duration.inMicroseconds,
                  ),
                );
        }
        break;
      case EventStatus.error:
        stats.errorCount++;
        break;
    }

    _eventStatistics[eventType] = stats;
  }

  /// Get filtered event history
  List<TrackedEvent> getHistory({
    String? eventTypeFilter,
    DateTime? startTime,
    DateTime? endTime,
    int? limit,
  }) {
    var events = _eventHistory.toList();

    // Apply filters
    if (eventTypeFilter != null) {
      events = events.where((e) => e.eventType == eventTypeFilter).toList();
    }

    if (startTime != null) {
      events = events.where((e) => e.timestamp.isAfter(startTime)).toList();
    }

    if (endTime != null) {
      events = events.where((e) => e.timestamp.isBefore(endTime)).toList();
    }

    // Apply limit
    if (limit != null && events.length > limit) {
      events = events.skip(events.length - limit).toList();
    }

    return events;
  }

  /// Get statistics for all or specific event types
  Map<String, dynamic> getStatistics({String? eventTypeFilter}) {
    if (eventTypeFilter != null) {
      final stats = _eventStatistics[eventTypeFilter];
      return stats?.toMap() ?? {};
    }

    return {
      'totalEvents': _eventHistory.length,
      'eventTypes': _eventStatistics.length,
      'statistics': _eventStatistics.map((k, v) => MapEntry(k, v.toMap())),
    };
  }

  /// Clear all tracked history
  void clearHistory() {
    _eventHistory.clear();
    _eventStatistics.clear();
  }

  /// Export history as JSON
  String exportAsJson() {
    final data = _eventHistory.map((e) => e.toMap()).toList();
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// Export history as CSV
  String exportAsCsv() {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('Timestamp,EventType,Status,Duration(μs),ListenerCount,Error');

    // Data rows
    for (final event in _eventHistory) {
      buffer.writeln([
        event.timestamp.toIso8601String(),
        event.eventType,
        event.status.toString().split('.').last,
        event.executionDuration?.inMicroseconds ?? '',
        event.listenerCount ?? '',
        event.error?.toString().replaceAll(',', ';') ?? '',
      ].join(','));
    }

    return buffer.toString();
  }

  /// Dispose tracker resources
  void dispose() {
    clearHistory();
  }
}

/// Represents a tracked event
class TrackedEvent {
  final dynamic event;
  final String eventType;
  final DateTime timestamp;
  EventStatus status;
  Duration? executionDuration;
  int? listenerCount;
  Object? error;
  StackTrace? stackTrace;

  TrackedEvent({
    required this.event,
    required this.eventType,
    required this.timestamp,
    required this.status,
    this.executionDuration,
    this.listenerCount,
    this.error,
    this.stackTrace,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventType': eventType,
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString().split('.').last,
      'executionDuration': executionDuration?.inMicroseconds,
      'listenerCount': listenerCount,
      'hasError': error != null,
      'error': error?.toString(),
      'eventData': _safeEventToString(event),
    };
  }

  String _safeEventToString(dynamic event) {
    try {
      return event.toString();
    } catch (e) {
      return 'Event[${event.runtimeType}]';
    }
  }
}

/// Event execution status
enum EventStatus {
  fired,
  executed,
  error,
}

/// Statistics for a specific event type
class EventStatistics {
  final String eventType;
  int firedCount = 0;
  int executedCount = 0;
  int errorCount = 0;
  DateTime? lastFired;
  Duration totalExecutionTime = Duration.zero;
  Duration? minExecutionTime;
  Duration? maxExecutionTime;
  int currentListenerCount = 0;
  int maxListenerCount = 0;

  EventStatistics({required this.eventType});

  Duration get averageExecutionTime {
    if (executedCount == 0) return Duration.zero;
    return Duration(
      microseconds: totalExecutionTime.inMicroseconds ~/ executedCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventType': eventType,
      'firedCount': firedCount,
      'executedCount': executedCount,
      'errorCount': errorCount,
      'lastFired': lastFired?.toIso8601String(),
      'averageExecutionTime': averageExecutionTime.inMicroseconds,
      'minExecutionTime': minExecutionTime?.inMicroseconds,
      'maxExecutionTime': maxExecutionTime?.inMicroseconds,
      'currentListenerCount': currentListenerCount,
      'maxListenerCount': maxListenerCount,
    };
  }
}