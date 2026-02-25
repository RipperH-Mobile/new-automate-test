import 'package:uchat/core/exceptions/socket_io_exception.dart';

class SocketConnectionException implements SocketIOException {
  @override
  String message;

  SocketConnectionException([this.message = '']);

  @override
  String toString() {
    return 'SocketConnectionException: $message';
  }
}
