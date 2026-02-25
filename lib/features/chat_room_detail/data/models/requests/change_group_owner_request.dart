class ChangeGroupOwnerRequest {
  final String roomId;
  final String newOwnerId;

  ChangeGroupOwnerRequest({
    required this.roomId,
    required this.newOwnerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'accountId': newOwnerId,
    };
  }
}
