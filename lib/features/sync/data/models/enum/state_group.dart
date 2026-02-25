enum StateGroup {
  defaultGroup,
  message,
  room,
  roomSubscription,
  friend;

  String get value {
    switch (this) {
      case StateGroup.message:
        return 'MESSAGE';
      case StateGroup.room:
        return 'ROOM';
      case StateGroup.roomSubscription:
        return 'ROOM_SUBSCRIPTION';
      case StateGroup.friend:
        return 'FRIEND';
      case StateGroup.defaultGroup:
        return 'DEFAULT';
    }
  }

  static StateGroup from(String? val) {
    switch (val) {
      case 'MESSAGE':
        return StateGroup.message;
      case 'ROOM':
        return StateGroup.room;
      case 'ROOM_SUBSCRIPTION':
        return StateGroup.roomSubscription;
      case 'FRIEND':
        return StateGroup.friend;
      case 'DEFAULT':
      default:
        return StateGroup.defaultGroup;
    }
  }

  @override
  toString() {
    return value;
  }
}
