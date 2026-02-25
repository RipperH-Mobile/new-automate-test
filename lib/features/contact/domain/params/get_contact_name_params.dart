class ContactNameParams {
  final String roomId;
  final String accountId;
  final bool isShowFullName;

  const ContactNameParams({
    required this.roomId,
    required this.accountId,
    this.isShowFullName = false,
  });
}
