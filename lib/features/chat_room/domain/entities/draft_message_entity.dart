import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

class DraftMessageEntity {
  final String roomId;
  final String? message;
  final MessageEntity? replyMessage;

  DraftMessageEntity({
    required this.roomId,
    required this.message,
    required this.replyMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'draftMessage': message,
      'replyMessage': replyMessage,
    };
  }

  factory DraftMessageEntity.fromJson(Map<String, dynamic> json) {
    return DraftMessageEntity(
      roomId: json['roomId'] as String,
      message: json['draftMessage'] as String?,
      replyMessage:
          json['replyMessage'] != null ? MessageEntity.fromJson(json['replyMessage'] as Map<String, dynamic>) : null,
    );
  }
}
