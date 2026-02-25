import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/account_emoji_reaction_model.dart';

part 'reaction_categories_model.g.dart';

@embedded
class ReactionCategoriesModel {
  final String? msgId;
  final String? roomId;
  final String? emojiId;
  final String? fileId;
  final int? amount;
  DateTime? createdAt;
  List<AccountEmojiReactionModel>? accountList;

  ReactionCategoriesModel({
    this.msgId,
    this.roomId,
    this.emojiId,
    this.fileId,
    this.amount,
    this.createdAt,
    this.accountList,
  });

  @override
  bool operator ==(Object other) {
    return other is ReactionCategoriesModel && msgId == other.msgId;
  }

  @override
  int get hashCode => msgId.hashCode;

  @override
  String toString() {
    return '[ReactionCategoriesModel] '
        'msgId: $msgId, '
        'roomId: $roomId, '
        'emojiId: $emojiId, '
        'fileId: $fileId, '
        'amount: $amount, '
        'createdAt: $createdAt, '
        'accountList: $accountList';
  }
}
