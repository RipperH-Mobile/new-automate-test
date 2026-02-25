class RejectGroupRequestedRequest {
  String requestId;

  RejectGroupRequestedRequest({
    required this.requestId,
  });

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
    };
  }
}
