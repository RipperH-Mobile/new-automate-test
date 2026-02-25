class JoinGroupCallRequest {
  final String roomId;

  JoinGroupCallRequest({
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
    };
  }
}
