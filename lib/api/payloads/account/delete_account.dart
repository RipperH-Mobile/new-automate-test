class DeleteAccountRequest {
  String actionToken;
  int? isarId;

  DeleteAccountRequest({
    required this.actionToken,
    this.isarId,
  });

  Map<String, dynamic> toMap() {
    return {
      'actionToken': actionToken,
    };
  }
}
