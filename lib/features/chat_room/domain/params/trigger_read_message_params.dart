class TriggerReadMessageParams {
  String roomId;
  DateTime seenMessageAt;

  TriggerReadMessageParams({
    required this.roomId,
    required this.seenMessageAt,
  });
}