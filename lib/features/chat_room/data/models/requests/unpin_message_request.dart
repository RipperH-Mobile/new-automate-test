class UnpinMessageRequest {
  final String pinId;
  final String roomId;

  UnpinMessageRequest({
    required this.pinId,
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }

  Map<String, dynamic> toJsonSocket() {
    return {
      'roomId': roomId,
      'pinId': pinId,
    };
  }

  @override
  String toString() => 'UnpinMessageRequest(pinId: $pinId)';
}
