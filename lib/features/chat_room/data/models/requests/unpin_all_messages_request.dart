class UnpinAllMessagesRequest {
  final String roomId;

  UnpinAllMessagesRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }

  @override
  String toString() => 'UnpinAllMessagesRequest(roomId: $roomId)';
}
