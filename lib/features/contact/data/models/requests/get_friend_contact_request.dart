class GetFriendContactRequest {
  final int? limit;
  final List<String> notInIds;

  GetFriendContactRequest({
    this.limit,
    this.notInIds = const [],
  });
}
