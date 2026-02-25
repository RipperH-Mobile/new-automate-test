class GetPhotosAndVideosByRoomIdRequest {
  final String roomId;
  final int page;
  final int pageSize;

  const GetPhotosAndVideosByRoomIdRequest({
    required this.roomId,
    this.page = 1,
    this.pageSize = 20,
  });
}
