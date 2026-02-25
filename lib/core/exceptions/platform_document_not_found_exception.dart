class PlatformDocumentNotFoundException implements Exception {
  final String message;

  PlatformDocumentNotFoundException([this.message = 'Platform document not found']);
}
