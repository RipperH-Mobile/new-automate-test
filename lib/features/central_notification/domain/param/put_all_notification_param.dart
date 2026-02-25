import '../entities/central_notification_entity.dart';

class PutAllNotificationParam {
  List<CentralNotificationEntity> notiList;
  bool isNeedTransaction;

  PutAllNotificationParam({
    required this.notiList,
    this.isNeedTransaction = true,
  });
}
