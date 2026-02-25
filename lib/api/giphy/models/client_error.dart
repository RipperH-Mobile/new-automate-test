class GiphyClientError {
  final int? statusCode;
  final String? statusMessage;
  final Exception? exception;

  GiphyClientError({this.statusCode, this.statusMessage, this.exception});

  @override
  String toString() {
    return 'GiphyClientError{statusCode: $statusCode, exception: $exception}';
  }
}
