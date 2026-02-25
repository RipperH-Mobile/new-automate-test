class RemoveReactionRequest {
  const RemoveReactionRequest({
    required this.roomId,
    required this.msgId,
  });

  final String roomId;
  final String msgId;
}
