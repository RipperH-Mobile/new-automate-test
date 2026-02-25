class DownloadAlbumImageResultEntity {
  int totalImages;
  int successCount;
  bool isCanceled;

  DownloadAlbumImageResultEntity({
    required this.totalImages,
    required this.successCount,
    this.isCanceled = false,
  });
}