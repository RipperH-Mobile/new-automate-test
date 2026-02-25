import 'package:uchat/core/exceptions/socket_io_exception.dart';

class SocketUnknownException implements SocketIOException {
  /// A message describing the format error.
  @override
  final String message;

  /// Creates a new SocketUnknownException with an optional error [message].
  SocketUnknownException([this.message = '']);

  @override
  String toString() => 'SocketUnknownException: $message';
}
