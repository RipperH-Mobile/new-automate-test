class FailedHostLookupException implements Exception {
  /// A message describing the format error.
  final String message;
  final String address;

  /// Creates a new SocketUnknownException with an optional error [message].
  FailedHostLookupException({
    this.message = '',
    this.address = '',
  });

  @override
  String toString() => 'FailedHostLookupException: $message ($address)';
}
