class ApiUnauthorizedException implements Exception {
  /// A message describing the format error.
  final String message;

  /// Creates a new ApiUnauthorizedException with an optional error [message].
  ApiUnauthorizedException([this.message = '']);

  @override
  String toString() => 'ApiUnauthorizedException: $message';
}
