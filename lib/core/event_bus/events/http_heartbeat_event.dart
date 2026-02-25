///
/// Event for notifying about heartbeat results
///
class HttpHeartbeatEvent {
  final double successRate;
  final int averageLatency;

  HttpHeartbeatEvent({
    required this.successRate,
    required this.averageLatency,
  });

  @override
  String toString() => 'HttpHeartbeatEvent(successRate: $successRate, averageLatency: $averageLatency)';
}
