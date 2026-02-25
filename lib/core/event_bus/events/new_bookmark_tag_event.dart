import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class NewBookmarkTagEvent {
  BookmarkTagModel newBookmarkTag;

  NewBookmarkTagEvent({
    required this.newBookmarkTag,
  });

  @override
  String toString() => 'NewBookmarkTagEvent(newBookmarkTag: $newBookmarkTag)';
}
