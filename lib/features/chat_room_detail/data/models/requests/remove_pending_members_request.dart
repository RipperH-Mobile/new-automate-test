class RemovePendingMembersRequest {
  final String roomId;
  final List<String> invitedAccountIds;

  RemovePendingMembersRequest({
    required this.roomId,
    required this.invitedAccountIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'invitedAccountIds': invitedAccountIds,
    };
  }
}
