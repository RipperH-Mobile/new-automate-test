class ShareImageFromAlbumParam {
  String albumId;
  List<String> imageIds;
  List<String> targetRoomIds;

  ShareImageFromAlbumParam({
    required this.albumId,
    required this.imageIds,
    required this.targetRoomIds,
  });
}
