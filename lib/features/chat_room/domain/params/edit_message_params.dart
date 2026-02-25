/// Parameter class for editing messages
class EditMessageParams {
  EditMessageParams({
    required this.roomId,
    required this.messageId,
    required this.newContent,
  });

  /// ID of the chat room
  final String roomId;

  /// ID of the message to edit
  final String messageId;

  /// New content for the message
  final String newContent;
}
