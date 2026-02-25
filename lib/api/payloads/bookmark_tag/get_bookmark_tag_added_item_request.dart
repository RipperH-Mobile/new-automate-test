class GetBookmarkTagAddedItemRequest {
  final int page;
  final int pageSize;

  GetBookmarkTagAddedItemRequest({
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
