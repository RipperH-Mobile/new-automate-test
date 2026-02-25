import 'dart:async';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import 'event_bus_impl.dart';
import 'event_tracker.dart';

final _log = useLogger();

/// An enhanced EventBus with tracking capabilities for troubleshooting
class TrackedEventBus extends EventBus {
  final EventTracker? _tracker;
  bool _isTrackingEnabled = false;

  /// Map to track active listeners by event type
  final Map<Type, int> _listenerCounts = {};

  TrackedEventBus({
    super.sync,
    EventTracker? tracker,
    bool enableTracking = false,
  })  : _tracker = tracker,
        _isTrackingEnabled = enableTracking;

  /// Enable or disable event tracking
  void setTrackingEnabled(bool enabled) {
    _isTrackingEnabled = enabled;
    _tracker?.setEnabled(enabled);

    if (enabled) {
      _log.d('Event tracking enabled');
    } else {
      _log.d('Event tracking disabled');
      _tracker?.clearHistory();
    }
  }

  /// Get current tracking status
  bool get isTrackingEnabled => _isTrackingEnabled;

  /// Get event tracker instance
  EventTracker? get tracker => _tracker;

  @override
  Stream<T> on<T>() {
    final stream = super.on<T>();

    if (_isTrackingEnabled) {
      // Track listener registration
      final eventType = T;
      _listenerCounts[eventType] = (_listenerCounts[eventType] ?? 0) + 1;

      _tracker?.trackListenerRegistration(
        eventType: eventType.toString(),
        listenerCount: _listenerCounts[eventType]!,
      );

      // Return a stream that tracks when listeners are removed
      return stream.doOnCancel(() {
        _listenerCounts[eventType] = (_listenerCounts[eventType] ?? 1) - 1;
        if (_listenerCounts[eventType] == 0) {
          _listenerCounts.remove(eventType);
        }

        _tracker?.trackListenerRemoval(
          eventType: eventType.toString(),
          remainingListeners: _listenerCounts[eventType] ?? 0,
        );
      });
    }

    return stream;
  }

  @override
  void fire(event) {
    if (_isTrackingEnabled && _tracker != null) {
      final stopwatch = Stopwatch()..start();

      // Track event before firing
      _tracker!.trackEventFired(
        event: event,
        timestamp: DateTime.now(),
        eventType: event.runtimeType.toString(),
      );

      try {
        super.fire(event);

        stopwatch.stop();

        // Track successful execution
        _tracker!.trackEventExecuted(
          event: event,
          duration: stopwatch.elapsed,
          listenerCount: _listenerCounts[event.runtimeType] ?? 0,
        );
      } catch (e, stackTrace) {
        stopwatch.stop();

        // Track event error
        _tracker!.trackEventError(
          event: event,
          error: e,
          stackTrace: stackTrace,
          duration: stopwatch.elapsed,
        );

        rethrow;
      }
    } else {
      super.fire(event);
    }
  }

  /// Get statistics about event usage
  Map<String, dynamic> getStatistics() {
    if (!_isTrackingEnabled || _tracker == null) {
      return {};
    }

    return _tracker!.getStatistics();
  }

  /// Get event history
  List<TrackedEvent> getEventHistory({
    String? eventTypeFilter,
    DateTime? startTime,
    DateTime? endTime,
    int? limit,
  }) {
    if (!_isTrackingEnabled || _tracker == null) {
      return [];
    }

    return _tracker!.getHistory(
      eventTypeFilter: eventTypeFilter,
      startTime: startTime,
      endTime: endTime,
      limit: limit,
    );
  }

  /// Clear event history
  void clearHistory() {
    _tracker?.clearHistory();
  }

  /// Export event history as JSON
  String exportHistoryAsJson() {
    if (!_isTrackingEnabled || _tracker == null) {
      return '[]';
    }

    return _tracker!.exportAsJson();
  }

  /// Export event history as CSV
  String exportHistoryAsCsv() {
    if (!_isTrackingEnabled || _tracker == null) {
      return '';
    }

    return _tracker!.exportAsCsv();
  }

  /// Get current listener counts by event type
  Map<String, int> getListenerCounts() {
    return Map.fromEntries(
      _listenerCounts.entries.map((e) => MapEntry(e.key.toString(), e.value)),
    );
  }

  @override
  void destroy() {
    _listenerCounts.clear();

    _tracker?.dispose();
    super.destroy();
  }
}

/// Extension to add tracking capabilities to streams
extension StreamTracking<T> on Stream<T> {
  /// Add a callback when the stream is cancelled
  Stream<T> doOnCancel(void Function() onCancel) {
    final controller = StreamController<T>.broadcast();

    StreamSubscription<T>? subscription;

    controller.onListen = () {
      subscription = listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
    };

    controller.onCancel = () {
      onCancel();
      subscription?.cancel();
    };

    return controller.stream;
  }
}
