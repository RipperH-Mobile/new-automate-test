class UChatLogMessage {
  final String message;
  final String? additionalMessage;
  final Map<String, dynamic>? additionalData;
  final Object? error;
  final StackTrace? stackTrace;

  UChatLogMessage({
    required this.message,
    this.additionalMessage,
    this.additionalData,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    return message;
  }
}
