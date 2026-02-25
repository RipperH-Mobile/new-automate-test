import 'dart:async';

import '../orchestrator.dart';
import 'task_group.dart';
import 'task_result.dart';

typedef OrchestratorTaskFunction = FutureOr<TaskResult> Function();

typedef OrchestratorConditionFunction = FutureOr<bool> Function();

typedef OrchestratorTasks = Map<OrchestratorTaskType, List<OrchestratorTask>>;
