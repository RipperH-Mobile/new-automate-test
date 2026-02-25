class DeleteSessionRequest {
  final String? actionToken;
  final String? sessionId;

  DeleteSessionRequest({
    this.actionToken,
    this.sessionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'actionToken': actionToken,
      'sessionId': sessionId,
    };
  }
}
