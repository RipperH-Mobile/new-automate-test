class GetFriendRequestRequest {
  int page;
  int pageSize;

  GetFriendRequestRequest({
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
    };
  }
}
