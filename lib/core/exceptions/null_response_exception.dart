class NullResponseException implements Exception {
  final String message;

  NullResponseException([this.message = 'Null response']);
}
