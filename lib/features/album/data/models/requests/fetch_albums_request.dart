class FetchAlbumsRequest {
  final String roomId;
  final int page;
  final int pageSize;

  FetchAlbumsRequest({
    required this.roomId,
    this.page = 1,
    this.pageSize = 10,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
