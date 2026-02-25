class GetPhotosAndVideosInRoomParams {
  final String roomId;
  final int page;
  final int pageSize;

  GetPhotosAndVideosInRoomParams({
    required this.roomId,
    this.page = 1,
    this.pageSize = 20,
  });
}
