import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationOpenedEvent {
  final OSNotificationClickEvent result;
  final String notificationId;
  final bool isFirstNoti;

  NotificationOpenedEvent({
    required this.result,
    required this.notificationId,
    this.isFirstNoti = false,
  });

  @override
  String toString() {
    return 'NotificationOpenedEvent(notificationId: $notificationId, type: ${result.notification.additionalData?['type'] ?? 'null'}, additionalData: ${result.notification.additionalData})';
  }
}
