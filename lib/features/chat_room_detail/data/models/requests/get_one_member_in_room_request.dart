class GetOneMemberInRoomRequest {
  final String roomId;
  final String accountId;

  GetOneMemberInRoomRequest({
    required this.roomId,
    required this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'accountId': accountId,
    };
  }
}
