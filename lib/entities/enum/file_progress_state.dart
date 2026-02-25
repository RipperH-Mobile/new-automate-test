enum FileProgressState {
  idle('idle'),
  compressing('compressing'),
  compressed('compressed'),
  uploading('uploading'),
  uploaded('uploaded'),
  uploadFailed('uploadFailed'),
  downloading('downloading'),
  downloaded('downloaded'),
  downloadFailed('downloadFailed');

  final String value;
  const FileProgressState(this.value);

  factory FileProgressState.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }
}
