class UpdateSecretRoomExpireAtRequest {
  final String roomId;
  final int expireIn;

  UpdateSecretRoomExpireAtRequest({
    required this.roomId,
    required this.expireIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'expireIn': expireIn,
    };
  }
}
