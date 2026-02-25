import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// Entity representing message state information for debugging race conditions
///
/// This entity captures the state of messages when entering a chat room
/// after tapping a notification, helping to identify discrepancies
/// between what's in the database vs what's displayed in the UI.
class MessageStateEntity {
  /// ID of the room associated with the message state
  final String roomId;

  /// Timestamp when the log was created
  final DateTime timestamp;

  /// List of 10 most recent messages from local database
  final List<MessageCollection> databaseMessages;

  /// List of messages currently displayed in the UI
  final List<MessageCollection> uiMessages;

  /// Number of messages in the database at the time of logging
  final int totalDatabaseMessageCount;

  /// Number of messages currently displayed in the UI
  final int totalUiMessageCount;

  /// Current app route when the log was created
  final String? currentRoute;

  /// Whether the app was in the foreground when the log was created
  final bool? isAppInForeground;

  /// Time taken to fetch message data in milliseconds
  final int? fetchTimeMs;

  const MessageStateEntity({
    required this.roomId,
    required this.timestamp,
    required this.databaseMessages,
    required this.uiMessages,
    required this.totalDatabaseMessageCount,
    required this.totalUiMessageCount,
    this.currentRoute,
    this.isAppInForeground,
    this.fetchTimeMs,
  });

  /// Creates a copy of this entity with optional updated values
  MessageStateEntity copyWith({
    String? roomId,
    DateTime? timestamp,
    List<MessageCollection>? databaseMessages,
    List<MessageCollection>? uiMessages,
    int? totalDatabaseMessageCount,
    int? totalUiMessageCount,
    String? currentRoute,
    bool? isAppInForeground,
    int? fetchTimeMs,
  }) {
    return MessageStateEntity(
      roomId: roomId ?? this.roomId,
      timestamp: timestamp ?? this.timestamp,
      databaseMessages: databaseMessages ?? this.databaseMessages,
      uiMessages: uiMessages ?? this.uiMessages,
      totalDatabaseMessageCount: totalDatabaseMessageCount ?? this.totalDatabaseMessageCount,
      totalUiMessageCount: totalUiMessageCount ?? this.totalUiMessageCount,
      currentRoute: currentRoute ?? this.currentRoute,
      isAppInForeground: isAppInForeground ?? this.isAppInForeground,
      fetchTimeMs: fetchTimeMs ?? this.fetchTimeMs,
    );
  }

  /// Converts this entity to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'timestamp': timestamp.toIso8601String(),
      'databaseMessages': databaseMessages.map((m) => m.toMap()).toList(),
      'uiMessages': uiMessages.map((m) => m.toMap()).toList(),
      'totalDatabaseMessageCount': totalDatabaseMessageCount,
      'totalUiMessageCount': totalUiMessageCount,
      'currentRoute': currentRoute,
      'isAppInForeground': isAppInForeground,
      'fetchTimeMs': fetchTimeMs,
    };
  }

  /// Creates an entity from a Map
  factory MessageStateEntity.fromMap(Map<String, dynamic> map) {
    return MessageStateEntity(
      roomId: map['roomId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      databaseMessages:
          (map['databaseMessages'] as List).map((m) => MessageCollection.fromMap(m as Map<String, dynamic>)).toList(),
      uiMessages: (map['uiMessages'] as List).map((m) => MessageCollection.fromMap(m as Map<String, dynamic>)).toList(),
      totalDatabaseMessageCount: map['totalDatabaseMessageCount'] as int,
      totalUiMessageCount: map['totalUiMessageCount'] as int,
      currentRoute: map['currentRoute'] as String?,
      isAppInForeground: map['isAppInForeground'] as bool?,
      fetchTimeMs: map['fetchTimeMs'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageStateEntity && other.roomId == roomId && other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return roomId.hashCode ^ timestamp.hashCode;
  }

  @override
  String toString() {
    return 'MessageStateEntity('
        'roomId: $roomId, '
        'timestamp: $timestamp, '
        'databaseMessages: ${databaseMessages.length}, '
        'uiMessages: ${uiMessages.length}, '
        'totalDatabaseMessageCount: $totalDatabaseMessageCount, '
        'totalUiMessageCount: $totalUiMessageCount'
        ')';
  }
}
