enum ReceiveMethod {
  socket,
  notification,
  native;

  String get name {
    switch (this) {
      case ReceiveMethod.socket:
        return 'socket';
      case ReceiveMethod.notification:
        return 'notification';
      case ReceiveMethod.native:
        return 'native';
    }
  }
}
