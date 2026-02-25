import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';

import '../entities/central_notification_entity.dart';

class PutNotificationParam {
  CentralNotificationEntity notiEntity;

  PutNotificationParam({
    required this.notiEntity,
  });

  CentralNotificationCollection toCollection() {
    return notiEntity.toCollection();
  }
}
