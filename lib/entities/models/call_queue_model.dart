class CallQueueModel {
  final Future<void> Function() task;
  final String label;

  CallQueueModel({
    required this.task,
    required this.label,
  });
}