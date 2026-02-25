import 'dart:async';
import 'package:async_queue/async_queue.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

/// Enum representing the current state of the message queue
enum MessageQueueState {
  /// No jobs in queue, no active processing
  idle,

  /// Jobs waiting in queue
  pending,

  /// Jobs currently being processed
  processing,

  /// Queue has been closed
  closed,
}

/// Extension methods for MessageQueueState
extension MessageQueueStateExtension on MessageQueueState {
  String get displayName {
    switch (this) {
      case MessageQueueState.idle:
        return 'Idle';
      case MessageQueueState.pending:
        return 'Pending';
      case MessageQueueState.processing:
        return 'Processing';
      case MessageQueueState.closed:
        return 'Closed';
    }
  }

  String toShortString() => toString().split('.').last;
}

/// Data model for queue metrics at a specific point in time
class MessageQueueMetrics {
  final DateTime timestamp;
  final int queueLength;
  final int activeJobCount;
  final int totalJobsProcessed;
  final int totalJobsFailed;
  final double averageProcessingTime;
  final MessageQueueState state;
  final String roomId;

  MessageQueueMetrics({
    required this.timestamp,
    required this.queueLength,
    required this.activeJobCount,
    required this.totalJobsProcessed,
    required this.totalJobsFailed,
    required this.averageProcessingTime,
    required this.state,
    required this.roomId,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'queueLength': queueLength,
    'activeJobCount': activeJobCount,
    'totalJobsProcessed': totalJobsProcessed,
    'totalJobsFailed': totalJobsFailed,
    'averageProcessingTime': averageProcessingTime,
    'state': state.toShortString(),
    'roomId': roomId,
  };
}

/// Data model for tracking individual queue jobs
class MessageQueueJobInfo {
  final String id;
  final String label;
  final DateTime startTime;
  final DateTime? endTime;
  final String roomId;
  final bool isSuccess;
  final String? errorMessage;

  MessageQueueJobInfo({
    required this.id,
    required this.label,
    required this.startTime,
    this.endTime,
    required this.roomId,
    this.isSuccess = true,
    this.errorMessage,
  });

  /// Calculate the processing duration in milliseconds
  int get processingDuration {
    if (endTime == null) {
      return DateTime.now().difference(startTime).inMilliseconds;
    }
    return endTime!.difference(startTime).inMilliseconds;
  }

  /// Check if the job is still running
  bool get isRunning => endTime == null;

  /// Check if the job is stuck (running for more than 2 minutes)
  bool get isStuck => isRunning && processingDuration > 120000;

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime?.toIso8601String(),
    'roomId': roomId,
    'isSuccess': isSuccess,
    'errorMessage': errorMessage,
    'processingDuration': processingDuration,
    'isRunning': isRunning,
    'isStuck': isStuck,
  };
}

/// Data model for queue performance summary
class MessageQueuePerformanceSummary {
  final double successRate;
  final double averageProcessingTime;
  final int totalProcessed;
  final int totalFailed;
  final int stuckJobs;
  final int slowJobs; // Jobs taking > 5 seconds
  final DateTime calculatedAt;

  MessageQueuePerformanceSummary({
    required this.successRate,
    required this.averageProcessingTime,
    required this.totalProcessed,
    required this.totalFailed,
    required this.stuckJobs,
    required this.slowJobs,
    required this.calculatedAt,
  });

  /// Check if the queue is healthy based on performance metrics
  bool get isHealthy {
    return successRate >= 0.95 &&
           averageProcessingTime < 3000 &&
           stuckJobs == 0;
  }

  Map<String, dynamic> toJson() => {
    'successRate': successRate,
    'averageProcessingTime': averageProcessingTime,
    'totalProcessed': totalProcessed,
    'totalFailed': totalFailed,
    'stuckJobs': stuckJobs,
    'slowJobs': slowJobs,
    'calculatedAt': calculatedAt.toIso8601String(),
    'isHealthy': isHealthy,
  };
}

/// Monitor class for tracking and analyzing message queue performance
class MessageAddingQueueMonitor {
  final AsyncQueue queue;
  final String roomId;
  final _log = useLogger();

  // State tracking
  MessageQueueState _currentState = MessageQueueState.idle;
  MessageQueueState get currentState => _currentState;

  // Job tracking
  final Map<String, MessageQueueJobInfo> _activeJobs = {};
  final List<MessageQueueJobInfo> _completedJobs = [];

  // Statistics
  int _totalJobsProcessed = 0;
  int _totalJobsFailed = 0;
  double _totalProcessingTime = 0;

  // Job ID counter for unique IDs
  int _jobIdCounter = 0;

