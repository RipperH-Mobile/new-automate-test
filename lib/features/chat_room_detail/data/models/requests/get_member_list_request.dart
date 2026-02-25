class GetMemberListRequest {
  final String roomId;

  GetMemberListRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}