class SearchFriendContactParams {
  final String keyword;
  final int? limit;
  final bool includePhoneNumber;

  SearchFriendContactParams({required this.keyword, this.limit, this.includePhoneNumber = false});
}
