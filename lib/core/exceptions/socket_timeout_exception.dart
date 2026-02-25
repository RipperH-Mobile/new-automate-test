import 'package:uchat/core/exceptions/socket_io_exception.dart';

class SocketTimeoutException implements SocketIOException {
  /// A message describing the format error.
  @override
  final String message;

  /// Creates a new SocketTimeoutException with an optional error [message].
  SocketTimeoutException([this.message = '']);

  @override
  String toString() => 'SocketTimeoutException: $message';
}
