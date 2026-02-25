class GetRoomEncryptionKeyRequest {
  String roomId;

  GetRoomEncryptionKeyRequest({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
