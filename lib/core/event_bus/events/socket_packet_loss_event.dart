// Define packet loss severity levels
enum SocketPacketLossSeverity {
  normal,
  high,
  highLatency,
  critical,
}

// Create an event class for packet loss notifications
class SocketPacketLossEvent {
  final double rate;
  final SocketPacketLossSeverity severity;
  final int latency;

  SocketPacketLossEvent({
    required this.rate,
    required this.severity,
    required this.latency,
  });

  @override
  String toString() => 'SocketPacketLossEvent(rate: $rate, severity: $severity, latency: $latency)';
}
