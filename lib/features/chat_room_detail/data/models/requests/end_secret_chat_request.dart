class EndSecretChatRequest {
  final String roomId;

  EndSecretChatRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}