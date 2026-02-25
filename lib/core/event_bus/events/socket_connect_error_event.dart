class SocketConnectErrorEvent {
  Exception error;

  SocketConnectErrorEvent({required this.error});

  @override
  String toString() => 'SocketConnectErrorEvent(error: $error)';
}
