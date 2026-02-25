enum UiCallState {
  outgoing,
  incoming,
  voice,
  video,
  group,
  ringing,
}

enum CallType {
  video,
  voice;

  String get value {
    switch (this) {
      case CallType.video:
        return 'VIDEO';
      case CallType.voice:
        return 'VOICE';
    }
  }

  static CallType fromString(String? value) {
    switch (value) {
      case 'VIDEO':
        return CallType.video;
      case 'VOICE':
        return CallType.voice;
      default:
        return CallType.voice;
    }
  }
}

enum CallState {
  idle,
  connecting,
  connected,
  disconnecting,
  disconnected,
  paused;

  String get value {
    switch (this) {
      case CallState.idle:
        return 'idle';
      case CallState.connecting:
        return 'connecting';
      case CallState.connected:
        return 'connected';
      case CallState.disconnecting:
        return 'disconnecting';
      case CallState.disconnected:
        return 'disconnected';
      case CallState.paused:
        return 'paused';
    }
  }

  static CallState fromString(String value) {
    switch (value.toLowerCase()) {
      case 'idle':
        return CallState.idle;
      case 'connecting':
        return CallState.connecting;
      case 'connected':
        return CallState.connected;
      case 'disconnecting':
        return CallState.disconnecting;
      case 'disconnected':
        return CallState.disconnected;
      case 'paused':
        return CallState.paused;
      default:
        return CallState.idle;
    }
  }
}
