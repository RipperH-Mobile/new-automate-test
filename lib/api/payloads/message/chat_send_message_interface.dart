abstract class ChatSendMessageRequestInterface {
  String roomId;
  String ref;
  Future<void> Function()? onSendFail;

  ChatSendMessageRequestInterface({
    required this.roomId,
    required this.ref,
    this.onSendFail,
  });

  @override
  String toString() {
    return '[ChatSendMessageRequestInterface] roomId: $roomId, ref: $ref';
  }
}
