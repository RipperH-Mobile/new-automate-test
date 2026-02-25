class DeleteMessageRequest {
  List<DeleteMessageModelHelper> messageList;

  DeleteMessageRequest({
    required this.messageList,
  });

  List<Map<String, dynamic>> toListMap() {
    groupingListById();
    List<Map<String, dynamic>> listMap = [];

    for (DeleteMessageModelHelper deleteMessageModelHelper in messageList) {
      listMap.add(deleteMessageModelHelper.toMap());
    }

    return listMap;
  }

  void groupingListById() {
    messageList = messageList
        .fold<Map<String, List<String>>>(
          {},
          (acc, msg) {
            if (msg.groupFileIds?.isNotEmpty == true) {
              if (acc[msg.messageId] == null) {
                acc[msg.messageId] = [];
              }
              acc[msg.messageId]?.addAll(msg.groupFileIds!);
            } else {
              acc[msg.messageId] = [];
            }
            return acc;
          },
        )
        .entries
        .map((e) => DeleteMessageModelHelper(messageId: e.key, groupFileIds: e.value))
        .toList();
  }
}

class DeleteMessageModelHelper {
  String? roomId;
  String messageId;
  List<String>? groupFileIds;

  DeleteMessageModelHelper({
    required this.messageId,
    this.roomId,
    this.groupFileIds,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'messageId': messageId,
    };

    if (roomId != null) {
      json['roomId'] = roomId;
    }
    if (groupFileIds != null && groupFileIds!.isNotEmpty) {
      json['groupFileIds'] = groupFileIds;
    }

    return json;
  }
}
