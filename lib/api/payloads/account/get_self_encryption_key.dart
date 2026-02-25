import 'dart:convert';

class GetSelfEncryptionKeyRequest {}

class GetSelfEncryptionKeyResponse {
  String privateKey;

  GetSelfEncryptionKeyResponse({
    required this.privateKey,
  });

  static GetSelfEncryptionKeyResponse fromMap(Map<String, dynamic> data) {
    return GetSelfEncryptionKeyResponse(
      privateKey: json.encode(data),
    );
  }
}
