import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class ClearLocalNotificationsUseCase extends SimpleUseCase<dynamic, NoParams> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I<CentralNotificationLocalRepository>();
  }

  @override
  Future<void> call(NoParams _) async {
    try {
      await centralNotificationLocalRepository.clearCollection();
    } catch (e, stackTrace) {
      _log.w('ClearLocalNotificationsUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
