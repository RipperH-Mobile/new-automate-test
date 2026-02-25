import '../param/central_notification_payload.dart';
import '../param/delete_notification_param.dart';

abstract class CentralNotificationServerRepository {
  Future<void> deleteNotification(DeleteNotificationParam notiId);

  Future<CentralNotificationResponse?> getNotificationList(CentralNotificationParam request);
}
