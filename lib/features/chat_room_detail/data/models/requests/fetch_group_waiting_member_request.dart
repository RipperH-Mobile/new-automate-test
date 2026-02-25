class FetchGroupWaitingMemberRequest {
  final String roomId;

  FetchGroupWaitingMemberRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
