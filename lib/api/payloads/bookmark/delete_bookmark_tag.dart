import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class DeleteBookmarkTagsRequest {
  final List<String> accountEmojiTagIds;

  DeleteBookmarkTagsRequest({
    required this.accountEmojiTagIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountEmojiTagIds': accountEmojiTagIds,
    };
  }
}

class DeleteBookmarkTagsResponse {
  final List<BookmarkTagModel> deletedTags;

  DeleteBookmarkTagsResponse({
    required this.deletedTags,
  });

  factory DeleteBookmarkTagsResponse.fromMap(List<dynamic> jsonList) {
    return DeleteBookmarkTagsResponse(
      deletedTags: jsonList.map((item) => BookmarkTagModel.fromMap(item)).toList(),
    );
  }
}
