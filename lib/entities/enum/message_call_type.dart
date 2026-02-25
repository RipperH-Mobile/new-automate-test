enum MessageCallType {
  decline,
  timeout,
  unreachable,
  end,
  join,
  start,
  leave,
  unknown;

  String get value {
    switch (this) {
      case MessageCallType.decline:
        return 'CALL_ROOM_DECLINE';
      case MessageCallType.timeout:
        return 'CALL_ROOM_TIMEOUT';
      case MessageCallType.unreachable:
        return 'CALL_ROOM_UNREACHABLE';
      case MessageCallType.end:
        return 'CALL_ROOM_END';
      case MessageCallType.join:
        return 'CALL_ROOM_JOIN';
      case MessageCallType.start:
        return 'CALL_ROOM_START';
      case MessageCallType.leave:
        return 'CALL_ROOM_LEAVE';
      default:
        return 'UNKNOWN';
    }
  }

  static MessageCallType? from(String val) {
    switch (val) {
      case 'CALL_ROOM_DECLINE':
        return MessageCallType.decline;
      case 'CALL_ROOM_TIMEOUT':
        return MessageCallType.timeout;
      case 'CALL_ROOM_UNREACHABLE':
        return MessageCallType.unreachable;
      case 'CALL_ROOM_END':
        return MessageCallType.end;
      case 'CALL_ROOM_JOIN':
        return MessageCallType.join;
      case 'CALL_ROOM_START':
        return MessageCallType.start;
      case 'CALL_ROOM_LEAVE':
        return MessageCallType.leave;
      default:
        return MessageCallType.unknown;
    }
  }
}
