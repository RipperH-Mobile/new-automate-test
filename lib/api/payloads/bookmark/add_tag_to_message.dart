import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class AddTagToMessageRequest {
  final String msgId;
  final String emojiTagId;

  AddTagToMessageRequest({
    required this.msgId,
    required this.emojiTagId,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': msgId,
      'emojiTagId': emojiTagId,
    };
  }
}

class AddTagToMessageResponse {
  final String? msgId;
  List<BookmarkTagModel>? bookmarkEmojiTags;

  AddTagToMessageResponse({
    required this.msgId,
    this.bookmarkEmojiTags,
  });

  factory AddTagToMessageResponse.fromMap(Map<String, dynamic> data) {
    final bookmarkTags = AddTagToMessageResponse(
      msgId: data['_id'],
    );

    if (data['bookmarkEmojiTags'] != null) {
      bookmarkTags.bookmarkEmojiTags = List<BookmarkTagModel>.from(
        data['bookmarkEmojiTags'].map((e) => BookmarkTagModel.fromMap(e)),
      );
    }

    return bookmarkTags;
  }
}
