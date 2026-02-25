import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/pin_message_db.dart';
import 'package:uchat/features/chat_room/data/models/mapper/pin_message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_messages_local_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_local_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/watch_pin_messages_in_room_local_request.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';
import 'package:webcrypto/webcrypto.dart';

/// Helper class to store room and crypto key data
class _CryptoKeyData {
  final RoomEntity room;
  final AesGcmSecretKey cryptoKey;

  _CryptoKeyData({
    required this.room,
    required this.cryptoKey,
  });
}

class PinMessageLocalRepositoryImpl implements PinMessageLocalRepository {
  PinMessageLocalRepositoryImpl({
    required this.pinMessageDb,
    required this.messageDb,
    required this.chatRoomLocalRepository,
    required this.encryptHelper,
  });

  final PinMessageDb pinMessageDb;
  final MessageDb messageDb;
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final IEncryptionHelper encryptHelper;

  final _log = useLogger();

  @override
  Future<void> pinMessage(PinMessageLocalRequest request, {bool useTxn = true}) async {
    // Handle encryption/decryption before saving
    var pinMessageToSave = request.pinMessage;
    final messageId = request.pinMessage.message?.id;

    if (messageId != null) {
      pinMessageToSave = await _handleEncryptionForPinMessage(
        request.pinMessage,
        messageId,
        useTransaction: useTxn,
      );
    }

    if (useTxn) {
      if (messageId != null) {
        await messageDb.pinMessage(messageId);
      }
      await pinMessageDb.pinMessage(pinMessageToSave.toCollection());
    } else {
      if (messageId != null) {
        await messageDb.pinMessageNoTxn(messageId);
      }
      await pinMessageDb.pinMessageNoTxn(pinMessageToSave.toCollection());
    }
  }

  @override
  Future<void> pinMessages(PinMessagesLocalRequest request) async {
    // Handle encryption/decryption for each pin message before saving
    final decryptedPinMessages = <PinMessageEntity>[];

    for (final pinMessage in request.pinMessages) {
      final roomId = pinMessage.message?.roomId;
      if (roomId != null) {
        // Create a temporary response to use our encryption handler
        final tempResponse = PaginationPayload<PinMessageEntity>(
          data: [pinMessage],
          total: 1,
          page: 1,
          pageSize: 1,
          totalPages: 1,
        );

        final decryptedResponse = await _handleEncryptionForPinMessages(tempResponse, roomId);
        if (decryptedResponse.data?.isNotEmpty == true) {
          decryptedPinMessages.add(decryptedResponse.data!.first);
        }
      } else {
        decryptedPinMessages.add(pinMessage);
      }
    }

    final messageIds = decryptedPinMessages.map((e) => e.message?.id).whereType<String>().toList();
    if (messageIds.isNotEmpty) {
      await messageDb.pinMessages(messageIds);
    }
    await pinMessageDb.putAllPinMessages(
      decryptedPinMessages.map((e) => e.toCollection()).toList(),
    );
  }

  @override
  Future<void> unpinMessage(UnpinMessageRequest request, {bool useTxn = true}) async {
    final pinedMessage = await pinMessageDb.getById(request.pinId);
    final messageId = pinedMessage?.message?.id;
    if (useTxn) {
      if (messageId != null) {
        await messageDb.unpinMessage(messageId);
      }
      await pinMessageDb.unpinMessage(request.pinId);
    } else {
      if (messageId != null) {
        await messageDb.unpinMessageNoTxn(messageId);
      }
      await pinMessageDb.unpinMessageNoTxn(request.pinId);
    }
  }

  @override
  Future<void> unpinAllMessagesInRoom(UnpinAllMessagesRequest request, {bool useTxn = true}) async {
    if (useTxn) {
      await messageDb.unpinAllMessagesInRoom(request.roomId);
      await pinMessageDb.unpinAllMessagesInRoom(request.roomId);
    } else {
      await messageDb.unpinAllMessagesInRoomNoTxn(request.roomId);
      await pinMessageDb.unpinAllMessagesInRoomNoTxn(request.roomId);
    }
  }

  @override
  Future<PaginationPayload<PinMessageEntity>> getPinMessagesInRoom(GetPinMessagesRequest request) async {
    final collections = await pinMessageDb.getPinMessagesInRoom(
      roomId: request.roomId,
    );
    final entities = collections.toEntities();
    final total = entities.length;

    final response = PaginationPayload<PinMessageEntity>(
      data: entities,
      total: entities.length,
      page: 1,
      pageSize: 20,
      totalPages: (total / 20).ceil(),
    );

    return response;
  }

