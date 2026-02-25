enum TaskResult {
  // When return with this value, the orchestrator will stop all tasks and exit.
  stop,

  // When return with this value, the orchestrator will skip the current task and continue to the next group.
  skip,

  // When return with this value, the orchestrator will continue running the next tasks in the current group.
  next,
}