class ApproveGroupRequestedRequest {
  String requestId;

  ApproveGroupRequestedRequest({
    required this.requestId,
  });

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
    };
  }
}

class ApproveGroupRequestedResponse {
  final String? roomId;
  final String? accountId;
  final int? membership;
  final int? memberRequestCount;

  ApproveGroupRequestedResponse({
    this.roomId,
    this.accountId,
    this.membership,
    this.memberRequestCount,
  });

  factory ApproveGroupRequestedResponse.fromMap(Map<String, dynamic> json) {
    return ApproveGroupRequestedResponse(
      roomId: json['roomId'],
      accountId: json['accountId'],
      membership: json['membership'],
      memberRequestCount: json['memberRequestCount'],
    );
  }
}
