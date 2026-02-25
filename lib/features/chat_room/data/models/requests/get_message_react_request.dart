class GetMessageReactRequest {
  String msgId;
  String roomId;
  int page;
  int pageSize;

  GetMessageReactRequest({
    required this.msgId,
    required this.roomId,
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toJsonData() {
    return {
      'messageId': msgId,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
