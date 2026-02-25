class DeleteOtherMessageRequest {
  String roomId;
  List<DeleteOtherMessageModelHelper> messageList;

  DeleteOtherMessageRequest({
    required this.roomId,
    required this.messageList,
  });

  List<Map<String, dynamic>> toListMap() {
    final groupedMessageList = messageList
        .fold<Map<String, List<String>>>(
          {},
          (acc, msg) {
            final messageId = msg.messageId;
            final groupFileIds = msg.groupFileIds ?? [];
            (acc[messageId] ??= []).addAll(groupFileIds);
            return acc;
          },
        )
        .entries
        .map((e) => DeleteOtherMessageModelHelper(messageId: e.key, groupFileIds: e.value))
        .toList();

    return groupedMessageList.map((helper) => helper.toMap()).toList();
  }
}

class DeleteOtherMessageModelHelper {
  String? roomId;
  String messageId;
  List<String>? groupFileIds;

  DeleteOtherMessageModelHelper({
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
