enum CallMethodType {
  video('VIDEO'),
  voice('VOICE');

  final String value;
  const CallMethodType(this.value);

  static bool isVideo(CallMethodType value) => value == video;
  static bool isVoice(CallMethodType value) => value == voice;

  factory CallMethodType.fromValue(String value) {
    switch (value) {
      case 'VIDEO':
        return CallMethodType.video;
      case 'VOICE':
        return CallMethodType.voice;
      default:
        throw Exception('Unknown CallMethodType value: $value');
    }
  }
}

extension CallMethodTypeExtension on CallMethodType {
  bool get isVideo => CallMethodType.isVideo(this);
  bool get isVoice => CallMethodType.isVoice(this);
}
