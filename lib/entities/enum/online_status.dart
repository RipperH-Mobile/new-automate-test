enum OnlineStatus {
  online,
  busy,
  doNotDisturb,
  offline;

  String get value {
    switch (this) {
      case OnlineStatus.online:
        return 'ONLINE';
      case OnlineStatus.busy:
        return 'BUSY';
      case OnlineStatus.doNotDisturb:
        return 'DO_NOT_DISTURB';
      case OnlineStatus.offline:
        return 'OFFLINE';
    }
  }

  static OnlineStatus? from(String? val) {
    if (val == null) return null;
    switch (val) {
      case 'ONLINE':
        return OnlineStatus.online;
      case 'BUSY':
        return OnlineStatus.busy;
      case 'DO_NOT_DISTURB':
        return OnlineStatus.doNotDisturb;
      case 'OFFLINE':
        return OnlineStatus.offline;
      default:
        return null;
    }
  }
}
