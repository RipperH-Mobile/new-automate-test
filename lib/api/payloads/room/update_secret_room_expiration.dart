class UpdateSecretRoomExpirationRequest {
  String roomId;
  String roomExpirationType;
  int expireIn;
  String? roomName;

  UpdateSecretRoomExpirationRequest({
    required this.roomId,
    required this.roomExpirationType,
    required this.expireIn,
    this.roomName,
  });

  Map<String, dynamic> toJson() {
    return {
      'friendAccountId': roomId,
      'roomExpirationType': roomExpirationType,
      'expireIn': expireIn,
      'roomName': roomName,
    };
  }
}
