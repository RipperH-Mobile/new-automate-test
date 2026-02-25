import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

/// Entity class representing a response when sending a message to the server
class SendMessageResponseEntity {
  SendMessageResponseEntity({
    this.message,
    this.success = false,
  });

  /// Message entity that was successfully sent
  final MessageEntity? message;

  /// Flag indicating if the message was successfully sent
  final bool success;
}