  // Stream controllers
  final _stateStreamController = StreamController<MessageQueueState>.broadcast();
  final _metricsStreamController = StreamController<MessageQueueMetrics>.broadcast();

  // Streams
  Stream<MessageQueueState> get stateStream => _stateStreamController.stream;
  Stream<MessageQueueMetrics> get metricsStream => _metricsStreamController.stream;

  // Timers for periodic monitoring
  Timer? _metricsTimer;
  Timer? _stateCheckTimer;

  // Metrics history (keep last 100 entries)
  final List<MessageQueueMetrics> _metricsHistory = [];
  static const int _maxHistorySize = 100;

  MessageAddingQueueMonitor({
    required this.queue,
    required this.roomId,
  }) {
    _startMonitoring();
  }

  /// Start the monitoring timers and listeners
  void _startMonitoring() {
    // Check queue state every 100ms
    _stateCheckTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _updateQueueState();
    });

    // Collect metrics every 1 second
    _metricsTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _collectMetrics();
    });

    // Initial state update
    _updateQueueState();
  }

  /// Determine the current queue state based on queue status
  void _updateQueueState() {
    final newState = _determineQueueState();

    if (newState != _currentState) {
      _currentState = newState;
      _stateStreamController.add(newState);

      // Log state change
      _log.i('Queue Monitor [Room: $roomId]: State changed to ${newState.displayName}');
    }
  }

  /// Determine queue state based on current conditions
  MessageQueueState _determineQueueState() {
    if (_stateStreamController.isClosed) {
      return MessageQueueState.closed;
    }

    final hasActiveJobs = _activeJobs.isNotEmpty;

    if (hasActiveJobs) {
      return MessageQueueState.processing;
    } else {
      return MessageQueueState.idle;
    }
  }

  /// Collect current metrics and emit to stream
  void _collectMetrics() {
    final metrics = MessageQueueMetrics(
      timestamp: DateTime.now(),
      queueLength: 0, // AsyncQueue doesn't expose length, we track active jobs instead
      activeJobCount: _activeJobs.length,
      totalJobsProcessed: _totalJobsProcessed,
      totalJobsFailed: _totalJobsFailed,
      averageProcessingTime: _calculateAverageProcessingTime(),
      state: _currentState,
      roomId: roomId,
    );

    // Add to history
    _metricsHistory.add(metrics);
    if (_metricsHistory.length > _maxHistorySize) {
      _metricsHistory.removeAt(0);
    }

    // Emit metrics
    _metricsStreamController.add(metrics);

    // Check for performance issues
    _checkPerformanceIssues(metrics);
  }

  /// Calculate average processing time
  double _calculateAverageProcessingTime() {
    if (_totalJobsProcessed == 0) return 0;
    return _totalProcessingTime / _totalJobsProcessed;
  }

  /// Check for performance issues and log warnings
  void _checkPerformanceIssues(MessageQueueMetrics metrics) {
    // Check for stuck jobs
    final stuckJobs = _activeJobs.values.where((job) => job.isStuck).toList();
    if (stuckJobs.isNotEmpty) {
      _log.w('Queue Monitor [Room: $roomId]: WARNING - ${stuckJobs.length} stuck jobs detected');
    }

    // Check for slow processing
    if (metrics.averageProcessingTime > 5000) {
      _log.w('Queue Monitor [Room: $roomId]: WARNING - Slow processing detected (avg: ${metrics.averageProcessingTime.toStringAsFixed(0)}ms)');
    }

    // Check for high failure rate
    if (_totalJobsProcessed > 10) {
      final failureRate = _totalJobsFailed / _totalJobsProcessed;
      if (failureRate > 0.1) {
        _log.w('Queue Monitor [Room: $roomId]: WARNING - High failure rate detected (${(failureRate * 100).toStringAsFixed(1)}%)');
      }
    }
  }

  /// Track the start of a new job
  String trackJobStart(String label) {
    _jobIdCounter++;
    final jobId = 'job-${DateTime.now().millisecondsSinceEpoch}-$_jobIdCounter';
    final jobInfo = MessageQueueJobInfo(
      id: jobId,
      label: label,
      startTime: DateTime.now(),
      roomId: roomId,
    );

    _activeJobs[jobId] = jobInfo;

    _log.d('Queue Monitor [Room: $roomId]: Job started - $label (ID: $jobId)');

    return jobId;
  }

  /// Track the completion of a job
  void trackJobComplete(String jobId, {bool failed = false, String? errorMessage}) {
    final jobInfo = _activeJobs.remove(jobId);

    if (jobInfo == null) {
      _log.w('Queue Monitor [Room: $roomId]: WARNING - Attempted to complete unknown job: $jobId');
      return;
    }

    // Create completed job info
    final completedJob = MessageQueueJobInfo(
      id: jobInfo.id,
      label: jobInfo.label,
      startTime: jobInfo.startTime,
      endTime: DateTime.now(),
      roomId: roomId,
      isSuccess: !failed,
      errorMessage: errorMessage,
    );

    // Update statistics
    _totalJobsProcessed++;
    if (failed) {
      _totalJobsFailed++;
    }
    _totalProcessingTime += completedJob.processingDuration;

    // Store completed job
    _completedJobs.add(completedJob);

    // Keep only last 100 completed jobs
    if (_completedJobs.length > 100) {
      _completedJobs.removeAt(0);
    }

    _log.d('Queue Monitor [Room: $roomId]: Job completed - ${jobInfo.label} '
           '(Duration: ${completedJob.processingDuration}ms, Success: ${!failed})');
  }

  /// Get current performance summary
  MessageQueuePerformanceSummary getPerformanceSummary() {
    final successRate = _totalJobsProcessed > 0
        ? (_totalJobsProcessed - _totalJobsFailed) / _totalJobsProcessed
        : 1.0;

    final stuckJobs = _activeJobs.values.where((job) => job.isStuck).length;
    final slowJobs = _completedJobs.where((job) => job.processingDuration > 5000).length;

    return MessageQueuePerformanceSummary(
      successRate: successRate,
      averageProcessingTime: _calculateAverageProcessingTime(),
      totalProcessed: _totalJobsProcessed,
      totalFailed: _totalJobsFailed,
      stuckJobs: stuckJobs,
      slowJobs: slowJobs,
      calculatedAt: DateTime.now(),
    );
  }

  /// Get list of active jobs
  List<MessageQueueJobInfo> getActiveJobs() {
    return _activeJobs.values.toList();
  }

  /// Get list of completed jobs (most recent first)
  List<MessageQueueJobInfo> getCompletedJobs() {
    return _completedJobs.reversed.toList();
  }

  /// Get all jobs (active + completed, with active jobs first)
  List<MessageQueueJobInfo> getAllJobs() {
    final activeJobs = getActiveJobs();
    final completedJobs = getCompletedJobs();
    return [...activeJobs, ...completedJobs];
  }

  /// Get metrics history
  List<MessageQueueMetrics> getMetricsHistory() {
    return List.unmodifiable(_metricsHistory);
  }

  /// Debug method to print current queue state
  void debugQueueState() {
    final performance = getPerformanceSummary();
    final activeJobs = getActiveJobs();

    GetIt.I<LoggerService>().d('=== Queue Monitor Debug [Room: $roomId] ===');
    GetIt.I<LoggerService>().d('Current State: ${_currentState.displayName}');
    GetIt.I<LoggerService>().d('Active Jobs: ${activeJobs.length}');
    GetIt.I<LoggerService>().d('Total Processed: $_totalJobsProcessed');
    GetIt.I<LoggerService>().d('Total Failed: $_totalJobsFailed');
    GetIt.I<LoggerService>().d('Success Rate: ${(performance.successRate * 100).toStringAsFixed(1)}%');
    GetIt.I<LoggerService>().d('Avg Processing Time: ${performance.averageProcessingTime.toStringAsFixed(0)}ms');

    if (activeJobs.isNotEmpty) {
      GetIt.I<LoggerService>().d('\nActive Jobs:');
      for (final job in activeJobs) {
        final status = job.isStuck ? ' [STUCK]' : '';
        GetIt.I<LoggerService>().d('  - ${job.label} (${job.processingDuration}ms)$status');
      }
    }

    if (performance.stuckJobs > 0) {
      GetIt.I<LoggerService>().w('⚠️ WARNING: ${performance.stuckJobs} stuck jobs detected!');
    }

    if (!performance.isHealthy) {
      GetIt.I<LoggerService>().e('❌ Queue is UNHEALTHY');
    } else {
      GetIt.I<LoggerService>().d('✅ Queue is HEALTHY');
    }

    GetIt.I<LoggerService>().d('=====================================');
  }

  /// Dispose of the monitor and clean up resources
  void dispose() {
    // Cancel timers first
    _metricsTimer?.cancel();
    _stateCheckTimer?.cancel();

    // Update state
    _currentState = MessageQueueState.closed;

    // Add final state if controllers are not closed
    if (!_stateStreamController.isClosed) {
      _stateStreamController.add(MessageQueueState.closed);
    }

    // Close stream controllers
    _stateStreamController.close();
    _metricsStreamController.close();

    _log.i('Queue Monitor [Room: $roomId]: Monitor disposed');
  }
}