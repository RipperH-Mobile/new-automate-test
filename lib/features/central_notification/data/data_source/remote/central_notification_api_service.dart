import 'package:uchat/api/api.dart';
import 'package:uchat/features/central_notification/domain/param/central_notification_payload.dart';
import 'package:uchat/features/central_notification/domain/param/delete_notification_param.dart';

class CentralNotificationApiService {
  CentralNotificationApiService({
    required this.httpCaller,
  });

  final HttpCaller httpCaller;

  Future<void> deleteNotification(DeleteNotificationParam notiId) async {
    await httpCaller.delete(
      BackendPath.deleteNoti.http,
      data: notiId.toMap(),
    );
  }

  Future<CentralNotificationResponse?> getNotificationList(CentralNotificationParam request) async {
    final httpResp = await httpCaller.get(
      BackendPath.getNotiList.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((data) => CentralNotificationResponse.fromMap(data));
  }
}
