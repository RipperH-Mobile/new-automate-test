class GetUnfinishedAlbumTaskParam {
  String roomId;
  String? albumId;

  GetUnfinishedAlbumTaskParam({
    required this.roomId,
    this.albumId,
  });
}