import 'package:flutter/foundation.dart';

import 'notification_type.dart';

@immutable
class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String? avatarUrl;
  final DateTime notifiedAt;
  final NotificationType type;

  final Map<String, dynamic> additionalData;

  /// Indicates whether the notification has been executed.
  /// This is used to prevent duplicate executions of the same notification.
  /// For example, if the notification is opened from the background,
  /// it should not be executed again if it has already been executed.
  ///
  /// This is useful for ensuring that the notification handling logic
  /// does not run multiple times for the same notification.
  ///
  /// Default is false, meaning the notification has not been executed.
  final bool isExecuted;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.notifiedAt,
    required this.type,
    this.avatarUrl,
    this.additionalData = const {},
    this.isExecuted = false,
  });

  @override
  String toString() {
    return 'NotificationEntity{id: $id, title: $title, body: $body}';
  }

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? avatarUrl,
    DateTime? notifiedAt,
    NotificationType? type,
    Map<String, dynamic>? additionalData,
    bool? isExecuted,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notifiedAt: notifiedAt ?? this.notifiedAt,
      type: type ?? this.type,
      additionalData: additionalData ?? this.additionalData,
      isExecuted: isExecuted ?? this.isExecuted,
    );
  }
}
