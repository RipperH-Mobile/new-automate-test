class GetChatRoomForShareParam {
  bool hasMessageType;
  bool hasMediaType;
  int? limit;

  GetChatRoomForShareParam({
    required this.hasMessageType,
    required this.hasMediaType,
    this.limit,
  });
}
