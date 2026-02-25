class TogglePinRoomRequest {
  String roomId;
  bool isPinned;

  TogglePinRoomRequest({
    required this.roomId,
    required this.isPinned,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'isPinned': isPinned,
    };

    return json;
  }
}
