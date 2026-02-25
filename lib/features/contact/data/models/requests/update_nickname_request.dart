class UpdateNicknameRequest {
  bool isOriginalName;
  String friendAccountId;
  String? nickname;

  UpdateNicknameRequest({
    required this.isOriginalName,
    required this.friendAccountId,
    this.nickname,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'isOriginalName': isOriginalName,
      'friendAccountId': friendAccountId,
      'nickname': nickname,
    };

    return map;
  }
}
