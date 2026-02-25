enum ChatOrderType {
  /// Unread is default value
  unread('UNREAD'),
  az('AZ'),
  za('ZA'),
  latest('LATEST'),
  oldest('OLDEST');

  final String value;

  const ChatOrderType(this.value);

  factory ChatOrderType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }
}
