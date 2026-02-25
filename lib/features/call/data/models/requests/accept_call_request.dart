class AcceptCallRequest {
  final String roomCallId;

  AcceptCallRequest({
    required this.roomCallId,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomCallId': roomCallId,
    };
  }
}
