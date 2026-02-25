import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/delete_notifications_param.dart';
import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class DeleteNotificationsFromLocalUseCase extends SimpleUseCase<void, DeleteNotificationsParam> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I<CentralNotificationLocalRepository>();
  }

  @override
  Future<void> call(DeleteNotificationsParam param) async {
    try {
      return await centralNotificationLocalRepository.deleteCentralNotifications(param.notiIds);
    } catch (e, stackTrace) {
      _log.w('DeleteNotificationsFromLocalUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
