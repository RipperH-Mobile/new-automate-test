class RemoveMemberFromChatRequest {
  final String roomId;
  final String friendId;

  RemoveMemberFromChatRequest({
    required this.roomId,
    required this.friendId,
  });

  Map<String, dynamic> toJson() {
    List<String> friendAccountIds = [friendId];
    Map<String, dynamic> json = {
      'roomId': roomId,
      'friendAccountIds': friendAccountIds,
    };

    return json;
  }
}
