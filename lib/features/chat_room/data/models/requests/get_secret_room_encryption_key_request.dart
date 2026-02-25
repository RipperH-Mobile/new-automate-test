class GetSecretRoomEncryptionKeyRequest {
  String roomId;

  GetSecretRoomEncryptionKeyRequest({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
