import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class SearchMessageInRoomRequest {
  String roomId;
  String keyword;
  int page;
  int pageSize;
  String? bookmarkTagId;

  SearchMessageInRoomRequest({
    required this.roomId,
    required this.keyword,
    required this.page,
    required this.pageSize,
    this.bookmarkTagId,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'keyword': keyword,
      'page': page,
      'pageSize': pageSize,
      'emojiTagId': bookmarkTagId,
    };
  }
}

class SearchMessageInRoomResponse {
  List<MessageCollection> messages;

  SearchMessageInRoomResponse({required this.messages});

  factory SearchMessageInRoomResponse.fromList(List json) {
    List<MessageCollection> result = [];
    for (final message in json) {
      result.add(MessageCollection.fromMap(message));
    }
    return SearchMessageInRoomResponse(messages: result);
  }
}
