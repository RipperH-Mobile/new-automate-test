enum SocketErrorFrom {
  main,
}

class SocketErrorEvent {
  final SocketErrorFrom from;
  final dynamic data;

  SocketErrorEvent({
    required this.from,
    this.data,
  });

  @override
  String toString() => 'SocketErrorEvent(from: $from, data: $data)';
}
