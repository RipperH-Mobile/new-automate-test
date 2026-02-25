class PinMessageRequest {
  final String messageId;
  final String roomId;

  PinMessageRequest({
    required this.messageId,
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
      'messageId': messageId,
    };
  }

  @override
  String toString() => 'PinMessageRequest(messageId: $messageId)';
}
