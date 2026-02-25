class RoomFileRequest {
  final String roomId;
  final int page;

  RoomFileRequest({
    required this.roomId,
    required this.page,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'page': page,
    };
  }
}
