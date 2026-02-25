class InvitedListRequest {
  int page;
  int pageSize;

  InvitedListRequest({
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
    };
  }
}
