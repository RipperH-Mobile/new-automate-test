import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';

class UpdateMessageReactionResponse {
  final String messageId;
  final String roomId;
  final UpdateEmojiModel? newEmoji;
  final UpdateEmojiModel? removeEmoji;
  final List<LastEmojiModel>? lastEmojis;
  // final String? createdAt;
  final int? emojiAmount;

  const UpdateMessageReactionResponse({
    required this.messageId,
    required this.roomId,
    this.newEmoji,
    this.removeEmoji,
    this.lastEmojis,
    // this.createdAt,
    this.emojiAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': messageId,
      'roomId': roomId,
      if (newEmoji != null) 'newEmoji': newEmoji!.toMap(),
      if (removeEmoji != null) 'removeEmoji': removeEmoji!.toMap(),
      if (lastEmojis != null) 'lastEmojis': lastEmojis!.map((e) => e.toJson()).toList(),
      // if (createdAt != null) 'createdAt': createdAt,
      if (emojiAmount != null) 'emojiAmount': emojiAmount,
    };
  }

  factory UpdateMessageReactionResponse.fromMap(Map<String, dynamic> map) {
    return UpdateMessageReactionResponse(
      messageId: map['_id'] ?? '',
      roomId: map['roomId'] ?? '',
      newEmoji: map['newEmoji'] != null ? UpdateEmojiModel.fromMap(map['newEmoji']) : null,
      removeEmoji: map['removeEmoji'] != null ? UpdateEmojiModel.fromMap(map['removeEmoji']) : null,
      lastEmojis: map['lastEmojis'] != null
          ? List<LastEmojiModel>.from(map['lastEmojis'].map((x) => LastEmojiModel.fromJson(x)))
          : null,
      // createdAt: map['createdAt'],
      emojiAmount: map['emojiAmount'],
    );
  }
}

class UpdateEmojiModel {
  final String emojiId;
  final String accountId;

  const UpdateEmojiModel({
    required this.emojiId,
    required this.accountId,
  });

  Map<String, dynamic> toMap() {
    return {
      'emojiId': emojiId,
      'accountId': accountId,
    };
  }

  factory UpdateEmojiModel.fromMap(Map<String, dynamic> map) {
    return UpdateEmojiModel(
      emojiId: map['emojiId'] ?? '',
      accountId: map['accountId'] ?? '',
    );
  }
}
