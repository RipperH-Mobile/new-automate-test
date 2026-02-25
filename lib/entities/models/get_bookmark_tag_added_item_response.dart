import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class GetBookmarkTagAddedItemResponse {
  List<BookmarkTagModel>? bookmarkAddedItemList;
  int? total;

  GetBookmarkTagAddedItemResponse({
    this.bookmarkAddedItemList,
    this.total,
  });

  factory GetBookmarkTagAddedItemResponse.fromMap(Map<String, dynamic> json) {
    List<BookmarkTagModel>? dataList = [];

    if (json['rows'] != null) {
      for (final data in json['rows']) {
        dataList.add(BookmarkTagModel.fromMap(data));
      }
    }

    return GetBookmarkTagAddedItemResponse(
      bookmarkAddedItemList: dataList,
      total: json['total'],
    );
  }
}
