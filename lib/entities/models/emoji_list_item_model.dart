import 'package:uchat/entities/models/emoji_item_model.dart';

class EmojiListItemModel {
  EmojiItemModel emojiItem;
  bool active;

  EmojiListItemModel({
    required this.emojiItem,
    required this.active,
  });
}
