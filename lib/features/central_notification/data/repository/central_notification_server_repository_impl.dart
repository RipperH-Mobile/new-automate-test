import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/central_notification/data/data_source/remote/central_notification_api_service.dart';
import 'package:uchat/features/central_notification/data/data_source/remote/central_notification_socket_service.dart';
import 'package:uchat/features/central_notification/domain/param/central_notification_payload.dart';
import 'package:uchat/features/central_notification/domain/param/delete_notification_param.dart';
import 'package:uchat/features/central_notification/domain/repository/central_notification_server_repository.dart';

class CentralNotificationServerRepositoryImpl implements CentralNotificationServerRepository {
  final SocketCaller socketCaller;
  final CentralNotificationApiService centralNotificationApiService;
  final CentralNotificationSocketService centralNotificationSocketService;

  CentralNotificationServerRepositoryImpl({
    required this.socketCaller,
    required this.centralNotificationApiService,
    required this.centralNotificationSocketService,
  });

  final _log = useLogger();

  @override
  Future<void> deleteNotification(DeleteNotificationParam notiId) async {
    if (socketCaller.isReadyForCall) {
      try {
        await centralNotificationSocketService.deleteNotification(notiId);
      } catch (e, stackTrace) {
        _log.w('deleteNotification socket error.', e, stackTrace);
      }
    }

    try {
      await centralNotificationApiService.deleteNotification(notiId);
    } catch (e, stackTrace) {
      _log.e('deleteNotification error.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<CentralNotificationResponse?> getNotificationList(
    CentralNotificationParam request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await centralNotificationSocketService.getNotificationList(request);
      } catch (e, stackTrace) {
        _log.w('getNotificationList socket error.', e, stackTrace);
      }
    }

    try {
      return await centralNotificationApiService.getNotificationList(request);
    } catch (e, stackTrace) {
      _log.e('getNotificationList error.', e, stackTrace);
      rethrow;
    }
  }
}
