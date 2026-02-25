class SocketDisconnectedEvent {
  final String data;

  SocketDisconnectedEvent({required this.data});

  @override
  String toString() => 'SocketDisconnectedEvent(data: $data)';
}
