class SearchInRoomRequest {
  final String roomId;
  final String keyword;

  SearchInRoomRequest({
    required this.roomId,
    required this.keyword,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'keyword': keyword,
    };
  }
}
