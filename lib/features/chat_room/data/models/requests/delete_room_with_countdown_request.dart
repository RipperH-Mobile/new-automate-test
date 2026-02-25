class DeleteRoomWithCountdownRequest {
  final String roomId;
  final bool isForceDelete;

  DeleteRoomWithCountdownRequest({
    required this.roomId,
    this.isForceDelete = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'isForceDelete': isForceDelete,
    };
  }
}
