import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/params/get_room_encryption_key_params.dart';
import 'package:uchat/features/chat_room/domain/params/get_secret_room_encryption_key_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_encryption_key_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_secret_room_encryption_key_use_case.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';
import 'package:webcrypto/webcrypto.dart';

class EncryptHelper implements IEncryptionHelper {
  static final EncryptHelper instance = EncryptHelper._internal();

  factory EncryptHelper() => instance;

  EncryptHelper._internal();

  final _log = useLogger();

  final regHex = RegExp(r'^[A-Fa-f0-9]+$');

  @override
  bool isHex(String text) => regHex.hasMatch(text);

  /// encrypt string text using AES-GCM algorithm
  ///
  /// [text] is a string text to encrypt
  /// [cryptoKey] is a key used for encrypt
  /// [messageRef] is used to create iv for encrypt / decrypt process
  ///
  /// Returns encrypted string in hex format
  /// Example: "0e44d7d9ff101e9ed8aaa76b338dfa265b"
  @override
  Future<String?> encrypt({
    required String text,
    required AesGcmSecretKey cryptoKey,
    required String messageRef,
  }) async {
    Uint8List messageData = Uint8List.fromList(utf8.encode(text));
    Uint8List iv = Uint8List.fromList(messageRef.codeUnits);
    Uint8List encryptedBytes = await cryptoKey.encryptBytes(messageData, iv);
    // String encryptedString = String.fromCharCodes(encryptedBytes);
    final encryptedString = hex.encode(encryptedBytes);
    return encryptedString;
  }

