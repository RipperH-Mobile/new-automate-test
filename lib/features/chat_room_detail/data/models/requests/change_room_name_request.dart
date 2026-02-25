class ChangeRoomNameRequest {
  final String roomId;
  final String roomName;

  ChangeRoomNameRequest({
    required this.roomId,
    required this.roomName,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
    };
  }
}
