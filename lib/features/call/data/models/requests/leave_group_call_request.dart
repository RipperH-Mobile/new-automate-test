class LeaveGroupCallRequest {
  final String roomId;

  LeaveGroupCallRequest({
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
    };
  }
}
