import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/put_notification_param.dart';
import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class PutNotificationToLocalUseCase extends SimpleUseCase<dynamic, PutNotificationParam> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I.get<CentralNotificationLocalRepository>();
  }

  @override
  Future<void> call(PutNotificationParam param) async {
    try {
      await centralNotificationLocalRepository.putCentralNoti(param.toCollection());
    } catch (e, stackTrace) {
      _log.w('PutNotificationToLocalUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
