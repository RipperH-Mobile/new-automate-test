class UnsentMessageRequest {
  List<UnsendMessageModelHelper> messageList;

  UnsentMessageRequest({
    required this.messageList,
  });

  List<Map<String, dynamic>> toListMap() {
    groupingListById();
    List<Map<String, dynamic>> list = [];

    for (var message in messageList) {
      list.add(message.toMap());
    }

    return list;
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
        .map((e) => UnsendMessageModelHelper(messageId: e.key, groupFileIds: e.value))
        .toList();
  }
}

class UnsendMessageModelHelper {
  String? roomId;
  String messageId;
  List<String>? groupFileIds;

  UnsendMessageModelHelper({
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
