import 'package:uchat/utils/datetime.dart';

class UserInRoomTypingEvent {
  final String accountId;
  final String roomId;
  final DateTime? lastTypedAt;
  final bool isTyping;
  final String? displayName;

  UserInRoomTypingEvent({
    required this.accountId,
    required this.roomId,
    required this.lastTypedAt,
    required this.isTyping,
    this.displayName,
  });

  factory UserInRoomTypingEvent.fromJson(Map<String, dynamic> json) {
    return UserInRoomTypingEvent(
      accountId: json['_id'],
      roomId: json['roomId'],
      lastTypedAt: strToDateTime(json['lastTypedAt']),
      isTyping: json['isTyping'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': accountId,
      'roomId': roomId,
      'lastTypedAt': lastTypedAt?.toIso8601String(),
      'isTyping': isTyping,
      if (displayName != null) 'displayName': displayName,
    };
  }

  @override
  toString() {
    return 'UserInRoomTypingEvent(accountId: $accountId, roomId: $roomId, lastTypedAt: $lastTypedAt, isTyping: $isTyping)';
  }
}