  @override
  Stream<PaginationPayload<PinMessageEntity>> watchPinMessagesInRoom(WatchPinMessagesInRoomLocalRequest request) {
    return pinMessageDb
        .watchPinMessagesInRoom(
      roomId: request.roomId,
      pageSize: request.pageSize,
    )
        .map((collections) {
      final entities = collections.toEntities();
      final total = collections.length;
      return PaginationPayload<PinMessageEntity>(
        data: entities,
        total: total,
        page: 1,
        pageSize: 20,
        totalPages: (total / 20).ceil(),
      );
    });
  }

  @override
  Future<PinMessageEntity> getPinMessageByRef(String ref) async {
    final collection = await pinMessageDb.getByRef(ref);
    if (collection == null) {
      throw NullResponseException();
    }
    final entity = collection.toEntity();

    // Handle encryption/decryption for the pinned message
    final messageId = entity.message?.id;
    if (messageId != null) {
      return await _handleEncryptionForPinMessage(entity, messageId);
    }

    return entity;
  }

  /// Handles encryption/decryption for pinned messages
  Future<PinMessageEntity> _handleEncryptionForPinMessage(
    PinMessageEntity response,
    String messageId, {
    bool useTransaction = true,
  }) async {
    // Extract room ID from the pinned message if available
    final roomId = response.message?.roomId;
    if (roomId == null || response.message?.isEncrypted == false) {
      return response;
    }

    // Get room and crypto key
    final cryptoKeyData = await _getRoomCryptoKey(
      roomId,
      useTransaction: useTransaction,
    );
    if (cryptoKeyData == null) {
      return response;
    }

    // Decrypt message
    final decryptedMessagesResult = await _decryptMessage(
      message: response.message,
      room: cryptoKeyData.room,
      cryptoKey: cryptoKeyData.cryptoKey,
    );

    return response.copyWith(
      message: decryptedMessagesResult,
    );
  }

  /// Handles encryption/decryption for multiple pinned messages
  Future<PaginationPayload<PinMessageEntity>> _handleEncryptionForPinMessages(
    PaginationPayload<PinMessageEntity> response,
    String roomId,
  ) async {
    // Get room and crypto key
    final cryptoKeyData = await _getRoomCryptoKey(roomId);
    if (cryptoKeyData == null) {
      return response;
    }

    // Process each pinned message for encryption
    final decryptedPinMessages = <PinMessageEntity>[];

    for (final pinMessage in response.data ?? <PinMessageEntity>[]) {
      // Skip if message is not encrypted
      if (pinMessage.message?.isEncrypted == false) {
        decryptedPinMessages.add(pinMessage);
        continue;
      }

      // Decrypt message directly using shared logic
      final decryptedMessageEntity = await _decryptMessage(
        message: pinMessage.message,
        room: cryptoKeyData.room,
        cryptoKey: cryptoKeyData.cryptoKey,
      );

      final decryptedPinMessage = pinMessage.copyWith(
        message: decryptedMessageEntity,
      );
      decryptedPinMessages.add(decryptedPinMessage);
    }

    return PaginationPayload<PinMessageEntity>(
      data: decryptedPinMessages,
      total: response.total,
      page: response.page,
      pageSize: response.pageSize,
      totalPages: response.totalPages,
    );
  }

  /// Gets room crypto key data for encryption/decryption
  Future<_CryptoKeyData?> _getRoomCryptoKey(String roomId, {bool useTransaction = true}) async {
    // Check room crypto key
    RoomEntity? room = await chatRoomLocalRepository.getRoom(roomId);

    // If room doesn't use encryption, return null
    if (room?.isSecretRoom != true && room?.roomCryptoKey == null) {
      return null;
    }

    if (room?.isSecretRoom == true) {
      // Create room crypto key for secret chat.
      if (room?.roomCryptoKey == null) {
        final roomWithCryptoKey = await encryptHelper.createSecretRoomCryptoKey(
          room?.toCollection(),
          useTransaction: useTransaction,
        );
        if (roomWithCryptoKey != null) {
          room = roomWithCryptoKey.toEntity();
        }
      }
    } else {
      // Create room crypto key. This code block will do nothing if this room
      // doesn't use encryption and the server doesn't have public key.
      final roomWithCryptoKey = await encryptHelper.createRoomCryptoKey(
        room?.toCollection(),
        useTransaction: useTransaction,
      );
      if (roomWithCryptoKey != null) {
        room = roomWithCryptoKey.toEntity();
      }
    }

    final roomCryptoKey = await encryptHelper.getCryptoKeyObj(cryptoKey: room?.roomCryptoKey);
    if (roomCryptoKey != null && room != null) {
      return _CryptoKeyData(room: room, cryptoKey: roomCryptoKey);
    }

    return null;
  }

  /// Decrypts a message entity
  Future<MessageEntity?> _decryptMessage({
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
      _log.e('Decrypt message error.', e, stackTrace);
      return null;
    }
  }
}