  /// decrypt string text using AES-GCM algorithm
  ///
  /// [text] is a string text to decrypt
  /// [cryptoKey] is a key used for decrypt
  /// [messageRef] is used to create iv for encrypt / decrypt process
  @override
  Future<String?> decrypt({
    required String text,
    required AesGcmSecretKey cryptoKey,
    required String messageRef,
  }) async {
    try {
      Uint8List messageData;
      if (isHex(text)) {
        List<int> decryptedHex = hex.decode(text);
        messageData = Uint8List.fromList(decryptedHex);
      } else {
        messageData = Uint8List.fromList(text.codeUnits);
      }
      Uint8List iv = Uint8List.fromList(messageRef.codeUnits);
      Uint8List decryptedBytes = await cryptoKey.decryptBytes(messageData, iv);
      String decryptedString = utf8.decode(decryptedBytes);

      return decryptedString;
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'message is $text',
          additionalData: {
            'message': text,
            'cryptoKey': cryptoKey.exportJsonWebKey(),
            'messageRef': messageRef,
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      rethrow;
    }
  }

  /// Create crypto key from sender's private key and recipient's public key.
  /// crypto key is used in end to end encryption for message in chat room.
  ///
  /// key pair used in this process is made with ECDH algorithm and the P-256
  /// elliptic curve received from backend.
  ///
  /// [selfPrivateKeyStr] is sender's private key in the format of json string.
  /// example : {
  ///   "kty": "EC"
  ///   "crv": "P-256",
  ///   "x": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  ///   "y": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  /// }
  ///
  /// [otherPublicKeyStr] is recipient's public key in the format of json string.
  /// example : {
  ///   "kty": "EC"
  ///   "crv": "P-256",
  ///   "d": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  ///   "x": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  ///   "y": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  /// }
  @override
  Future<AesGcmSecretKey> createCryptoKey({
    required String selfPrivateKeyStr,
    required String otherPublicKeyStr,
  }) async {
    Map<String, dynamic> selfPrivateKeyMap = json.decode(selfPrivateKeyStr);
    Map<String, dynamic> otherPublicKeyMap = json.decode(otherPublicKeyStr);
    EcdhPrivateKey selfPrivateKey = await EcdhPrivateKey.importJsonWebKey(selfPrivateKeyMap, EllipticCurve.p256);
    EcdhPublicKey otherPublicKey = await EcdhPublicKey.importJsonWebKey(otherPublicKeyMap, EllipticCurve.p256);
    Uint8List cryptoKeyData = await selfPrivateKey.deriveBits(256, otherPublicKey);
    AesGcmSecretKey cryptoKey = await AesGcmSecretKey.importRawKey(cryptoKeyData);

    return cryptoKey;
  }

  /// Fix json data when data doesn't have double quote in key or value
  /// Example input : {kty: EC, crv: P-256, x: ItzYSJzFnsS0gyj71Y33V7J59f3zHxQERTGds1kDx7w, y: oHhgvKpIKgbUNsVsiXgYQBRSXI6or7O0b4SO2MG4wBc, d: FrNVAJrFRGTAWeDagKbfX1utoD_IuiRJDCOslblLcEo}
  /// Example output : {"kty": "EC", "crv": "P-256", "x": "ItzYSJzFnsS0gyj71Y33V7J59f3zHxQERTGds1kDx7w", "y": "oHhgvKpIKgbUNsVsiXgYQBRSXI6or7O0b4SO2MG4wBc", "d": "FrNVAJrFRGTAWeDagKbfX1utoD_IuiRJDCOslblLcEo"}
  @override
  String reformatJsonData(String data) {
    return data.replaceAllMapped(RegExp(r'(\w+):\s*([^,}]+)'), (match) => '"${match[1]}": "${match[2]}"');
  }

  /// Create room crypto key for [room]
  ///
  /// [room] is the room for create room crypto key.
  /// [saveToLocalDb] If true, Both room public key and room crypto key created in this
  /// function will be saved to local db.
  /// [useTransaction] If true, When saving room public key and room crypto key this
  /// function will use normal put function. Otherwise this function will use putWithoutTxn instead.
  ///
  /// Return [room] with updated roomPublicKey and roomCryptoKey data if this room
  /// in server has roomPublicKey. Otherwise return null.
  ///
  /// This function will also return null immediately if [room]'s roomPublicKey is '{}'.
  /// Because '{}' means that this room has already try to get roomPublicKey from server
  /// and this room doesn't have public key / use encryption. This is to prevent
  /// unnecessary call to server.
  @override
  Future<RoomCollection?> createRoomCryptoKey(
    RoomCollection? room, {
    bool saveToLocalDb = true,
    bool useTransaction = true,
  }) async {
    if (room == null) {
      _log.e(
        UChatLogMessage(
          message: 'createRoomCryptoKey-return-null',
          additionalMessage: 'room is null',
          error: Exception('createRoomCryptoKey return null because room is null'),
          stackTrace: StackTrace.current,
        ),
      );
      return null;
    }
    // If room public key is '{}' that means request to get public key has been made
    // and server response with empty {} which means this room doesn't have public key
    // and this room doesn't use encryption.
    if (room.roomPublicKey != null && room.roomPublicKey == '{}') {
      _log.e(
        UChatLogMessage(
          message: 'createRoomCryptoKey-return-null',
          additionalMessage: 'roomPublicKey is empty \'{}\'',
          additionalData: {
            'room': room.toMap(),
          },
          error:
              Exception('createRoomCryptoKey return null because roomPublicKey is empty \'{}\', room id: ${room.id}'),
          stackTrace: StackTrace.current,
        ),
      );
      return null;
    }

    // _log.d('Room: ${room.id}, RoomPublicKey: ${room.roomPublicKey}');
    try {
      // If room public key is null, Get room public key from server.
      if (room.roomPublicKey == null) {
        try {
          final response = await GetIt.I<GetRoomEncryptionKeyUseCase>().call(
            GetRoomEncryptionKeyParams(roomId: room.id!),
          );

          // response from server should be either key string if this room have public key
          // or '{}' if this room doesn't have public key
          room.roomPublicKey = response?.roomPublicKey;
        } catch (e, stackTrace) {
          _log.e(
            UChatLogMessage(
              message: 'createRoomCryptoKey-return-null',
              additionalMessage: 'failed to get room public key from server',
              additionalData: {
                'room': room.toMap(),
              },
              error: e,
              stackTrace: stackTrace,
            ),
          );
          return null;
        }
      }

      // If this room doesn't have public key save '{}' to local db to mark that this
      // room doesn't have public key.
      if (room.roomPublicKey == '{}') {
        if (saveToLocalDb) {
          if (useTransaction) {
            await GetIt.I<RoomDb>().putRoom(room);
          } else {
            await GetIt.I<RoomDb>().putRoomWithoutTxn(room);
          }
        }
        _log.e(
          UChatLogMessage(
            message: 'createRoomCryptoKey-return-null',
            additionalMessage: 'room public key from server is empty \'{}\'',
            additionalData: {
              'room': room.toMap(),
            },
            error: Exception(
                'createRoomCryptoKey return null because room public key from server is empty \'{}\', room id: ${room.id}'),
            stackTrace: StackTrace.current,
          ),
        );
        return null;
      }

      try {
        // Create crypto key.
        AesGcmSecretKey? cryptoKey;
        String? selfPrivateKey = UserController.instance.currentUser()?.privateKey;
        // Get current user private key if it is missing.
        if (selfPrivateKey == null || selfPrivateKey == '{}') {
          final res = await AccountService().getSelfEncryptionKey();
          final currentUser = UserController.instance.currentUser();
          UserController.instance.currentUser.value = currentUser?.copyWith(
            privateKey: res?.privateKey,
          );
          selfPrivateKey = res?.privateKey;
          if (selfPrivateKey == '{}') {
            _log.e(
              UChatLogMessage(
                message: 'createRoomCryptoKey-return-null',
                additionalMessage: 'selfPrivateKey from server is empty \'{}\'',
                additionalData: {
                  'room': room.toMap(),
                  'serverPrivateKey': res?.privateKey,
                },
                error: Exception(
                    'createRoomCryptoKey return null because selfPrivateKey from server is empty \'{}\', room id: ${room.id}'),
                stackTrace: StackTrace.current,
              ),
            );
            return null;
          }
          if (selfPrivateKey == null) {
            _log.e(
              UChatLogMessage(
                message: 'createRoomCryptoKey-return-null',
                additionalMessage: 'selfPrivateKey from server is null',
                additionalData: {
                  'room': room.toMap(),
                },
                error: Exception(
                    'createRoomCryptoKey return null because selfPrivateKey from server is null, room id: ${room.id}'),
                stackTrace: StackTrace.current,
              ),
            );
          }
        }

        if (selfPrivateKey != null && room.roomPublicKey != null) {
          cryptoKey = await createCryptoKey(
            selfPrivateKeyStr: selfPrivateKey,
            otherPublicKeyStr: room.roomPublicKey!,
          );
          room.roomCryptoKey = json.encode(await cryptoKey.exportJsonWebKey());
        } else {
          _log.e(
            UChatLogMessage(
              message: 'createRoomCryptoKey-return-null',
              additionalMessage: 'selfPrivateKey or roomPublicKey is null',
              additionalData: {
                'room': room.toMap(),
                'hasSelfPrivateKey': selfPrivateKey != null,
                'hasRoomPublicKey': room.roomPublicKey != null,
              },
              error: Exception(
                  'createRoomCryptoKey failed because selfPrivateKey or roomPublicKey is null, room id: ${room.id}'),
              stackTrace: StackTrace.current,
            ),
          );
        }

        if (saveToLocalDb) {
          if (useTransaction) {
            await GetIt.I<RoomDb>().putRoom(room);
          } else {
            await GetIt.I<RoomDb>().putRoomWithoutTxn(room);
          }
        }
      } catch (e, stackTrace) {
        _log.e(
          UChatLogMessage(
            message: 'createRoomCryptoKey-return-null',
            additionalMessage: 'create crypto key error',
            additionalData: {
              'room': room.toMap(),
            },
            error: e,
            stackTrace: stackTrace,
          ),
        );
        return null;
      }

      return room;
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'createRoomCryptoKey-return-null',
          additionalMessage: 'getRoomEncryptionKey failed',
          additionalData: {
            'room': room.toMap(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      return null;
    }
  }

  /// Create room crypto key for [room] using special key pair in secret chat case.
  ///
  /// [room] is the room for create room crypto key.
  /// [useTransaction] If true, When saving secret chat key and room crypto key this
  /// function will use normal put function. Otherwise this function will use putWithoutTxn instead.
  ///
  /// Return [room] with updated selfPrivateKey, otherPublicKey and roomCryptoKey data if this room's
  /// secret key is found in server. Otherwise return null.
  ///
  /// This function will also return null immediately if [room]'s selfPrivateKeu and otherPublicKey is '{}'.
  /// Because '{}' means that this room has already try to get key from server
  /// and this key is already deleted from server. This is to prevent unnecessary call to server.
  @override
  Future<RoomCollection?> createSecretRoomCryptoKey(
    RoomCollection? room, {
    bool useTransaction = true,
    bool saveToLocalDb = true,
  }) async {
    if (room == null) {
      _log.e(
        UChatLogMessage(
          message: 'createSecretRoomCryptoKey-return-null',
          additionalMessage: 'room is null',
          error: Exception('createSecretRoomCryptoKey return null because room is null'),
          stackTrace: StackTrace.current,
        ),
      );
      return null;
    }

    /// If key is '{}' that means request to get key has been made and server doesn't
    /// have this secret room's key anymore
    if (room.selfPrivateKey != null &&
        room.selfPrivateKey == '{}' &&
        room.otherPublicKey != null &&
        room.otherPublicKey == '{}') {
      _log.e(
        UChatLogMessage(
          message: 'createSecretRoomCryptoKey-return-null',
          additionalMessage: 'selfPrivateKey and otherPublicKey are empty \'{}\'',
          additionalData: {
            'room': room.toMap(),
          },
          error: Exception(
              'createSecretRoomCryptoKey return null because selfPrivateKey and otherPublicKey are empty \'{}\', room id: ${room.id}'),
          stackTrace: StackTrace.current,
        ),
      );
      return null;
    }

    /// Recheck in local db whether key is already fetch from server.
    final localRoom = await GetIt.I<RoomDb>().getRoom(room.id ?? '');
    if (localRoom != null && localRoom.roomCryptoKey != null) {
      return localRoom;
    }

    try {
      /// If [room.selfPrivateKey] and [room.otherPublicKey] is null, Get it from server.
      if (room.selfPrivateKey == null && room.otherPublicKey == null) {
        try {
          final response = await GetIt.I<GetSecretRoomEncryptionKeyUseCase>().call(
            GetSecretRoomEncryptionKeyParams(roomId: room.id!),
          );

          /// Update [room.selfPrivateKey] and [room.otherPublicKey] with response data
          room.selfPrivateKey = response?.accountPrivateKey;
          room.otherPublicKey = response?.friendPublicKey;
        } on ApiException catch (e, stackTrace) {
          _log.e(
            UChatLogMessage(
              message: 'createSecretRoomCryptoKey-return-null',
              additionalMessage: 'ApiException, type: ${e.type}',
              additionalData: {
                'room': room.toMap(),
                'apiExceptionType': e.type,
              },
              error: e,
              stackTrace: stackTrace,
            ),
          );

          if (e.type == 'ERR_ENCRYPTION_KEY_NOT_FOUND') {
            /// If [room.selfPrivateKey] and [room.otherPublicKey] doesn't have key save '{}' to local db to mark that this
            /// room doesn't have key.
            room.selfPrivateKey = '{}';
            room.otherPublicKey = '{}';

            if (saveToLocalDb) {
              if (useTransaction) {
                await GetIt.I<RoomDb>().putRoom(room);
              } else {
                await GetIt.I<RoomDb>().putRoomWithoutTxn(room);
              }
            }

            return null;
          } else {
            return null;
          }
        } catch (e, stackTrace) {
          _log.e(
            UChatLogMessage(
              message: 'createSecretRoomCryptoKey-return-null',
              additionalMessage: 'failed to get encryption key from server',
              additionalData: {
                'room': room.toMap(),
              },
              error: e,
              stackTrace: stackTrace,
            ),
          );
          return null;
        }
      }

      try {
        // Create crypto key.
        AesGcmSecretKey? cryptoKey;

        if (room.selfPrivateKey != null && room.otherPublicKey != null) {
          cryptoKey = await createCryptoKey(
            selfPrivateKeyStr: room.selfPrivateKey ?? '',
            otherPublicKeyStr: room.otherPublicKey ?? '',
          );

          room.roomCryptoKey = json.encode(await cryptoKey.exportJsonWebKey());
        }

        if (saveToLocalDb) {
          if (useTransaction) {
            await GetIt.I<RoomDb>().putRoom(room);
          } else {
            await GetIt.I<RoomDb>().putRoomWithoutTxn(room);
          }
        }
      } catch (e, stackTrace) {
        _log.e(
          UChatLogMessage(
            message: 'createSecretRoomCryptoKey-return-null',
            additionalMessage: 'create crypto key error',
            additionalData: {
              'room': room.toMap(),
            },
            error: e,
            stackTrace: stackTrace,
          ),
        );

        return null;
      }

      return room;
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'createSecretRoomCryptoKey-return-null',
          additionalMessage: 'getEncryptionKey failed',
          additionalData: {
            'room': room.toMap(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );

      return null;
    }
  }

  /// Decrypt message in [message] and also decrypt reply message if it has reply.
  ///
  /// Return [message] with updated data.
  @override
  Future<MessageCollection?> decryptMessageCollection({
    RoomCollection? room,
    required MessageCollection? message,
    required AesGcmSecretKey cryptoKey,
  }) async {
    if (message == null) return null;
    try {
      if ((message.type == MessageType.text || message.type == MessageType.image) &&
          (room?.isSecretRoom == true || message.isEncrypted == true) &&
          message.message?.isNotEmpty == true) {
        // Decrypt message
        message.message = await decrypt(
          text: message.message!,
          cryptoKey: cryptoKey,
          messageRef: message.ref!,
        );
        message.isDecryptFailed = false;
        message.isEncrypted = false;
      }
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'message is ${message.message}',
          additionalData: {
            'message': message.toMap(),
            'room': room?.toMap(),
            'cryptoKey': cryptoKey.exportJsonWebKey(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      message.isDecryptFailed = true;
    }

    try {
      // Decrypt reply message if this message has reply message.
      if (message.replyMessage != null &&
          message.replyMessage?.type == MessageType.text &&
          (room?.isSecretRoom == true || message.replyMessage?.isEncrypted == true) &&
          message.replyMessage?.message?.isNotEmpty == true) {
        message.replyMessage?.message = await decrypt(
          text: message.replyMessage!.message!,
          cryptoKey: cryptoKey,
          messageRef: message.replyMessage!.ref!,
        );
        message.replyMessage?.isDecryptFailed = false;
      }
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'reply message is ${message.message}',
          additionalData: {
            'message': message.toMap(),
            'room': room?.toMap(),
            'cryptoKey': cryptoKey.exportJsonWebKey(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      message.replyMessage?.isDecryptFailed = true;
    }

    return message;
  }

  /// Locked message encryption.

  /// Create PBKDF2 (Password-Based Key Derivation Function 2) key with password to create AES-GCM key for encryption.
  ///
  /// [password] is a readable String to be used, remember, send by user.
  /// [salt] will be used to ensured that even if two users have the same password, their derived keys will be different
  /// if different salts are used.
  /// [keyLength] define key length in bit.
  /// [hashType] a type of hash to use when creating key.
  /// Use sha256 by default, sha1 is not secure enough. sha384 and sha 512 is the most secure but take more performance
  /// to compute. sha256 is the middle point.
  /// [iterationCount] high number of iterations will slow down brute-force attacks.
  ///
  /// return AES-GCM secret key to be used to encrypt and decrypt message or file.
  @override
  Future<AesGcmSecretKey> createCryptoKeyFromPbkdf2Key({
    required String password,
    required String salt,
    int keyLength = 256,
    Hash hashType = Hash.sha256,
    int iterationCount = 100000,
  }) async {
    final keyCreator = await Pbkdf2SecretKey.importRawKey(Uint8List.fromList(password.codeUnits));
    final keyData = await keyCreator.deriveBits(
      keyLength,
      hashType,
      Uint8List.fromList(salt.codeUnits),
      iterationCount,
    );
    return await AesGcmSecretKey.importRawKey(keyData);
  }

  /// Encrypt message with key from [createCryptoKeyFromPbkdf2Key] used in feature locked message.
  ///
  /// [message] is the message to encrypt.
  /// [iv] is ref of this message. Will be used as a iv in the encryption process.
  /// [cryptoKey] is the key to be used for encryption.
  ///
  /// return encrypted string in hex format
  /// will return null on error.
  @override
  Future<String?> encryptLockMessageText({
    required String message,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  }) async {
    try {
      // Ensure to use UTF-8 encoding to handle multi-byte characters
      final messageBytes = utf8.encode(message);
      Uint8List encryptedBytes = await cryptoKey.encryptBytes(messageBytes, iv.codeUnits);

      // Convert encrypted bytes to hex format
      final encryptedString = hex.encode(encryptedBytes);

      return encryptedString;
    } catch (e, stackTrace) {
      _log.e('encryptLockedMessage error.', e, stackTrace);
      rethrow;
    }
  }

  /// Decrypt message with key from [createCryptoKeyFromPbkdf2Key] used in feature locked message.
  ///
  /// [message] is the encrypted message in hex format to decrypt.
  /// [iv] is the ref of this message. Will be used as an iv in the decryption process.
  /// [cryptoKey] is the key to be used for decryption.
  ///
  /// return decrypted message
  /// will return null on error.
  @override
  Future<String?> decryptLockMessageText({
    required String message,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  }) async {
    try {
      Uint8List messageBytes;

      // Check if the input is hex encoded and decode it
      if (isHex(message)) {
        List<int> decryptedHex = hex.decode(message);
        messageBytes = Uint8List.fromList(decryptedHex);
      } else {
        // Otherwise, use the UTF-8 encoded version
        messageBytes = Uint8List.fromList(utf8.encode(message));
      }

      // Decrypt the message
      final decryptedBytes = await cryptoKey.decryptBytes(messageBytes, iv.codeUnits);

      // Decode the bytes back to a UTF-8 string
      String decryptedString = utf8.decode(decryptedBytes);

      return decryptedString;
    } catch (e, stackTrace) {
      _log.w('decryptLockMessage error.', e, stackTrace);
      rethrow;
    }
  }

  /// Encrypt file with key from [createCryptoKeyFromPbkdf2Key] used in feature locked message.
  ///
  /// [file] is the file to encrypt.
  /// [iv] is ref of this message. Will be used as a iv in the encryption process.
  /// [cryptoKey] is the key to be used for encryption.
  ///
  /// return encrypted string in hex format
  /// will return null on error.
  @override
  Future<File?> encryptLockMessageFile({
    required File file,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  }) async {
    try {
      final fileBytes = await file.readAsBytes();
      Uint8List encryptedBytes = await cryptoKey.encryptBytes(fileBytes, iv.codeUnits);
      String filePath = '${(await getTemporaryDirectory()).path}/${file.path.split('/').last}';
      File encryptedFile = await File(filePath).writeAsBytes(encryptedBytes);

      return encryptedFile;
    } catch (e, stackTrace) {
      _log.e('encryptLockedMessageFile error.', e, stackTrace);
      return null;
    }
  }

  /// Decrypt file with key from [createCryptoKeyFromPbkdf2Key] used in feature locked message.
  ///
  /// [file] is the file to decrypt.
  /// [iv] is ref of this message. Will be used as a iv in the decryption process.
  /// [cryptoKey] is the key to be used for decryption.
  ///
  /// return decrypted string in hex format
  /// will return null on error.
  @override
  Future<File?> decryptLockMessageFile({
    required File file,
    required String iv,
    required AesGcmSecretKey cryptoKey,
  }) async {
    try {
      Uint8List messageData = await file.readAsBytes();
      final decryptedByte = await cryptoKey.decryptBytes(messageData, iv.codeUnits);
      String filePath = '${(await getTemporaryDirectory()).path}/${file.path.split('/').last}';
      File decryptedFile = await File(filePath).writeAsBytes(decryptedByte);

      return decryptedFile;
    } catch (e, stackTrace) {
      _log.e('decryptLockedMessage error.', e, stackTrace);
      return null;
    }
  }

  @override
  Future<AesGcmSecretKey?> getCryptoKeyObj({String? cryptoKey}) async {
    if (cryptoKey == null) return null;
    return await AesGcmSecretKey.importJsonWebKey(json.decode(cryptoKey));
  }
}
