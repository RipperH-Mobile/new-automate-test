import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class EventMonitorController extends GetxController {
  // Observable properties
  final isTracking = false.obs;
  final isPaused = false.obs;
  final eventHistory = <TrackedEvent>[].obs;
  final filteredEvents = <TrackedEvent>[].obs;
  final eventTypeFilter = ''.obs;
  final searchQuery = ''.obs;
  final selectedEventTypes = <String>{}.obs;
  final availableEventTypes = <String>[].obs;
  final showOnlyErrors = false.obs;
  final autoScroll = true.obs;

  // Statistics
  final totalEventCount = 0.obs;
  final errorCount = 0.obs;
  final averageExecutionTime = Duration.zero.obs;
  final eventStatistics = <String, dynamic>{}.obs;

  Timer? _refreshTimer;
  StreamSubscription? _eventSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeTracking();
    _startRefreshTimer();
    _loadEventHistory();
    _updateStatistics();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    _eventSubscription?.cancel();
    super.onClose();
  }

  void _initializeTracking() {
    isTracking.value = eventBus.isTrackingEnabled;

    if (isTracking.value) {
      // Subscribe to all events for real-time monitoring
      _eventSubscription = eventBus.on().listen((event) {
        if (!isPaused.value) {
          _loadEventHistory();
        }
      });
    }
  }

  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isTracking.value && !isPaused.value) {
        _loadEventHistory();
        _updateStatistics();
      }
    });
  }

  void _loadEventHistory() {
    if (!eventBus.isTrackingEnabled) {
      eventHistory.clear();
      filteredEvents.clear();
      return;
    }

    final history = eventBus.getEventHistory(limit: 500);
    eventHistory.value = history;

    // Update available event types
    final types = history.map((e) => e.eventType).toSet().toList()..sort();
    availableEventTypes.value = types;

    _applyFilters();
  }

  void _applyFilters() {
    var filtered = eventHistory.toList();

    // Filter by event type
    if (selectedEventTypes.isNotEmpty) {
      filtered = filtered.where((e) => selectedEventTypes.contains(e.eventType)).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((e) {
        return e.eventType.toLowerCase().contains(query) ||
               e.toMap()['eventData'].toString().toLowerCase().contains(query);
      }).toList();
    }

    // Filter by errors only
    if (showOnlyErrors.value) {
      filtered = filtered.where((e) => e.status == EventStatus.error).toList();
    }

    filteredEvents.value = filtered;
  }

  void _updateStatistics() {
    if (!eventBus.isTrackingEnabled) return;

    final stats = eventBus.getStatistics();
    eventStatistics.value = stats;

    // Update counters
    totalEventCount.value = eventHistory.length;
    errorCount.value = eventHistory.where((e) => e.status == EventStatus.error).length;

    // Calculate average execution time
    final executedEvents = eventHistory.where((e) => e.executionDuration != null);
    if (executedEvents.isNotEmpty) {
      final totalMicroseconds = executedEvents
          .map((e) => e.executionDuration!.inMicroseconds)
          .reduce((a, b) => a + b);
      averageExecutionTime.value = Duration(
        microseconds: totalMicroseconds ~/ executedEvents.length,
      );
    }
  }

  void toggleTracking() async {
    try {
      await UChatLoading.show(status: isTracking.value ? 'Disabling tracking...' : 'Enabling tracking...');

      final newState = !isTracking.value;
      setEventTrackingEnabled(newState);
      isTracking.value = newState;

      if (newState) {
        _initializeTracking();
      } else {
        _eventSubscription?.cancel();
        _eventSubscription = null;
      }

      await UChatLoading.hide();
      UChatLoading.success(
        message: newState ? 'Event tracking enabled' : 'Event tracking disabled',
      );
    } catch (e) {
      await UChatLoading.hide();
      UChatLoading.failed(message: 'Failed to toggle tracking');
      _log.e('Failed to toggle tracking', e);
    }
  }

  void togglePause() {
    isPaused.value = !isPaused.value;
  }

  void toggleAutoScroll() {
    autoScroll.value = !autoScroll.value;
  }

  void toggleErrorFilter() {
    showOnlyErrors.value = !showOnlyErrors.value;
    _applyFilters();
  }

  void toggleEventTypeFilter(String eventType) {
    if (selectedEventTypes.contains(eventType)) {
      selectedEventTypes.remove(eventType);
    } else {
      selectedEventTypes.add(eventType);
    }
    _applyFilters();
  }

  void clearSelectedFilters() {
    selectedEventTypes.clear();
    showOnlyErrors.value = false;
    searchQuery.value = '';
    _applyFilters();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void clearHistory() {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Clear Event History',
      description: 'This will clear all tracked event history. Are you sure?',
      onConfirm: () {
        eventBus.clearHistory();
        eventHistory.clear();
        filteredEvents.clear();
        UChatLoading.success(message: 'Event history cleared');
      },
    );
  }

  void exportAsJson() async {
    try {
      await UChatLoading.show(status: 'Exporting events...');

      final json = eventBus.exportHistoryAsJson();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final fileName = 'event_history_$timestamp.json';

      // Share the JSON file
      await Share.shareXFiles(
        [XFile.fromData(
          Uint8List.fromList(json.codeUnits),
          name: fileName,
          mimeType: 'application/json',
        )],
        subject: 'Event History Export',
      );

      await UChatLoading.hide();
    } catch (e) {
      await UChatLoading.hide();
      UChatLoading.failed(message: 'Export failed');
      _log.e('Failed to export events', e);
    }
  }

  void exportAsCsv() async {
    try {
      await UChatLoading.show(status: 'Exporting events...');

      final csv = eventBus.exportHistoryAsCsv();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final fileName = 'event_history_$timestamp.csv';

      // Share the CSV file
      await Share.shareXFiles(
        [XFile.fromData(
          Uint8List.fromList(csv.codeUnits),
          name: fileName,
          mimeType: 'text/csv',
        )],
        subject: 'Event History Export',
      );

      await UChatLoading.hide();
    } catch (e) {
      await UChatLoading.hide();
      UChatLoading.failed(message: 'Export failed');
      _log.e('Failed to export events', e);
    }
  }

  void copyEventDetails(TrackedEvent event) async {
    final details = '''
Event Type: ${event.eventType}
Status: ${event.status}
Timestamp: ${event.timestamp}
Duration: ${event.executionDuration?.inMicroseconds ?? 'N/A'} μs
Listeners: ${event.listenerCount ?? 'N/A'}
${event.error != null ? 'Error: ${event.error}' : ''}
Data: ${event.toMap()['eventData']}
''';

    await Clipboard.setData(ClipboardData(text: details));
    UChatLoading.success(message: 'Event details copied');
  }

  String getEventStatusIcon(EventStatus status) {
    switch (status) {
      case EventStatus.fired:
        return '🔵';
      case EventStatus.executed:
        return '🟢';
      case EventStatus.error:
        return '🔴';
    }
  }

  String formatDuration(Duration? duration) {
    if (duration == null) return 'N/A';

    final microseconds = duration.inMicroseconds;
    if (microseconds < 1000) {
      return '$microseconds μs';
    } else if (microseconds < 1000000) {
      return '${(microseconds / 1000).toStringAsFixed(2)} ms';
    } else {
      return '${(microseconds / 1000000).toStringAsFixed(2)} s';
    }
  }
}