class RemoveGroupAdminRequest {
  final String roomId;
  final String accountId;

  RemoveGroupAdminRequest({
    required this.roomId,
    required this.accountId,
  });

  //toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'accountId': accountId,
    };
  }
}
