class ToggleHideRoomRequest {
  String roomId;
  bool isHidden;

  ToggleHideRoomRequest({
    required this.roomId,
    required this.isHidden,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'roomId': roomId, 'isHidden': isHidden};

    return json;
  }
}
