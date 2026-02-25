import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_adding_queue_monitor.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';

/// Controller for Queue Monitor Dashboard Screen
class QueueMonitorDashboardController extends GetxController {
  final String roomId;
  final String controllerTag;
  final String roomName;

  QueueMonitorDashboardController({
    required this.roomId,
    required this.controllerTag,
    required this.roomName,
  });

  // Observable states
  final currentState = MessageQueueState.idle.obs;
  final queueMetrics = Rx<MessageQueueMetrics?>(null);
  final jobsList = <MessageQueueJobInfo>[].obs;
  final metricsHistory = <MessageQueueMetrics>[].obs;

  // UI controls
  final isPaused = false.obs;
  final autoScroll = true.obs;
  final selectedFilter = 'all'.obs; // all, active, completed, failed
  final searchQuery = ''.obs;
  final isLoading = false.obs;

  // Filtered jobs list
  List<MessageQueueJobInfo> get filteredJobs {
    var jobs = jobsList.toList();
    // final originalCount = jobs.length;

    // Apply filter
    switch (selectedFilter.value) {
      case 'active':
        jobs = jobs.where((job) => job.isRunning).toList();
        break;
      case 'completed':
        jobs = jobs.where((job) => !job.isRunning && job.isSuccess).toList();
        break;
      case 'failed':
        jobs = jobs.where((job) => !job.isRunning && !job.isSuccess).toList();
        break;
    }

    // Debug logging
    // GetIt.I<LoggerService>().d('Jobs Filter Debug - Original: $originalCount, Filter: ${selectedFilter.value}, Filtered: ${jobs.length}');

    // Apply search
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      jobs =
          jobs.where((job) => job.label.toLowerCase().contains(query) || job.id.toLowerCase().contains(query)).toList();
    }

    // Sort by start time (newest first)
    jobs.sort((a, b) => b.startTime.compareTo(a.startTime));

