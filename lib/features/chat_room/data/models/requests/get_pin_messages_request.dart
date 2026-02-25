class GetPinMessagesRequest {
  final String roomId;

  GetPinMessagesRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }

  @override
  String toString() => 'GetPinMessagesRequest(roomId: $roomId)';
}
