abstract class SendMessageRequestInterface {
  /// The room id where the message will be sent
  final String roomId;

  /// The ref of the message
  final String ref;

  /// Callback function that will be called when the message failed to send
  final Future<void> Function()? onSendFail;

  /// Callback function that will be called when the message failed to with ApiException type permission denied.
  final Future<void> Function()? onPermissionDenied;

  final bool? isLocked;

  final String? replyId;

  SendMessageRequestInterface({
    required this.roomId,
    required this.ref,
    this.onSendFail,
    this.onPermissionDenied,
    this.isLocked,
    this.replyId,
  });

  @override
  String toString() {
    return '[SendMessagePayloadInterface] roomId: $roomId, ref: $ref';
  }
}
