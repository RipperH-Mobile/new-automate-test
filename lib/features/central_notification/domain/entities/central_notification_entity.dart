import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/central_notification/data/model/central_notification_data_model.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';

class CentralNotificationEntity {
  String? id;

  CentralNotiType? notiType;

  String? historyForAccountId;

  CentralNotificationDataModel? data;

  DateTime? createdAt;

  String? notiUnreadCount;

  CentralNotificationEntity({
    this.id,
    this.notiType,
    this.historyForAccountId,
    this.data,
    this.createdAt,
    this.notiUnreadCount,
  });

  CentralNotificationCollection toCollection() {
    return CentralNotificationCollection(
      id: id,
      notiType: notiType,
      historyForAccountId: historyForAccountId,
      data: data,
      createdAt: createdAt,
      notiUnreadCount: notiUnreadCount,
    );
  }

  @override
  bool operator ==(Object other) => other is CentralNotificationEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
