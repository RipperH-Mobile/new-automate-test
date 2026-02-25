import 'package:uchat/api/payloads/message/bookmark/bookmark_request_model.dart';

class RemoveBookmarkRequest {
  List<BookmarkRequestDataModel> dataList;

  RemoveBookmarkRequest({
    required this.dataList,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'bookmarkMessages': messagesMap(),
    };

    return json;
  }

  List<Map<String, dynamic>> messagesMap() {
    List<Map<String, dynamic>> json = [];

    for (final data in dataList) {
      final jsonData = {
        'id': data.msgId,
        'fileIds': data.fileIds,
      };

      json.add(jsonData);
    }

    return json;
  }
}

// class RemoveBookmarkRequest {
//   String bookmarkMessageId;
//   List<String>? fileIds;

//   RemoveBookmarkRequest({
//     required this.bookmarkMessageId,
//     this.fileIds,
//   });

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> json = {
//       'bookmarkMessages': [xxxMap()],
//     };

//     return json;
//   }

//   Map<String, dynamic> xxxMap() {
//     Map<String, dynamic> json = {
//       'id': bookmarkMessageId,
//     };

//     if (fileIds != null) {
//       json['fileIds'] = fileIds;
//     }

//     return json;
//   }
// }
