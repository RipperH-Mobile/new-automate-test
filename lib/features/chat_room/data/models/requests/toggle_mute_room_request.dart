class ToggleMuteRoomRequest {
  String roomId;
  bool isMuted;

  ToggleMuteRoomRequest({
    required this.roomId,
    required this.isMuted,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {'roomId': roomId, 'isMuted': isMuted};

    return json;
  }
}
