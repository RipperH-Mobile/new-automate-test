import 'package:flutter/material.dart';
import 'package:uchat/core/infrastructure/orchestrator/common/task_result.dart';

import '../analytics/logger_service.dart';
import '../analytics/metric/performance_trace.dart';
import '../analytics/performance_service.dart';
import 'common/task_group.dart';
import 'config.dart';

part 'orchestrator_type.dart';

class Orchestrator {
  ///
  /// For run task by enum [OrchestratorTaskType]
  /// Task will place in the app like a hook.
  ///
  static Future<void> run(
    OrchestratorTaskType task, {
    bool stopOnError = false,
  }) async {
    final groups = tasks[task];
    if (groups == null) {
      if (task != OrchestratorTaskType.initializeApp) {
        useLogger().d('No tasks found for $task');
      } else {
        debugPrint('No tasks found for $task');
      }
      return;
    }

    for (final group in groups) {
      PerformanceTrace? customTrace;
      if (task != OrchestratorTaskType.initializeApp) {
        useLogger().d('Running group: ${group.id} (${group.tasks.length} tasks)');

        customTrace = usePerformance().create('orchestrator-${group.id}');
        await customTrace.start();
      } else {
        debugPrint('Running group: ${group.id} (${group.tasks.length} tasks)');
      }

      try {
        final result = await _runGroup(group: group, stopOnError: stopOnError);

        if (result == TaskResult.stop) {
          useLogger().d('Stopping orchestrator due to group result: stop (${group.id})');
          return;
        }
      } catch (e, stackTrace) {
        if (task != OrchestratorTaskType.initializeApp) {
          useLogger().e('Error running group: ${group.id}', e, stackTrace);
        } else {
          debugPrintStack(
            label: 'Error running group: ${group.id} (e: $e)',
            stackTrace: stackTrace,
          );
        }

        if (stopOnError) {
          rethrow;
        }
      } finally {
        await customTrace?.stop();
      }

      if (task != OrchestratorTaskType.initializeApp) {
        useLogger().d('Running group: ${group.id} -> done');
      } else {
        debugPrint('Running group: ${group.id} -> done');
      }
    }
  }

  ///
  /// A helper function to run a group of tasks.
  /// For easy to run a group of tasks in parallel.
  ///
  static Future<TaskResult> _runGroup({required OrchestratorTask group, stopOnError = false}) async {
    // First check group execute condition.
    if (group.condition != null) {
      final condition = await group.condition!();
      if (!condition) {
        useLogger().d('Skip group: ${group.id} because condition is false');
        return TaskResult.next;
      }
    }

    // When group run in parallel, run all tasks in parallel.
    if (group.runParallel) {
      final futures = <Future<TaskResult>>[];
      for (final t in group.tasks) {
        futures.add(Future.sync(t));
      }

      final runedTasks = await Future.wait(futures, eagerError: stopOnError);
      int index = 0;
      for (final t in runedTasks) {
        if (t is Exception) {
          useLogger().e('Error running task index: $index', t);
        }

        index++;
      }

      if (runedTasks.any((result) => result == TaskResult.stop)) {
        useLogger().d('Stopping orchestrator due to task result: stop (${group.id} => $index)');
        return TaskResult.stop;
      }

      return TaskResult.next;
    }

    // When group run in sequence, run all tasks in sequence.
    int index = 0;
    for (final t in group.tasks) {
      try {
        final result = await Future.sync(t);
        if (result == TaskResult.skip) {
          continue;
        }

        if (result == TaskResult.stop) {
          useLogger().d('Stopping orchestrator due to task result: $result (${group.id})');
          return TaskResult.stop;
        }
      } catch (e, stackTrace) {
        if (stopOnError) {
          rethrow;
        } else {
          useLogger().e('Error running task index: $index', e, stackTrace);
        }
      }

      index++;
    }

    return TaskResult.next;
  }
}
