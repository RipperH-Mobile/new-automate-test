class UnsupportedFormatException implements Exception {
  final String message;

  UnsupportedFormatException({
    this.message = 'Unsupported format',
  });
}
