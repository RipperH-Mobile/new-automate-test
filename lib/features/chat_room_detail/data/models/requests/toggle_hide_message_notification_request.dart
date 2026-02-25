class ToggleHideMessageNotificationRequest {
  final String roomId;
  final bool isHideMessageNotification;

  ToggleHideMessageNotificationRequest({
    required this.roomId,
    required this.isHideMessageNotification,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'isHideMessageNotification': isHideMessageNotification,
    };
  }
}
