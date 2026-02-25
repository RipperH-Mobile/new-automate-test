class OpenDirectChatRequest {
  final String friendAccountId;

  OpenDirectChatRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toJson() {
    return {'friendAccountId': friendAccountId};
  }
}
