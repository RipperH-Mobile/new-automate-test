class DeleteImagesInAlbumParam {
  final String albumId;
  final String roomId;
  final List<String> imageIds;

  DeleteImagesInAlbumParam({
    required this.albumId,
    required this.roomId,
    required this.imageIds,
  });
}
