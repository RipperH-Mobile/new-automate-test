import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationReceivedEvent {
  final OSNotificationWillDisplayEvent notification;
  final String notificationId;

  NotificationReceivedEvent({
    required this.notification,
    required this.notificationId,
  });

  @override
  String toString() {
    return 'NotificationReceivedEvent(notificationId: $notificationId, type: ${notification.notification.additionalData?['type'] ?? 'null'}, additionalData: ${notification.notification.additionalData})';
  }
}
