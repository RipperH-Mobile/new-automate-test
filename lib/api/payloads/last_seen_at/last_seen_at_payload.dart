// final _log = useLogger();

class LastSeenAtRequest {
  String lastSeenNotificationAt;

  LastSeenAtRequest({
    required this.lastSeenNotificationAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'lastSeenNotificationAt': lastSeenNotificationAt,
    };
  }
}
