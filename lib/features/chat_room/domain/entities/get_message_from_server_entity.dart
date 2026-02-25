import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

/// Entity class representing a response when retrieving messages from the server
class GetMessageFromServerEntity {
  GetMessageFromServerEntity({
    this.messages,
    this.hasMore = false,
  });

  /// List of message entities retrieved from the server
  final List<MessageEntity>? messages;

  /// Flag indicating if there are more messages to retrieve
  final bool hasMore;
}
