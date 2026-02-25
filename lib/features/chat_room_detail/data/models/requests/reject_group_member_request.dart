class RejectGroupMemberRequest {
  final String requestId;

  RejectGroupMemberRequest({
    required this.requestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
    };
  }
}
