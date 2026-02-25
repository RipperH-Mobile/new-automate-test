class DeleteAllFileWithMessageIdRequest {
  final String messageId;
  final bool useTxn;

  const DeleteAllFileWithMessageIdRequest({
    required this.messageId,
    this.useTxn = true,
  });
}
