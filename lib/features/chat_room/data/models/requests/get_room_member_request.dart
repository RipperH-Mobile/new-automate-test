class GetRoomMembersRequest {
  String roomId;
  int pageSize;
  int page;

  GetRoomMembersRequest({
    required this.roomId,
    this.page = 1,
    this.pageSize = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'pageSize': pageSize,
      'page': page,
    };
  }
}
