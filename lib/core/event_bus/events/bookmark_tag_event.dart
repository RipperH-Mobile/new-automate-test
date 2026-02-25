import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class BookmarkTagEvent {
  String msgId;
  List<BookmarkTagModel> bookmarkTagList;
  String? newTagId;

  BookmarkTagEvent({
    required this.msgId,
    required this.bookmarkTagList,
    this.newTagId,
  });

  @override
  String toString() => 'BookmarkTagEvent(msgId: $msgId, bookmarkTagList: $bookmarkTagList${newTagId != null ? ', newTagId: $newTagId' : ''})';
}
