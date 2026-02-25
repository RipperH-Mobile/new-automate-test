class FetchImagesInAlbumParam {
  String albumId;
  int page;
  int pageSize;
  DateTime? beforeCreatedAt;
  DateTime? afterCreatedAt;

  FetchImagesInAlbumParam({
    required this.albumId,
    this.page = 1,
    this.pageSize = 50,
    this.afterCreatedAt,
    this.beforeCreatedAt,
  });
}
