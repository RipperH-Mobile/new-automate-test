import 'package:uchat/api/api.dart';
import 'package:uchat/features/central_notification/domain/param/central_notification_payload.dart';
import 'package:uchat/features/central_notification/domain/param/delete_notification_param.dart';

class CentralNotificationSocketService {
  CentralNotificationSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<void> deleteNotification(DeleteNotificationParam notiId) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteNoti.socket,
      notiId.toMap(),
    );
  }

  Future<CentralNotificationResponse?> getNotificationList(CentralNotificationParam request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getNotiList.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((data) => CentralNotificationResponse.fromMap(data));
  }
}
