import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/put_all_notification_param.dart';
import '../repository/central_notification_local_repository.dart';

final _log = useLogger();

class PutAllNotificationsToLocalUseCase extends SimpleUseCase<dynamic, PutAllNotificationParam> {
  CentralNotificationLocalRepository get centralNotificationLocalRepository {
    return GetIt.I.get<CentralNotificationLocalRepository>();
  }

  @override
  Future<void> call(PutAllNotificationParam param) async {
    try {
      final collectionList = param.notiList.map((e) => e.toCollection()).toList();

      if (param.isNeedTransaction) {
        await centralNotificationLocalRepository.putAllCentralNoti(collectionList);
      } else {
        await centralNotificationLocalRepository.putAllCentralNotiWithoutTxn(collectionList);
      }
    } catch (e, stackTrace) {
      _log.w('PutAllNotificationsToLocalUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
