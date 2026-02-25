class FetchAlbumsParams {
  String roomId;
  int page;
  int pageSize;

  FetchAlbumsParams({
    required this.roomId,
    this.page = 1,
    this.pageSize = 10,
  });
}
