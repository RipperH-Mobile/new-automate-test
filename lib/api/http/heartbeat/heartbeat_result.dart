class HeartbeatResult {
  final DateTime timestamp;
  final bool isSuccess;
  final int latencyMs;
  final dynamic error;

  HeartbeatResult({
    required this.timestamp,
    required this.isSuccess,
    required this.latencyMs,
    this.error,
  });
}
