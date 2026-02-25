class DeleteEncryptionKeyRequest {
  String roomId;

  DeleteEncryptionKeyRequest({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
