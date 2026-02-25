class AddFriendInGroupRequest {
  String friendAccountId;
  String roomId;

  AddFriendInGroupRequest({
    required this.friendAccountId,
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return {
      'friendAccountId': friendAccountId,
      'roomId': roomId,
    };
  }
}
