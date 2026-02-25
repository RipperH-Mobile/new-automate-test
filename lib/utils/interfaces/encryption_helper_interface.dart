import 'dart:io';

import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:webcrypto/webcrypto.dart';

abstract class IEncryptionHelper {
  bool isHex(String text);

  Future<String?> encrypt({
    required String text,
    required AesGcmSecretKey cryptoKey,
    required String messageRef,
  });

  Future<String?> decrypt({
    required String text,
    required AesGcmSecretKey cryptoKey,
    required String messageRef,
  });

  Future<AesGcmSecretKey> createCryptoKey({
    required String selfPrivateKeyStr,
    required String otherPublicKeyStr,
  });

  String reformatJsonData(String data);

  Future<RoomCollection?> createRoomCryptoKey(
    RoomCollection? room, {
    bool saveToLocalDb = true,
    bool useTransaction = true,
  });

  Future<RoomCollection?> createSecretRoomCryptoKey(
    RoomCollection? room, {
    bool useTransaction = true,
    bool saveToLocalDb = true,
  });

  Future<MessageCollection?> decryptMessageCollection({
    RoomCollection? room,
    required MessageCollection? message,
    required AesGcmSecretKey cryptoKey,
  });

  Future<AesGcmSecretKey> createCryptoKeyFromPbkdf2Key({
    required String password,
    required String salt,
    int keyLength = 256,
    Hash hashType = Hash.sha256,
    int iterationCount = 100000,
  });

  Future<String?> encryptLockMessageText({
    required String message,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  });

  Future<String?> decryptLockMessageText({
    required String message,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  });

  Future<File?> encryptLockMessageFile({
    required File file,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  });

  Future<File?> decryptLockMessageFile({
    required File file,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  });

  Future<AesGcmSecretKey?> getCryptoKeyObj({
    String? cryptoKey,
  });
}
