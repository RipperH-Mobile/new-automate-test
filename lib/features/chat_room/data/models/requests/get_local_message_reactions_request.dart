class GetLocalMessageReactionsRequest {
  const GetLocalMessageReactionsRequest({
    required this.roomId,
    required this.msgId,
  });

  final String roomId;
  final String msgId;
}
