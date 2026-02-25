class FetchRoomFileRequest {
  final String roomId;
  final int page;
  final int pageSize;

  FetchRoomFileRequest({
    required this.roomId,
    this.page = 1,
    this.pageSize = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'page': page,
      'pageSize': pageSize,
    };
  }
}