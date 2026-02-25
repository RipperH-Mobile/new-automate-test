import 'package:uchat/entities/models/notification_desktop_model.dart';

class NotificationDesktopUpdateEvent {
  NotificationDesktopDataModel notificationDesktop;

  NotificationDesktopUpdateEvent({required this.notificationDesktop});

  @override
  String toString() => 'NotificationDesktopUpdateEvent(notificationDesktop: $notificationDesktop)';
}
