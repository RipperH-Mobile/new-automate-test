@Deprecated('Use RoomPhotoAndVideoRequest instead')
class RoomPhotoRequest {
  String roomId;
  int page;

  RoomPhotoRequest({required this.roomId, required this.page});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'page': page,
    };

    return json;
  }
}
