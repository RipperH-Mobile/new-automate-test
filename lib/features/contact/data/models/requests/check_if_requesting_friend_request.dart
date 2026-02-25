class CheckIfRequestingFriendRequest {
  String friendAccountId;

  CheckIfRequestingFriendRequest({
    required this.friendAccountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'friendAccountId': friendAccountId,
    };
  }
}

class CheckIfRequestingFriendResponse {
  bool? isRequesting;

  CheckIfRequestingFriendResponse({
    this.isRequesting,
  });

  factory CheckIfRequestingFriendResponse.fromJson(Map<String, dynamic> json) {
    return CheckIfRequestingFriendResponse(
      isRequesting: json['isFriendRequest'],
    );
  }
}
