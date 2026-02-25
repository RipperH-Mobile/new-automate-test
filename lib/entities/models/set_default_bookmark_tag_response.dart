import 'package:uchat/entities/models/default_bookmark_tag_item_model.dart';

class SetDefaultBookmarkTagResponse {
  SetDefaultBookmarkTagResponse({
    required this.accountDefaultBookmarkEmojiTags,
  });

  final List<DefaultBookmarkTagItemModel> accountDefaultBookmarkEmojiTags;

  factory SetDefaultBookmarkTagResponse.fromMap(Map<String, dynamic> json) {
    return SetDefaultBookmarkTagResponse(
      accountDefaultBookmarkEmojiTags: List<DefaultBookmarkTagItemModel>.from(
        json['accountDefaultBookmarkEmojiTags'].map((x) {
          return DefaultBookmarkTagItemModel.fromMap(x);
        }),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    final emojis = accountDefaultBookmarkEmojiTags;

    final json = <String, dynamic>{
      'accountDefaultBookmarkEmojiTags': emojis,
    };

    return json;
  }
}
