import 'package:isar_community/isar.dart';

part 'default_emoji_item_model.g.dart';

@embedded
class DefaultEmojiItemModel {
  final String? emojiItemId;
  final String? fileId;

  DefaultEmojiItemModel({
    this.emojiItemId,
    this.fileId,
  });

  factory DefaultEmojiItemModel.fromMap(Map<String, dynamic> json) => DefaultEmojiItemModel(
        emojiItemId: json['emojiItemId'],
        fileId: json['fileId'],
      );

  Map<String, dynamic> toMap() => {
        'emojiItemId': emojiItemId,
        'fileId': fileId,
      };
}
