class UpdateSecretRoomExpireAtEntity {
  final String roomId;
  final String roomExpirationType;
  final int expireIn;
  final DateTime expireAt;

  UpdateSecretRoomExpireAtEntity({
    required this.roomId,
    required this.roomExpirationType,
    required this.expireIn,
    required this.expireAt,
  });
}
