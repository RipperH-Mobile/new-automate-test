class AcceptGroupInviteRequest {
  final String roomId;

  AcceptGroupInviteRequest({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
