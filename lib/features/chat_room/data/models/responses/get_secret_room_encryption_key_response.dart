import 'dart:convert';

import 'package:uchat/features/chat_room/domain/entities/secret_room_encryption_key_entity.dart';

class GetSecretRoomEncryptionKeyResponse {
  String accountPrivateKey;
  String friendPublicKey;

  GetSecretRoomEncryptionKeyResponse({
    required this.accountPrivateKey,
    required this.friendPublicKey,
  });

  static GetSecretRoomEncryptionKeyResponse fromMap(Map<String, dynamic> data) {
    return GetSecretRoomEncryptionKeyResponse(
      accountPrivateKey: json.encode(data['accountPrivateKey']),
      friendPublicKey: json.encode(data['friendPublicKey']),
    );
  }

  SecretRoomEncryptionKeyEntity toEntity() {
    return SecretRoomEncryptionKeyEntity(
      accountPrivateKey: accountPrivateKey,
      friendPublicKey: friendPublicKey,
    );
  }
}