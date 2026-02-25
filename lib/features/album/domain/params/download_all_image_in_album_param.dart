class DownloadAllImageInAlbumParam {
  String albumId;
  String roomId;

  /// Total image count in the album. Will be used to save how many image in this task in album task collection.
  int? imageCount;

  /// Task id of the retry download all task.
  /// Use null if this is a new download all task.
  String? taskId;

  DownloadAllImageInAlbumParam({
    required this.albumId,
    required this.roomId,
    this.imageCount,
    this.taskId,
  });
}
