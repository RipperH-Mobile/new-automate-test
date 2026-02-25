class UnpinMessageEvent {
  final String messageRef;
  final String roomId;

  UnpinMessageEvent({
    required this.messageRef,
    required this.roomId,
  });
}
