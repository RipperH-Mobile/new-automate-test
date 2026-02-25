import 'package:isar_community/isar.dart';

part 'account_emoji_reaction_model.g.dart';

@embedded
class AccountEmojiReactionModel {
  final String? accountId;
  final String? accountName;
  final String? avatarId;
  final DateTime? createdAt;

  AccountEmojiReactionModel({
    this.accountId,
    this.accountName,
    this.avatarId,
    this.createdAt,
  });

  static AccountEmojiReactionModel fromMap(Map<String, dynamic> data) {
    return AccountEmojiReactionModel(
      accountId: data['accountId'],
      accountName: data['accountName'],
      avatarId: data['avatarId'],
      createdAt: data['createdAt'],
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AccountEmojiReactionModel && accountId == other.accountId;
  }

  @override
  int get hashCode => accountId.hashCode;
}
