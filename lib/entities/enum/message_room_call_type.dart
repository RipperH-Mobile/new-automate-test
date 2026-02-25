enum MessageRoomCallType {
  voice,
  video,
  unknown;

  String get value {
    switch (this) {
      case MessageRoomCallType.voice:
        return 'VOICE';
      case MessageRoomCallType.video:
        return 'VIDEO';
      default:
        return 'UNKNOWN';
    }
  }

  static MessageRoomCallType? from(String val) {
    switch (val) {
      case 'VOICE':
        return MessageRoomCallType.voice;
      case 'VIDEO':
        return MessageRoomCallType.video;
      default:
        return MessageRoomCallType.unknown;
    }
  }
}
