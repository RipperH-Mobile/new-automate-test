import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_param.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';
import 'package:webcrypto/webcrypto.dart';

/// Get message from server
///
/// This use case is used to get message from server by calling the API.
/// And after that, the response will be saved to local database.
///
/// The response will be a [GetMessageFromServerResponse] object.
class GetMessageFromServerUseCase extends SimpleUseCase<List<MessageEntity>?, GetMessageFromServerParam> {
  final LoggerService log;
  final IEncryptionHelper encryptHelper;
  final MessageLocalRepository messageLocalRepository;
  final MessageServerRepository messageServerRepository;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;

  GetMessageFromServerUseCase({
    required this.log,
    required this.encryptHelper,
    required this.messageLocalRepository,
    required this.messageServerRepository,
    required this.chatRoomLocalRepository,
  });

  @override
  Future<List<MessageEntity>?> call(GetMessageFromServerParam params) async {
    var request = GetMessageFromServerParams(
      roomId: params.roomId,
      pageSize: params.pageSize,
      isMyNote: params.isMyNote,
      bookmarkTagId: params.bookmarkTagId,
    );

    // Get latest message from local
    if (params.onlyAfter) {
      try {
        final latestMessageEntity = await messageLocalRepository.getLastSequenceByRoom(params.roomId);

        if (latestMessageEntity != null) {
          request = request.copyWith(
            afterSequence: latestMessageEntity.sequence,
          );
        }
      } catch (e, stackTrace) {
        // If error, just log it
        log.i('Get last sequence by room error.', e, stackTrace);
      }
    }

    RoomSubscriptionEntity? roomSub;

    // Get oldest message from local
    if (params.onlyPrevious) {
      try {
        int? oldestMessageSeq;

        roomSub = await GetIt.I<RoomSubLocalRepository>().getRoomSubscriptionWithRoomId(params.roomId);
        oldestMessageSeq = roomSub?.oldestMsgSeq;

        if (oldestMessageSeq == null) {
          final oldestMessageEntity = await messageLocalRepository.getFirstSequenceByRoom(params.roomId);
          oldestMessageSeq = oldestMessageEntity?.sequence;
        }

        request = request.copyWith(beforeSequence: oldestMessageSeq);
      } catch (e, stackTrace) {
        // If error, just log it
        log.i('Get first sequence by room error.', e, stackTrace);
      }
    }

    try {
      final getMessageResult = await messageServerRepository.getMessageInRoom(request);
      var messages = getMessageResult?.messages ?? [];
      if (messages.isNotEmpty == true) {
        // Check room crypto key
        RoomEntity? room = await chatRoomLocalRepository.getRoom(params.roomId);

        if (room?.isSecretRoom == true) {
          // Create room crypto key for secret chat.
          if (room?.roomCryptoKey == null) {
            final roomWithCryptoKey = await encryptHelper.createSecretRoomCryptoKey(room?.toCollection());
            if (roomWithCryptoKey != null) {
              room = roomWithCryptoKey.toEntity();
            }
          }
        } else {
          // Create room crypto key. This code block will do nothing if this room
          // doesn't use encryption and the server doesn't have public key.
          final roomWithCryptoKey = await encryptHelper.createRoomCryptoKey(room?.toCollection());
          if (roomWithCryptoKey != null) {
            room = roomWithCryptoKey.toEntity();
          }
        }

        final roomCryptoKey = await encryptHelper.getCryptoKeyObj(cryptoKey: room?.roomCryptoKey);
        if (roomCryptoKey != null) {
          // Decrypt messages
          final decryptedMessagesResult = await Future.wait<MessageEntity?>([
            for (int i = 0; i < messages.length; i++)
              decryptMessage(message: messages[i], room: room, cryptoKey: roomCryptoKey),
          ]);

          messages = decryptedMessagesResult.nonNulls.toList();
        }

        /// Update roomSub [oldestMsgSeq]
        if (roomSub != null) {
          final updatedRoomSub = roomSub.copyWith(
            oldestMsgSeq: messages.lastOrNull?.sequence,
          );

          await GetIt.I<RoomSubLocalRepository>().putRoomSubscription(updatedRoomSub);
          eventBus.fire(RoomUpdateSubscriptionEvent(roomSubscription: updatedRoomSub));
        }

        // Convert collections to entities for the repository
        final messageEntities = messages.map((m) => m).toList();

        // Save messages to local
        await messageLocalRepository.putAllMessages(messages: messageEntities);
      }

      return messages;
    } catch (e, stackTrace) {
      log.e('Get messages from server error.', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  Future<MessageEntity?> decryptMessage({
    required MessageEntity? message,
    required RoomEntity? room,
    required AesGcmSecretKey cryptoKey,
  }) async {
    if (message == null || room == null) {
      return null;
    }

    try {
      final decryptedMessage = await encryptHelper.decryptMessageCollection(
        message: message.toCollection(),
        room: room.toCollection(),
        cryptoKey: cryptoKey,
      );

      return decryptedMessage?.toEntity();
    } catch (e, stackTrace) {
      log.e('Decrypt message error.', e, stackTrace);
      return null;
    }
  }
}
