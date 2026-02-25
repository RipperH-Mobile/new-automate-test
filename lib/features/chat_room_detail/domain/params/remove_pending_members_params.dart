class RemovePendingMembersParams {
  final String roomId;
  final List<String> invitedAccountIds;

  RemovePendingMembersParams({
    required this.roomId,
    required this.invitedAccountIds,
  });
}

