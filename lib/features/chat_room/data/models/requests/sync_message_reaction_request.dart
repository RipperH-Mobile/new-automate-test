import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';

class SyncMessageReactionRequest {
  final String msgId;
  final String roomId;
  final List<LastEmojiEntity> lastEmojis;
  final int emojiAmount;
  final String? newEmojiId;
  final String? removeEmojiId;
  final String? accountId;
  final List<String>? selectedReactionList;
  final bool isFromSyncProcess;

  const SyncMessageReactionRequest({
    required this.msgId,
    required this.roomId,
    required this.lastEmojis,
    required this.emojiAmount,
    this.newEmojiId,
    this.removeEmojiId,
    this.accountId,
    this.selectedReactionList,
    this.isFromSyncProcess = false,
  });

  SyncMessageReactionRequest copyWith({
    String? msgId,
    String? roomId,
    List<LastEmojiEntity>? lastEmojis,
    int? emojiAmount,
    String? newEmojiId,
    String? removeEmojiId,
    String? accountId,
    List<String>? selectedReactionList,
    bool? isFromSyncProcess,
  }) {
    return SyncMessageReactionRequest(
      msgId: msgId ?? this.msgId,
      roomId: roomId ?? this.roomId,
      lastEmojis: lastEmojis ?? this.lastEmojis,
      emojiAmount: emojiAmount ?? this.emojiAmount,
      newEmojiId: newEmojiId ?? this.newEmojiId,
      removeEmojiId: removeEmojiId ?? this.removeEmojiId,
      accountId: accountId ?? this.accountId,
      selectedReactionList: selectedReactionList ?? this.selectedReactionList,
      isFromSyncProcess: isFromSyncProcess ?? this.isFromSyncProcess,
    );
  }
}
