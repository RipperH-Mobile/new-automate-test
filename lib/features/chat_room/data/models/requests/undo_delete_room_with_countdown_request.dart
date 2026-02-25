class UndoDeleteRoomWithCountdownRequest {
  final String roomId;

  UndoDeleteRoomWithCountdownRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
