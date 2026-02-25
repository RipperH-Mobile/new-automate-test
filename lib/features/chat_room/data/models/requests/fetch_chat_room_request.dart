class FetchChatRoomRequest {
  final String roomId;

  FetchChatRoomRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
