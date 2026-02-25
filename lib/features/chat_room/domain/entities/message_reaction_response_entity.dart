import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';

class MessageReactionResponseEntity {
  final String? msgId;
  final String? roomId;
  final List<LastEmojiEntity>? lastEmojis;
  final int? emojiAmount;

  MessageReactionResponseEntity({
    this.msgId,
    this.roomId,
    this.lastEmojis,
    this.emojiAmount,
  });
}
