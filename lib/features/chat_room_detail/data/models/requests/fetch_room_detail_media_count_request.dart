class FetchRoomDetailMediaCountRequest {
  final String roomId;

  FetchRoomDetailMediaCountRequest({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
