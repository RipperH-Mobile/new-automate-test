class GetAllAlbumInRoomRequest {
  final String roomId;
  final int page;
  final int pageSize;

  GetAllAlbumInRoomRequest({
    required this.roomId,
    this.page = 1,
    this.pageSize = 10,
  });
}
