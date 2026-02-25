import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'notification_entity.dart';

class NotificationOnesignalEntity extends NotificationEntity {
  final OSNotification osNotification;

  const NotificationOnesignalEntity({
    required super.id,
    required super.title,
    required super.body,
    required super.notifiedAt,
    required super.type,
    required this.osNotification,
    super.additionalData,
    super.avatarUrl,
    super.isExecuted = false,
  });

  @override
  String toString() {
    return 'NotificationOnesignalEntity{id: $id, title: $title, body: $body}';
  }
}
