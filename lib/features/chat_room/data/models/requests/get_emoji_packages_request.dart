class GetEmojiPackagesRequest {
  final int page;
  final int pageSize;
  GetEmojiPackagesRequest({
    required this.page,
    required this.pageSize,
  });

  factory GetEmojiPackagesRequest.fromMap(Map<String, dynamic> json) => GetEmojiPackagesRequest(
        page: json['page'],
        pageSize: json['pageSize'],
      );

  Map<String, dynamic> toMap() => {
        'page': page,
        'pageSize': pageSize,
      };
}
