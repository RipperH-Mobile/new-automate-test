class SocketConnectingEvent {
  final bool isReconnect;

  SocketConnectingEvent({this.isReconnect = false});

  @override
  String toString() => 'SocketConnectingEvent(isReconnect: $isReconnect)';
}
