import 'package:uchat/entities/models/default_emoji_item_model.dart';

class UpdateDefaultEmojiEntity {
  UpdateDefaultEmojiEntity({
    required this.accountDefaultEmojiItems,
  });

  final List<DefaultEmojiItemModel> accountDefaultEmojiItems;

  factory UpdateDefaultEmojiEntity.fromMap(Map<String, dynamic> json) {
    return UpdateDefaultEmojiEntity(
      accountDefaultEmojiItems: List<DefaultEmojiItemModel>.from(
        json['accountDefaultEmojiItems'].map((x) => DefaultEmojiItemModel.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    final emojis = accountDefaultEmojiItems;

    final json = <String, dynamic>{
      'accountDefaultEmojiItems': emojis,
    };

    return json;
  }
}
