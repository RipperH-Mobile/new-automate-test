class AcceptGroupMemberRequest {
  final String requestId;

  AcceptGroupMemberRequest({
    required this.requestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
    };
  }
}
