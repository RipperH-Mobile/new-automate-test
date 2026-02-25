class GetRequestedListRequest {
  int page;
  int pageSize;
  String? roomId;
  String? keyword;

  GetRequestedListRequest({
    required this.page,
    required this.pageSize,
    this.roomId,
    this.keyword,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      'roomId': roomId,
      'keyword': keyword,
    };
  }
}
