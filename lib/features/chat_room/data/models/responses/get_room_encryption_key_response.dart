import 'dart:convert';

import 'package:uchat/features/chat_room/domain/entities/room_encryption_key_entity.dart';

class GetRoomEncryptionKeyResponse {
  /// Public key of the requested room.
  /// If the requested room doesn't have public key, This variable will be '{}'
  String roomPublicKey;

  GetRoomEncryptionKeyResponse({required this.roomPublicKey});

  static GetRoomEncryptionKeyResponse fromMap(Map<String, dynamic> data) {
    return GetRoomEncryptionKeyResponse(roomPublicKey: json.encode(data));
  }

  RoomEncryptionKeyEntity toEntity() {
    return RoomEncryptionKeyEntity(roomPublicKey: roomPublicKey);
  }
}