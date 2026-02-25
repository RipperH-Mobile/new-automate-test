import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/central_notification/data/model/central_notification_data_model.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import '../../../domain/entities/central_notification_entity.dart';

part 'central_notification_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'centralNotification')
@Name('CentralNotification')
class CentralNotificationCollection {
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @Enumerated(EnumType.name)
  CentralNotiType? notiType;

  String? historyForAccountId;

  CentralNotificationDataModel? data;

  DateTime? createdAt;

  String? notiUnreadCount;

  CentralNotificationCollection({
    this.id,
    this.notiType,
    this.historyForAccountId,
    this.data,
    this.createdAt,
    this.notiUnreadCount,
  });

  factory CentralNotificationCollection.fromMap(Map<String, dynamic> json) {
    CentralNotificationDataModel? data;
    if (json['data'] != null) {
      try {
        data = CentralNotificationDataModel.fromMap(json['data']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse account. (${json['data']})',
          e,
          stackTrace,
        );
      }
    }

    var centralNoti = CentralNotificationCollection(
      id: json['_id'],
      notiType: CentralNotiType.from(json['notiType']),
      historyForAccountId: json['historyForAccountId'],
      data: data,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      notiUnreadCount: json['notiUnreadCount'].toString(),
    );

    return centralNoti;
  }

  CentralNotificationEntity toEntity() {
    return CentralNotificationEntity(
      id: id,
      notiType: notiType,
      historyForAccountId: historyForAccountId,
      data: data,
      createdAt: createdAt,
      notiUnreadCount: notiUnreadCount,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CentralNotificationCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '[CentralNotificationCollection] ID: $id, notiType: $notiType, historyForAccountId: $historyForAccountId, data: $data, createdAt: $createdAt, notiUnreadCount: $notiUnreadCount';
  }
}
