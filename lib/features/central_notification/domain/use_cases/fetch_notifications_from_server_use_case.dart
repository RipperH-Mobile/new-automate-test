import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../param/central_notification_payload.dart';
import '../param/put_all_notification_param.dart';
import '../repository/central_notification_server_repository.dart';
import 'put_all_notifications_to_local_use_case.dart';

final _log = useLogger();

class FetchNotificationsFromServerUseCase
    extends SimpleUseCase<CentralNotificationResponse?, CentralNotificationParam> {
  CentralNotificationServerRepository get centralNotificationServerRepository {
    return GetIt.I<CentralNotificationServerRepository>();
  }

  PutAllNotificationsToLocalUseCase get putAllNotificationsToLocalUseCase {
    return GetIt.I<PutAllNotificationsToLocalUseCase>();
  }

  @override
  Future<CentralNotificationResponse?> call(CentralNotificationParam param) async {
    try {
      final res = await centralNotificationServerRepository.getNotificationList(
        CentralNotificationParam(page: param.page, pageSize: param.pageSize),
      );

      if (res == null) return null;

      final entityList = res.centralNotiList.map((e) => e.toEntity()).toList();
      await putAllNotificationsToLocalUseCase.call(PutAllNotificationParam(
        notiList: entityList,
      ));

      return res;
    } catch (e, stackTrace) {
      _log.w('fetchNotificationListFromServer error.', e, stackTrace);
      rethrow;
    }
  }
}
