class FetchImagesInAlbumRequest {
  final String albumId;
  final int page;
  final int pageSize;
  final DateTime? beforeCreatedAt;
  final DateTime? afterCreatedAt;

  FetchImagesInAlbumRequest({
    required this.albumId,
    this.page = 1,
    this.pageSize = 50,
    this.beforeCreatedAt,
    this.afterCreatedAt,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    final json = {
      'albumId': albumId,
      'page': page,
      'pageSize': pageSize,
    };
    if (beforeCreatedAt != null) {
      json['beforeCreatedAt'] = beforeCreatedAt!.toIso8601String();
    }
    if (afterCreatedAt != null) {
      json['afterCreatedAt'] = afterCreatedAt!.toIso8601String();
    }
    return json;
  }
}
