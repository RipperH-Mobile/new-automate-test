import 'package:uchat/api/payloads/message/bookmark/bookmark_request_model.dart';

class SaveBookmarkRequest {
  List<BookmarkRequestDataModel> dataList;
  String? roomId;

  SaveBookmarkRequest({
    required this.dataList,
    this.roomId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'messages': messagesMap(),
    };

    if (roomId != null) json['roomId'] = roomId;

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

// class SaveBookmarkRequest {
//   String msgId;
//   String roomId;
//   List<String>? fileIds;

//   SaveBookmarkRequest({
//     required this.msgId,
//     required this.roomId,
//     this.fileIds,
//   });

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> json = {
//       'messages': [messagesMap()],
//       'roomId': roomId,
//     };

//     return json;
//   }

//   Map<String, dynamic> messagesMap() {
//     Map<String, dynamic> json = {
//       'id': msgId,
//     };

//     if (fileIds != null) {
//       json['fileIds'] = fileIds;
//     }

//     return json;
//   }
// }
