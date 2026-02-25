class FetchRoomLinksRequest {
  final String roomId;
  final int page;
  final int pageSize;

  FetchRoomLinksRequest({
    required this.roomId,
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
