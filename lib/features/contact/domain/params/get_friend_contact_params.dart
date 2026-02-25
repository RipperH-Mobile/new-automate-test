class GetFriendContactParams {
  final int? limit;
  final List<String> notInIds;

  GetFriendContactParams({
    this.limit,
    this.notInIds = const [],
  });
}
