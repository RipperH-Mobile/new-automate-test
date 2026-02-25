import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';

class DecryptMessageTextParams {
  final MessageEntity message;

  DecryptMessageTextParams({
    required this.message,
  });
}

class DecryptMessageTextUseCase extends SimpleUseCase<MessageEntity?, DecryptMessageTextParams> {
  final LoggerService log;
  final IEncryptionHelper encryptHelper;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;

  DecryptMessageTextUseCase({
    required this.log,
    required this.encryptHelper,
    required this.chatRoomLocalRepository,
  });

  @override
  Future<MessageEntity?> call(DecryptMessageTextParams params) async {
    final roomId = params.message.roomId;
    final message = params.message;

    if (roomId == null) return params.message;

    var room = await chatRoomLocalRepository.getRoom(roomId);

    if (room == null) return params.message;

    try {
      // TODO: Move here to a room use case
      if (room.roomCryptoKey == null) {
        if (room.isSecretRoom == true) {
          // TODO: Move [EncryptHelper] to a chat room use case
          final roomWithCryptoKey = await encryptHelper.createSecretRoomCryptoKey(
            room.toCollection(),
            useTransaction: false,
          );
          if (roomWithCryptoKey != null) {
            room = roomWithCryptoKey.toEntity();
          }
        } else {
          // Create room crypto key. This code block will do nothing if this room
          // doesn't use encryption and the server doesn't have public key.
          // useTransaction: false is used because this file and function is already in writeTxn,
          // If another writeTxn is called here it will cause an error.
          final roomWithCryptoKey = await encryptHelper.createRoomCryptoKey(
            room.toCollection(),
            useTransaction: false,
          );
          if (roomWithCryptoKey != null) {
            room = roomWithCryptoKey.toEntity();
          }
        }
      }

      final roomCryptoKey = await encryptHelper.getCryptoKeyObj(cryptoKey: room.roomCryptoKey);
      var messageDecryptEntity = message;

      if (roomCryptoKey != null) {
        final messageDecrypted = await encryptHelper.decryptMessageCollection(
          room: room.toCollection(),
          message: messageDecryptEntity.toCollection(),
          cryptoKey: roomCryptoKey,
        );
        messageDecryptEntity = messageDecrypted?.toEntity() ?? messageDecryptEntity;
      } else if (message.isEncrypted == true) {
        log.e(
          UChatLogMessage(
            message: 'decrypt-message-error',
            additionalMessage: 'decrypt usecase message is ${messageDecryptEntity.message}',
            additionalData: {
              'message': messageDecryptEntity.toMap(),
              'room': room.toMap(),
              'cryptoKey': roomCryptoKey?.exportJsonWebKey(),
            },
            error: Exception('Cannot decrypt message because room crypto key is null'),
            stackTrace: StackTrace.current,
          ),
        );
        messageDecryptEntity = messageDecryptEntity.copyWith(
          isDecryptFailed: true,
        );
      } else if (messageDecryptEntity.isEncrypted == false && messageDecryptEntity.message?.isHex == true) {
        log.e(
          UChatLogMessage(
            message: 'decrypt-message-error',
            additionalMessage: 'hex message is ${messageDecryptEntity.message}',
            additionalData: {
              'message': messageDecryptEntity.toMap(),
              'room': room.toMap(),
            },
            error: Exception('Cannot decrypt message because message is not encrypted'),
            stackTrace: StackTrace.current,
          ),
        );
        messageDecryptEntity = messageDecryptEntity.copyWith(
          isDecryptFailed: false,
        );
      } else {
        // Reset isDecryptFailed to false if message is not encrypted
        messageDecryptEntity = messageDecryptEntity.copyWith(
          isDecryptFailed: false,
        );
      }

      return messageDecryptEntity;
    } catch (e, stackTrace) {
      log.e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'decrypt usecase message is $message',
          additionalData: {
            'message': message.toMap(),
            'room': room?.toMap(),
          },
          error: e,
          stackTrace: stackTrace,
        ),
      );
      rethrow;
    }
  }
}
