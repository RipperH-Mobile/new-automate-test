class GetNextOwnerSuggestionRequest {
  final String roomId;
  final String accountId;

  GetNextOwnerSuggestionRequest({
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
