class SecretRoomEncryptionKeyEntity {
  final String accountPrivateKey;
  final String friendPublicKey;

  SecretRoomEncryptionKeyEntity({
    required this.accountPrivateKey,
    required this.friendPublicKey,
  });
}