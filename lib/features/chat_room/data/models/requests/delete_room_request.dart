class DeleteRoomRequest {
  final String roomId;

  DeleteRoomRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
