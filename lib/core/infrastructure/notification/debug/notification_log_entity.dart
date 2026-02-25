/// Enum representing the type of notification log entry
enum NotificationLogType {
  /// Notification was received from the server
  received,

  /// Notification was clicked by the user
  clicked,

  /// Notification was handled and processed
  handled,

  /// An error occurred during notification processing
  error,
}

/// Entity representing a notification log entry for debugging purposes
class NotificationLogEntity {
  /// Unique identifier for the notification
  final String notificationId;

  /// ID of the room associated with the notification
  final String roomId;

  /// Timestamp when the log entry was created
  final DateTime timestamp;

  /// Type of log entry
  final NotificationLogType logType;

  /// Additional data associated with the notification
  final Map<String, dynamic> notificationData;

  /// Number of messages in the database at the time of logging
  final int? messageCountInDb;

  /// Current app route when the log was created
  final String? currentRoute;

  /// Whether the app was in the foreground when the log was created
  final bool? isAppInForeground;

  /// Time taken to process the notification in milliseconds
  final int? processingTimeMs;

  /// Current queue length at the time of logging
  final int? queueLength;

  const NotificationLogEntity({
    required this.notificationId,
    required this.roomId,
    required this.timestamp,
    required this.logType,
    required this.notificationData,
    this.messageCountInDb,
    this.currentRoute,
    this.isAppInForeground,
    this.processingTimeMs,
    this.queueLength,
  });

  /// Creates a copy of this entity with optional updated values
  NotificationLogEntity copyWith({
    String? notificationId,
    String? roomId,
    DateTime? timestamp,
    NotificationLogType? logType,
    Map<String, dynamic>? notificationData,
    int? messageCountInDb,
    String? currentRoute,
    bool? isAppInForeground,
    int? processingTimeMs,
    int? queueLength,
  }) {
    return NotificationLogEntity(
      notificationId: notificationId ?? this.notificationId,
      roomId: roomId ?? this.roomId,
      timestamp: timestamp ?? this.timestamp,
      logType: logType ?? this.logType,
      notificationData: notificationData ?? this.notificationData,
      messageCountInDb: messageCountInDb ?? this.messageCountInDb,
      currentRoute: currentRoute ?? this.currentRoute,
      isAppInForeground: isAppInForeground ?? this.isAppInForeground,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      queueLength: queueLength ?? this.queueLength,
    );
  }

  /// Converts this entity to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'roomId': roomId,
      'timestamp': timestamp.toIso8601String(),
      'logType': logType.toString(),
      'notificationData': notificationData,
      'messageCountInDb': messageCountInDb,
      'currentRoute': currentRoute,
      'isAppInForeground': isAppInForeground,
      'processingTimeMs': processingTimeMs,
      'queueLength': queueLength,
    };
  }

  /// Creates an entity from a Map
  factory NotificationLogEntity.fromMap(Map<String, dynamic> map) {
    return NotificationLogEntity(
      notificationId: map['notificationId'] as String,
      roomId: map['roomId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      logType: NotificationLogType.values.firstWhere(
        (e) => e.toString() == map['logType'],
        orElse: () => NotificationLogType.received,
      ),
      notificationData: Map<String, dynamic>.from(map['notificationData'] as Map),
      messageCountInDb: map['messageCountInDb'] as int?,
      currentRoute: map['currentRoute'] as String?,
      isAppInForeground: map['isAppInForeground'] as bool?,
      processingTimeMs: map['processingTimeMs'] as int?,
      queueLength: map['queueLength'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationLogEntity &&
        other.notificationId == notificationId &&
        other.roomId == roomId &&
        other.timestamp == timestamp &&
        other.logType == logType;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^
        roomId.hashCode ^
        timestamp.hashCode ^
        logType.hashCode;
  }

  @override
  String toString() {
    return 'NotificationLogEntity('
        'notificationId: $notificationId, '
        'roomId: $roomId, '
        'timestamp: $timestamp, '
        'logType: $logType, '
        'processingTimeMs: $processingTimeMs'
        ')';
  }
}
