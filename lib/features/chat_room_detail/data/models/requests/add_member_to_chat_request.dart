class AddMemberToChatRequest {
  final String roomId;
  final List<String> friendIdList;

  AddMemberToChatRequest({
    required this.roomId,
    required this.friendIdList,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'friendAccountIds': friendIdList,
    };
  }
}
