import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class ChatRoomArguments {
  // TODO (improve) Update this to entity ?
  RoomCollection room;

  /// The message to jump to when opening the chat room.
  ///
  /// If this is `null`, the chat room will open at the bottom of the chat room.
  // TODO (improve) Update this to entity ?
  MessageCollection? targetMessage;

  // from old code
  bool ignoreReadMessage;
  bool isFromHomeScreen;
  bool isMyNote;
  bool isBookmarkTagFiltered;
  BookmarkTagModel? bookmarkFilteredTag;
  String fromPage;

  ChatRoomArguments({
    required this.room,
    this.targetMessage,
    this.ignoreReadMessage = false,
    this.isFromHomeScreen = false,
    this.isMyNote = false,
    this.isBookmarkTagFiltered = false,
    this.bookmarkFilteredTag,
    this.fromPage = '',
  });
}
