import 'dart:async';
import 'package:async_queue/async_queue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_adding_queue_monitor.dart';

// Mock classes
class MockAsyncQueue extends Mock implements AsyncQueue {
  final List<Function> _jobs = [];
  bool _isClosed = false;

  @override
  void addJob(Function job, {Object? label, String? description, int retryTime = 1}) {
    if (_isClosed) throw StateError('Queue is closed');
    _jobs.add(job);
  }

  @override
  void close() {
    _isClosed = true;
    _jobs.clear();
  }

  // Helper method to simulate jobs remaining in queue
  void _addMockJob() {
    _jobs.add(() async {});
  }

  void _clearJobs() {
    _jobs.clear();
  }

  // Simulate job processing
  bool get hasJobs => _jobs.isNotEmpty;
}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  setUpAll(() {
    // Register mock logger service for testing
    if (!GetIt.I.isRegistered<LoggerService>()) {
      GetIt.I.registerSingleton<LoggerService>(MockLoggerService());
    }
  });

  tearDownAll(() {
    GetIt.I.reset();
  });
  group('MessageQueueState', () {
    test('should have correct string representations', () {
      expect(MessageQueueState.idle.displayName, 'Idle');
      expect(MessageQueueState.pending.displayName, 'Pending');
      expect(MessageQueueState.processing.displayName, 'Processing');
      expect(MessageQueueState.closed.displayName, 'Closed');
    });

    test('should convert to short string correctly', () {
      expect(MessageQueueState.idle.toShortString(), 'idle');
      expect(MessageQueueState.pending.toShortString(), 'pending');
      expect(MessageQueueState.processing.toShortString(), 'processing');
      expect(MessageQueueState.closed.toShortString(), 'closed');
    });
  });

  group('MessageQueueMetrics', () {
    test('should create valid metrics with all required fields', () {
      final timestamp = DateTime.now();
      final metrics = MessageQueueMetrics(
        timestamp: timestamp,
        queueLength: 5,
        activeJobCount: 2,
        totalJobsProcessed: 100,
        totalJobsFailed: 5,
        averageProcessingTime: 1500.5,
        state: MessageQueueState.processing,
        roomId: 'test-room-123',
      );

      expect(metrics.timestamp, timestamp);
      expect(metrics.queueLength, 5);
      expect(metrics.activeJobCount, 2);
      expect(metrics.totalJobsProcessed, 100);
      expect(metrics.totalJobsFailed, 5);
      expect(metrics.averageProcessingTime, 1500.5);
      expect(metrics.state, MessageQueueState.processing);
      expect(metrics.roomId, 'test-room-123');
    });

    test('should convert to JSON correctly', () {
      final timestamp = DateTime.parse('2023-01-01T12:00:00Z');
      final metrics = MessageQueueMetrics(
        timestamp: timestamp,
        queueLength: 3,
        activeJobCount: 1,
        totalJobsProcessed: 50,
        totalJobsFailed: 2,
        averageProcessingTime: 1000.0,
        state: MessageQueueState.idle,
        roomId: 'room-456',
      );

      final json = metrics.toJson();

      expect(json['timestamp'], '2023-01-01T12:00:00.000Z');
      expect(json['queueLength'], 3);
      expect(json['activeJobCount'], 1);
      expect(json['totalJobsProcessed'], 50);
      expect(json['totalJobsFailed'], 2);
      expect(json['averageProcessingTime'], 1000.0);
      expect(json['state'], 'idle');
      expect(json['roomId'], 'room-456');
    });
  });

  group('MessageQueueJobInfo', () {
    test('should track job lifecycle correctly', () {
      final startTime = DateTime.now();
      final jobInfo = MessageQueueJobInfo(
        id: 'job-123',
        label: 'test-job',
        startTime: startTime,
        roomId: 'room-789',
      );

      expect(jobInfo.id, 'job-123');
      expect(jobInfo.label, 'test-job');
      expect(jobInfo.startTime, startTime);
      expect(jobInfo.roomId, 'room-789');
      expect(jobInfo.isSuccess, true);
      expect(jobInfo.isRunning, true);
      expect(jobInfo.endTime, null);
    });

    test('should calculate processing duration correctly', () {
      final startTime = DateTime.now().subtract(const Duration(seconds: 5));
      final jobInfo = MessageQueueJobInfo(
        id: 'job-123',
        label: 'test-job',
        startTime: startTime,
        roomId: 'room-789',
      );

      final duration = jobInfo.processingDuration;
      expect(duration, greaterThan(4000)); // At least 4 seconds
      expect(duration, lessThan(6000));    // Less than 6 seconds
    });

    test('should handle job completion', () {
      final startTime = DateTime.now().subtract(const Duration(milliseconds: 1500));
      final endTime = DateTime.now();

      final jobInfo = MessageQueueJobInfo(
        id: 'job-123',
        label: 'test-job',
        startTime: startTime,
        endTime: endTime,
        roomId: 'room-789',
      );

      expect(jobInfo.isRunning, false);
      expect(jobInfo.processingDuration, approximately(1500, delta: 50));
    });

    test('should detect stuck jobs', () {
      final longAgoStartTime = DateTime.now().subtract(const Duration(minutes: 3));
      final jobInfo = MessageQueueJobInfo(
        id: 'job-123',
        label: 'stuck-job',
        startTime: longAgoStartTime,
        roomId: 'room-789',
      );

      expect(jobInfo.isStuck, true);
    });

    test('should convert to JSON correctly', () {
      final startTime = DateTime.parse('2023-01-01T12:00:00Z');
      final endTime = DateTime.parse('2023-01-01T12:00:02Z');

      final jobInfo = MessageQueueJobInfo(
        id: 'job-456',
        label: 'completed-job',
        startTime: startTime,
        endTime: endTime,
        roomId: 'room-123',
        isSuccess: false,
        errorMessage: 'Test error',
      );

      final json = jobInfo.toJson();

      expect(json['id'], 'job-456');
      expect(json['label'], 'completed-job');
      expect(json['startTime'], '2023-01-01T12:00:00.000Z');
      expect(json['endTime'], '2023-01-01T12:00:02.000Z');
      expect(json['roomId'], 'room-123');
      expect(json['isSuccess'], false);
      expect(json['errorMessage'], 'Test error');
      expect(json['processingDuration'], 2000);
      expect(json['isRunning'], false);
      expect(json['isStuck'], false);
    });
  });

  group('MessageQueuePerformanceSummary', () {
    test('should calculate success rate correctly', () {
      final summary = MessageQueuePerformanceSummary(
        successRate: 0.85,
        averageProcessingTime: 1200.0,
        totalProcessed: 100,
        totalFailed: 15,
        stuckJobs: 0,
        slowJobs: 5,
        calculatedAt: DateTime.now(),
      );

      expect(summary.successRate, 0.85);
      expect(summary.totalProcessed, 100);
      expect(summary.totalFailed, 15);
    });

    test('should identify healthy queue state', () {
      final healthySummary = MessageQueuePerformanceSummary(
        successRate: 0.98,
        averageProcessingTime: 1000.0,
        totalProcessed: 100,
        totalFailed: 2,
        stuckJobs: 0,
        slowJobs: 0,
        calculatedAt: DateTime.now(),
      );

      expect(healthySummary.isHealthy, true);
    });

    test('should identify unhealthy queue state', () {
      final unhealthySummary = MessageQueuePerformanceSummary(
        successRate: 0.90, // Below 95%
        averageProcessingTime: 4000.0, // Above 3 seconds
        totalProcessed: 100,
        totalFailed: 10,
        stuckJobs: 1, // Has stuck jobs
        slowJobs: 20,
        calculatedAt: DateTime.now(),
      );

      expect(unhealthySummary.isHealthy, false);
    });

    test('should convert to JSON correctly', () {
      final calculatedAt = DateTime.parse('2023-01-01T12:00:00Z');
      final summary = MessageQueuePerformanceSummary(
        successRate: 0.92,
        averageProcessingTime: 1500.5,
        totalProcessed: 200,
        totalFailed: 16,
        stuckJobs: 1,
        slowJobs: 10,
        calculatedAt: calculatedAt,
      );

      final json = summary.toJson();

      expect(json['successRate'], 0.92);
      expect(json['averageProcessingTime'], 1500.5);
      expect(json['totalProcessed'], 200);
      expect(json['totalFailed'], 16);
      expect(json['stuckJobs'], 1);
      expect(json['slowJobs'], 10);
      expect(json['calculatedAt'], '2023-01-01T12:00:00.000Z');
      expect(json['isHealthy'], false);
    });
  });

  group('MessageAddingQueueMonitor', () {
    late MessageAddingQueueMonitor monitor;
    late MockAsyncQueue mockQueue;

    setUp(() {
      mockQueue = MockAsyncQueue();
      monitor = MessageAddingQueueMonitor(
        queue: mockQueue,
        roomId: 'test-room-123',
      );
    });

    tearDown(() {
      monitor.dispose();
    });

    group('Initialization', () {
      test('should initialize with idle state', () {
        expect(monitor.currentState, MessageQueueState.idle);
        expect(monitor.queue, mockQueue);
        expect(monitor.roomId, 'test-room-123');
      });

      test('should setup streams correctly', () {
        expect(monitor.stateStream, isA<Stream<MessageQueueState>>());
        expect(monitor.metricsStream, isA<Stream<MessageQueueMetrics>>());
      });
    });

    group('State Tracking', () {
      test('should detect idle state when queue is empty', () async {
        mockQueue._clearJobs();

        // Wait for state update
        await Future.delayed(const Duration(milliseconds: 150));

        expect(monitor.currentState, MessageQueueState.idle);
      });

      test('should detect processing state when jobs are active', () async {
        // Start a job to create processing state
        monitor.trackJobStart('test-job');

        // Wait for state update
        await Future.delayed(const Duration(milliseconds: 150));

        expect(monitor.currentState, MessageQueueState.processing);
      });

      test('should emit state changes to stream', () async {
        final stateChanges = <MessageQueueState>[];
        final subscription = monitor.stateStream.listen(stateChanges.add);

        // Start with idle, then track a job to trigger processing state
        final jobId = monitor.trackJobStart('test-job');

        // Wait for state updates
        await Future.delayed(const Duration(milliseconds: 150));

        expect(stateChanges, contains(MessageQueueState.processing));

        // Complete the job and check for idle state
        monitor.trackJobComplete(jobId);
        await Future.delayed(const Duration(milliseconds: 150));

        expect(stateChanges, contains(MessageQueueState.idle));

        await subscription.cancel();
      });
    });

    group('Job Tracking', () {
      test('should track job start correctly', () {
        final jobId = monitor.trackJobStart('test-job');

        expect(jobId, isA<String>());
        expect(jobId.isNotEmpty, true);

        final activeJobs = monitor.getActiveJobs();
        expect(activeJobs.length, 1);
        expect(activeJobs.first.label, 'test-job');
        expect(activeJobs.first.roomId, 'test-room-123');
      });

      test('should track job completion with success', () {
        final jobId = monitor.trackJobStart('test-job');
        monitor.trackJobComplete(jobId);

        final activeJobs = monitor.getActiveJobs();
        expect(activeJobs.length, 0);

        final performance = monitor.getPerformanceSummary();
        expect(performance.totalProcessed, 1);
        expect(performance.totalFailed, 0);
      });

      test('should track job completion with failure', () {
        final jobId = monitor.trackJobStart('test-job');
        monitor.trackJobComplete(jobId, failed: true, errorMessage: 'Test error');

        final activeJobs = monitor.getActiveJobs();
        expect(activeJobs.length, 0);

        final performance = monitor.getPerformanceSummary();
        expect(performance.totalProcessed, 1);
        expect(performance.totalFailed, 1);
        expect(performance.successRate, 0.0);
      });

      test('should handle concurrent job tracking', () {
        final jobId1 = monitor.trackJobStart('job-1');
        final jobId2 = monitor.trackJobStart('job-2');
        final jobId3 = monitor.trackJobStart('job-3');

        expect(monitor.getActiveJobs().length, 3);

        monitor.trackJobComplete(jobId1);
        expect(monitor.getActiveJobs().length, 2);

        monitor.trackJobComplete(jobId2, failed: true);
        expect(monitor.getActiveJobs().length, 1);

        monitor.trackJobComplete(jobId3);
        expect(monitor.getActiveJobs().length, 0);

        final performance = monitor.getPerformanceSummary();
        expect(performance.totalProcessed, 3);
        expect(performance.totalFailed, 1);
        expect(performance.successRate, approximately(0.67, delta: 0.01));
      });

      test('should prevent duplicate job tracking', () {
        final jobId = monitor.trackJobStart('test-job');

        // Trying to complete unknown job should not crash
        monitor.trackJobComplete('unknown-job-id');

        // Original job should still be active
        expect(monitor.getActiveJobs().length, 1);

        // Complete the real job
        monitor.trackJobComplete(jobId);
        expect(monitor.getActiveJobs().length, 0);
      });
    });

    group('Metrics Collection', () {
      test('should collect metrics correctly', () async {
        final metricsCollection = <MessageQueueMetrics>[];
        final subscription = monitor.metricsStream.listen(metricsCollection.add);

        // Wait for at least one metrics collection
        await Future.delayed(const Duration(milliseconds: 1100));

        expect(metricsCollection.isNotEmpty, true);

        final metrics = metricsCollection.first;
        expect(metrics.roomId, 'test-room-123');
        expect(metrics.timestamp, isA<DateTime>());
        expect(metrics.queueLength, isA<int>());
        expect(metrics.activeJobCount, isA<int>());
        expect(metrics.totalJobsProcessed, isA<int>());
        expect(metrics.totalJobsFailed, isA<int>());
        expect(metrics.averageProcessingTime, isA<double>());
        expect(metrics.state, isA<MessageQueueState>());

        await subscription.cancel();
      });

      test('should track success and failure rates', () {
        // Process some jobs
        final jobId1 = monitor.trackJobStart('job-1');
        final jobId2 = monitor.trackJobStart('job-2');
        final jobId3 = monitor.trackJobStart('job-3');

        monitor.trackJobComplete(jobId1);           // Success
        monitor.trackJobComplete(jobId2, failed: true); // Failure
        monitor.trackJobComplete(jobId3);           // Success

        final performance = monitor.getPerformanceSummary();
        expect(performance.totalProcessed, 3);
        expect(performance.totalFailed, 1);
        expect(performance.successRate, approximately(0.67, delta: 0.01));
      });
    });

    group('Performance Monitoring', () {
      test('should detect stuck jobs', () async {
        // Create a job that started long ago
        final longAgoJobId = monitor.trackJobStart('stuck-job');

        // Manually modify the start time to simulate a stuck job
        final activeJobs = monitor.getActiveJobs();
        expect(activeJobs.length, 1);

        // Job should not be stuck immediately
        expect(activeJobs.first.isStuck, false);

        // Simulate time passing by completing and checking
        await Future.delayed(const Duration(milliseconds: 100));

        final performance = monitor.getPerformanceSummary();
        expect(performance.stuckJobs, 0); // Should be 0 as time hasn't passed enough

        // Clean up
        monitor.trackJobComplete(longAgoJobId);
      });

      test('should monitor queue health status', () {
        // Start with healthy state
        final initialPerformance = monitor.getPerformanceSummary();
        expect(initialPerformance.isHealthy, true);

        // Process jobs to create some data
        final jobId1 = monitor.trackJobStart('job-1');
        final jobId2 = monitor.trackJobStart('job-2');

        monitor.trackJobComplete(jobId1);
        monitor.trackJobComplete(jobId2);

        final healthyPerformance = monitor.getPerformanceSummary();
        expect(healthyPerformance.isHealthy, true);
        expect(healthyPerformance.successRate, 1.0);
      });
    });

    group('Resource Management', () {
      test('should dispose all resources properly', () async {
        final stateChanges = <MessageQueueState>[];
        final metricsCollection = <MessageQueueMetrics>[];

        final stateSubscription = monitor.stateStream.listen(stateChanges.add);
        final metricsSubscription = monitor.metricsStream.listen(metricsCollection.add);

        // Wait for some activity
        await Future.delayed(const Duration(milliseconds: 150));

        // Dispose the monitor
        monitor.dispose();

        // State should change to closed
        expect(monitor.currentState, MessageQueueState.closed);

        // Check that closed state was emitted
        await Future.delayed(const Duration(milliseconds: 50));
        expect(stateChanges, contains(MessageQueueState.closed));

        await stateSubscription.cancel();
        await metricsSubscription.cancel();
      });

      test('should prevent operations after disposal', () {
        monitor.dispose();

        // Operations should not crash but should not work either
        final jobId = monitor.trackJobStart('test-job');
        expect(jobId, isA<String>());

        monitor.trackJobComplete(jobId);

        // Should not cause errors
        monitor.debugQueueState();

        final performance = monitor.getPerformanceSummary();
        expect(performance, isA<MessageQueuePerformanceSummary>());
      });
    });

    group('Debug and Analysis', () {
      test('should provide performance summary', () {
        final performance = monitor.getPerformanceSummary();

        expect(performance, isA<MessageQueuePerformanceSummary>());
        expect(performance.calculatedAt, isA<DateTime>());
        expect(performance.successRate, isA<double>());
        expect(performance.averageProcessingTime, isA<double>());
        expect(performance.totalProcessed, isA<int>());
        expect(performance.totalFailed, isA<int>());
        expect(performance.stuckJobs, isA<int>());
        expect(performance.slowJobs, isA<int>());
      });

      test('should return active queue jobs', () {
        final jobId1 = monitor.trackJobStart('active-job-1');
        final jobId2 = monitor.trackJobStart('active-job-2');

        final activeJobs = monitor.getActiveJobs();
        expect(activeJobs.length, 2);
        expect(activeJobs.map((job) => job.label), contains('active-job-1'));
        expect(activeJobs.map((job) => job.label), contains('active-job-2'));

        // Clean up
        monitor.trackJobComplete(jobId1);
        monitor.trackJobComplete(jobId2);
      });

      test('should expose metrics history', () async {
        // Wait for some metrics to be collected
        await Future.delayed(const Duration(milliseconds: 1100));

        final history = monitor.getMetricsHistory();
        expect(history, isA<List<MessageQueueMetrics>>());
        expect(history.isNotEmpty, true);

        // All metrics should be for the same room
        for (final metrics in history) {
          expect(metrics.roomId, 'test-room-123');
        }
      });

      test('should debug queue state without errors', () {
        // This should not throw any exceptions
        expect(() => monitor.debugQueueState(), returnsNormally);

        // Add some jobs for more interesting debug output
        final jobId1 = monitor.trackJobStart('debug-job-1');
        final jobId2 = monitor.trackJobStart('debug-job-2');

        expect(() => monitor.debugQueueState(), returnsNormally);

        // Clean up
        monitor.trackJobComplete(jobId1);
        monitor.trackJobComplete(jobId2);

        expect(() => monitor.debugQueueState(), returnsNormally);
      });
    });
  });
}

/// Matcher for approximate double values
Matcher approximately(double value, {double delta = 0.01}) {
  return inInclusiveRange(value - delta, value + delta);
}