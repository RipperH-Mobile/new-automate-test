class ReactMessageRequest {
  String msgId;
  String emojiId;

  ReactMessageRequest({
    required this.msgId,
    required this.emojiId,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageId': msgId,
      'emojiId': emojiId,
    };
  }

  @override
  String toString() => 'ReactMessageRequest(messageId: $msgId, emojiId: $emojiId)';
}
