import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/delete_notification_param.dart';
import '../repository/central_notification_server_repository.dart';
import 'delete_notification_from_local_use_case.dart';

final _log = useLogger();

class DeleteNotificationsUseCase extends SimpleUseCase<dynamic, DeleteNotificationParam> {
  CentralNotificationServerRepository get centralNotificationServerRepository {
    return GetIt.I<CentralNotificationServerRepository>();
  }

  DeleteNotificationFromLocalUseCase get deleteNotificationFromLocalUseCase {
    return GetIt.I<DeleteNotificationFromLocalUseCase>();
  }

  @override
  Future<void> call(DeleteNotificationParam param) async {
    try {
      await centralNotificationServerRepository.deleteNotification(
        DeleteNotificationParam(notiId: param.notiId),
      );

      await deleteNotificationFromLocalUseCase.call(param);
    } catch (e, stackTrace) {
      _log.w('DeleteCentralNotificationUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