    return jobs;
  }

  // Performance summary
  final performanceSummary = Rx<MessageQueuePerformanceSummary?>(null);

  // Stream subscriptions
  StreamSubscription<MessageQueueState>? _stateSubscription;
  StreamSubscription<MessageQueueMetrics>? _metricsSubscription;
  Timer? _refreshTimer;

  // References
  MessageListController? _messageListController;
  MessageAddingQueueMonitor? _monitor;

  @override
  void onInit() {
    super.onInit();
    _initializeMonitor();
    _startRefreshTimer();
  }

  @override
  void onClose() {
    _stateSubscription?.cancel();
    _metricsSubscription?.cancel();
    _refreshTimer?.cancel();
    super.onClose();
  }

  /// Initialize connection to the queue monitor
  void _initializeMonitor() {
    try {
      // Get the message list controller
      _messageListController = Get.find<MessageListController>(tag: controllerTag);
      _monitor = _messageListController?.queueMonitor;

      if (_monitor == null) {
        Get.snackbar(
          'Error',
          'Queue monitor not available',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Subscribe to state changes
      _stateSubscription = _monitor!.stateStream.listen((state) {
        if (!isPaused.value) {
          currentState.value = state;
        }
      });

      // Subscribe to metrics updates
      _metricsSubscription = _monitor!.metricsStream.listen((metrics) {
        if (!isPaused.value) {
          queueMetrics.value = metrics;
          metricsHistory.add(metrics);

          // Keep only last 100 metrics
          if (metricsHistory.length > 100) {
            metricsHistory.removeAt(0);
          }
        }
      });

      // Initial data load
      _refreshData();
    } catch (e) {
      GetIt.I<LoggerService>().e('Error initializing queue monitor dashboard: $e');
    }
  }

  /// Start periodic refresh timer
  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused.value) {
        _refreshData();
      }
    });
  }

  /// Refresh all data from monitor
  void _refreshData() {
    if (_monitor == null) return;

    // Update performance summary
    performanceSummary.value = _monitor!.getPerformanceSummary();

    // Update jobs list (active + completed)
    // final activeJobs = _monitor!.getActiveJobs();
    // final completedJobs = _monitor!.getCompletedJobs();

    // Debug logging
    // GetIt.I<LoggerService>().d(
    //     'Queue Monitor Debug - Active: ${activeJobs.length}, Completed: ${completedJobs.length}, Total: ${allJobs.length}');

    jobsList.value = _monitor!.getAllJobs();

    // Limit job history to prevent memory issues
    if (jobsList.length > 200) {
      jobsList.value = jobsList.take(200).toList();
    }

    // Update metrics history if available
    final history = _monitor!.getMetricsHistory();
    if (history.isNotEmpty && metricsHistory.isEmpty) {
      metricsHistory.addAll(history);
    }
  }

  /// Toggle pause/resume monitoring
  void togglePause() {
    isPaused.value = !isPaused.value;

    if (!isPaused.value) {
      _refreshData();
    }

    Get.snackbar(
      isPaused.value ? 'Paused' : 'Resumed',
      isPaused.value ? 'Monitoring paused' : 'Monitoring resumed',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  /// Toggle auto-scroll
  void toggleAutoScroll() {
    autoScroll.value = !autoScroll.value;
  }

  /// Apply filter to jobs list
  void applyFilter(String filter) {
    selectedFilter.value = filter;
  }

  /// Search jobs
  void searchJobs(String query) {
    searchQuery.value = query;
  }

  /// Debug method to log current jobs state
  void debugJobsState() {
    if (_monitor == null) return;

    final activeJobs = _monitor!.getActiveJobs();
    final completedJobs = _monitor!.getCompletedJobs();
    final allJobs = _monitor!.getAllJobs();
    final performance = _monitor!.getPerformanceSummary();

    GetIt.I<LoggerService>().d('=== Queue Monitor Dashboard Debug ===');
    GetIt.I<LoggerService>().d('Room: $roomId');
    GetIt.I<LoggerService>().d('Active Jobs: ${activeJobs.length}');
    GetIt.I<LoggerService>().d('Completed Jobs: ${completedJobs.length}');
    GetIt.I<LoggerService>().d('Total Jobs in List: ${jobsList.length}');
    GetIt.I<LoggerService>()
        .d('Performance - Processed: ${performance.totalProcessed}, Failed: ${performance.totalFailed}');

    if (completedJobs.isNotEmpty) {
      GetIt.I<LoggerService>().d(
          'Sample Completed Job: ${completedJobs.first.label} - Success: ${completedJobs.first.isSuccess}, Running: ${completedJobs.first.isRunning}');
    }

    GetIt.I<LoggerService>().d('Current Filter: ${selectedFilter.value}');
    GetIt.I<LoggerService>().d('Filtered Jobs Count: ${filteredJobs.length}');
    GetIt.I<LoggerService>().d('======================================');
  }

  /// Clear all data
  void clearHistory() {
    Get.defaultDialog(
      title: 'Clear History',
      middleText: 'Are you sure you want to clear all monitoring history?',
      onConfirm: () {
        jobsList.clear();
        metricsHistory.clear();
        Get.back();
        Get.snackbar(
          'Cleared',
          'Monitoring history cleared',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onCancel: () {},
    );
  }

  /// Export data to JSON
  Future<void> exportToJson() async {
    try {
      isLoading.value = true;

      final exportData = {
        'roomId': roomId,
        'roomName': roomName,
        'exportedAt': DateTime.now().toIso8601String(),
        'currentState': currentState.value.toShortString(),
        'performanceSummary': performanceSummary.value?.toJson(),
        'recentJobs': jobsList.take(50).map((job) => job.toJson()).toList(),
        'metricsHistory': metricsHistory.map((m) => m.toJson()).toList(),
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);

      // Save to temporary file
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/queue_monitor_$timestamp.json');
      await file.writeAsString(jsonString);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Queue Monitor Export - $roomName',
        text: 'Queue monitor data exported at ${DateTime.now()}',
      );

      Get.snackbar(
        'Exported',
        'Data exported successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Export Failed',
        'Failed to export data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Export data to CSV
  Future<void> exportToCsv() async {
    try {
      isLoading.value = true;

      // Create CSV header
      final csv = StringBuffer();
      csv.writeln('Timestamp,Job ID,Label,Duration (ms),Success,Room ID');

      // Add job data
      for (final job in jobsList) {
        csv.writeln(
          '${job.startTime.toIso8601String()},'
          '${job.id},'
          '${job.label},'
          '${job.processingDuration},'
          '${job.isSuccess},'
          '${job.roomId}',
        );
      }

      // Save to temporary file
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/queue_monitor_$timestamp.csv');
      await file.writeAsString(csv.toString());

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Queue Monitor Export (CSV) - $roomName',
        text: 'Queue monitor data exported at ${DateTime.now()}',
      );

      Get.snackbar(
        'Exported',
        'CSV exported successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Export Failed',
        'Failed to export CSV: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get state color for UI
  Color getStateColor(MessageQueueState state) {
    switch (state) {
      case MessageQueueState.idle:
        return Colors.grey;
      case MessageQueueState.processing:
        return Colors.blue;
      case MessageQueueState.closed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Get health status color
  Color getHealthColor() {
    final summary = performanceSummary.value;
    if (summary == null) return Colors.grey;

    if (summary.isHealthy) {
      return Colors.green;
    } else if (summary.successRate < 0.8 || summary.stuckJobs > 0) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  /// Format duration for display
  String formatDuration(int milliseconds) {
    if (milliseconds < 1000) {
      return '${milliseconds}ms';
    } else if (milliseconds < 60000) {
      return '${(milliseconds / 1000).toStringAsFixed(1)}s';
    } else {
      return '${(milliseconds / 60000).toStringAsFixed(1)}m';
    }
  }
}

/// Arguments for navigating to the dashboard
class QueueMonitorArguments {
  final String roomId;
  final String roomName;
  final String controllerTag;

  QueueMonitorArguments({
    required this.roomId,
    required this.roomName,
    required this.controllerTag,
  });
}
