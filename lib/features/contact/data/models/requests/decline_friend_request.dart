class DeclineFriendRequest {
  String friendAccountId;

  DeclineFriendRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toMap() {
    return {
      'friendAccountId': friendAccountId,
    };
  }
}
