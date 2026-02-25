class SearchFriendContactRequest {
  final String keyword;
  final int? limit;
  final bool includePhoneNumber;

  SearchFriendContactRequest({
    required this.keyword,
    this.limit,
    this.includePhoneNumber = false,
  });
}
