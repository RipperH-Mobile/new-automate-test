class GetOneMemberInAnyRoomRequest {
  final String accountId;

  GetOneMemberInAnyRoomRequest({
    required this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
    };
  }
}
