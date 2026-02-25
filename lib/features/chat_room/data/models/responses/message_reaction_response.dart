import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';

class MessageReactionResponse {
  final String? msgId;
  final String? roomId;
  final List<LastEmojiModel>? lastEmojis;
  final int? emojiAmount;

  MessageReactionResponse({
    this.msgId,
    this.roomId,
    this.lastEmojis,
    this.emojiAmount,
  });

  factory MessageReactionResponse.fromMap(Map<String, dynamic> data) {
    MessageReactionResponse messageReact = MessageReactionResponse(
      msgId: data['_id'],
      roomId: data['roomId'],
      emojiAmount: data['emojiAmount'],
      lastEmojis: data['lastEmojis'] != null
          ? (data['lastEmojis'] as List).map((e) => LastEmojiModel.fromJson(e)).toList()
          : [],
    );

    return messageReact;
  }
}
