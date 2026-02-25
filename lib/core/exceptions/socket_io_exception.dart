class SocketIOException implements Exception {
  final String message;

  SocketIOException([this.message = '']);

  @override
  String toString() {
    return 'SocketIoException: $message';
  }
}
