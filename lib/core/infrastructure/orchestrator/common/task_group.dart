import 'typedef.dart';

class OrchestratorTask {
  /// Task identifier.
  /// For performance, debug tracking, and analytics.
  ///
  /// Format: Kebab Case,
  /// Example: this-is-my-task
  final String id;

  /// The list of tasks to be executed
  final List<OrchestratorTaskFunction> tasks;

  /// Configuration for running tasks in parallel.
  final bool runParallel;

  /// Optional condition to check before executing the task.
  /// When returns true, the task will be executed
  final OrchestratorConditionFunction? condition;

  OrchestratorTask({required this.id, required this.tasks, this.runParallel = true, this.condition});

  @override
  String toString() {
    return 'OrchestratorTask{id: $id, tasks: $tasks, runParallel: $runParallel}';
  }
}
