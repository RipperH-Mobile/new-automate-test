import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';
// import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';

class MessageReactionEvent {
  String msgId;
  int emojiAmount;
  List<LastEmojiEntity> lastEmojis;
  String? removeEmojiId;
  List<String>? selectedReactionList;
  String accountId;

  MessageReactionEvent({
    required this.msgId,
    required this.emojiAmount,
    required this.lastEmojis,
    required this.accountId,
    this.removeEmojiId,
    this.selectedReactionList,
  });

  @override
  String toString() => 'MessageReactionEvent(msgId: $msgId, emojiAmount: $emojiAmount, accountId: $accountId)';
}
