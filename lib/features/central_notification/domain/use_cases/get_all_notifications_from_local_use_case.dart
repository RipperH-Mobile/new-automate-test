import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../entities/central_notification_entity.dart';
import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class GetAllNotificationsFromLocalUseCase extends SimpleUseCase<List<CentralNotificationEntity>, NoParams> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I<CentralNotificationLocalRepository>();
  }

  @override
  Future<List<CentralNotificationEntity>> call(NoParams _) async {
    try {
      final res = await centralNotificationLocalRepository.getAllCentralNoti();

      return res.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      _log.w('GetAllNotificationsFromLocalUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
