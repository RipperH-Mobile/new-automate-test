enum CallExceptionType {
  permission,
  noLongerExists,
  processTimeout,
  liveKitServerError,
  tokenNull;
}

class UChatCallException implements Exception {
  final String message;
  final String? name;
  final CallExceptionType? type;

  UChatCallException({
    required this.message,
    this.name,
    this.type,
  });

  @override
  String toString() => 'UChatCallException: ($type): $name -> $message';
}