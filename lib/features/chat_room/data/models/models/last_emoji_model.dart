import 'package:isar_community/isar.dart';
import 'package:uchat/utils/datetime.dart';

part 'last_emoji_model.g.dart';

@embedded
class LastEmojiModel {
  final String? emojiId;
  final String? fileId;
  final int? amount;
  final List<String>? accountIds;
  final DateTime? updatedAt;

  LastEmojiModel({
    this.emojiId,
    this.fileId,
    this.amount,
    this.accountIds,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'emojiId': emojiId,
      'fileId': fileId,
      'amount': amount,
      'accountIds': accountIds,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static LastEmojiModel fromJson(Map<String, dynamic> data) {
    return LastEmojiModel(
      emojiId: data['emojiId'],
      fileId: data['fileId'],
      amount: data['amount'],
      accountIds: List<String>.from(data['accountIds'] ?? []),
      updatedAt: strToDateTime(data['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'LastEmojiModel(emojiId: $emojiId, fileId: $fileId, amount: $amount, accountIds: $accountIds, updatedAt: $updatedAt)';
  }
}
