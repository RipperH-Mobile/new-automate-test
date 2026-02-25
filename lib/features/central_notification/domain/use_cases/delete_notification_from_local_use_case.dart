import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/delete_notification_param.dart';
import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class DeleteNotificationFromLocalUseCase extends SimpleUseCase<bool, DeleteNotificationParam> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I<CentralNotificationLocalRepository>();
  }

  @override
  Future<bool> call(DeleteNotificationParam param) async {
    try {
      return await centralNotificationLocalRepository.deleteCentralNotiOnDb(param.notiId);
    } catch (e, stackTrace) {
      _log.w('DeleteNotificationFromLocalUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
