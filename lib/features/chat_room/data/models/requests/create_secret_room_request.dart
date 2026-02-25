class CreateSecretRoomRequest {
  final String friendAccountId;
  final String? roomExpirationType;
  final int? expireIn;
  final String? roomName;

  CreateSecretRoomRequest({
    required this.friendAccountId,
    this.roomExpirationType,
    this.expireIn,
    this.roomName,
  });

  Map<String, dynamic> toJson() {
    return {
      'friendAccountId': friendAccountId,
      'roomExpirationType': roomExpirationType,
      'expireIn': expireIn,
      'roomName': roomName,
    };
  }
}
