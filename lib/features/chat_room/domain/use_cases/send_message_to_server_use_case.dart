import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/presentation/controllers/app_share_bottom_sheet_controller.dart';
import 'package:uchat/core/services/messaging/message_queue_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_to_server_params.dart';
import 'package:uchat/features/chat_room/domain/params/remove_failed_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_failed_message_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/features/chat_room/domain/helpers/failed_message_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class SendMessageToServerUseCase extends SimpleUseCase<dynamic, SendMessageToServerParams> {
  SendMessageToServerUseCase({
    required this.roomsServerRepository,
    required this.messageServerRepository,
    // required this.roomsLocalRepository,
  });

  final ChatRoomServerRepository roomsServerRepository;
  final MessageServerRepository messageServerRepository;

  // final ChatRoomLocalRepository roomsLocalRepository;
  final RoomSubscriptionDb roomSubscriptionDb = GetIt.I<RoomSubscriptionDb>();
  final RoomDb roomDb = GetIt.I<RoomDb>();
  final MessageDb messageDb = GetIt.I<MessageDb>();
  final RoomFileDb roomFileDb = GetIt.I<RoomFileDb>();

  final _log = useLogger();

  @override
  Future<dynamic> call(SendMessageToServerParams params) async {
    SendingMsgPerformanceServiceImpl.mainTrace.start();
    // store original message before it is encrypted
    final String? originalMessage = params.message.message;
    // Step 1: Put the message to local
    final localMessage = await putMessageToLocal(params);
    // Fire event to add message to state for UI
    eventBus.fire(AddMessageToStateEvent(message: localMessage));

    // Step 2: Encrypt the message if it is a locked message
    MessageCollection updatedMessage = localMessage.copy();
    if (updatedMessage.isLocked == true && params.isShare != true) {
      final lockedMessageResult = await _lockMessage(message: updatedMessage, roomId: params.chatRoomId);
      if (lockedMessageResult != null) {
        updatedMessage = lockedMessageResult.copy();
      }
    }

    // Step 3: Encrypt the message if roomCryptoKey is provided
    // If roomCryptoKey is provided, encrypt the (possibly already locked) message
    if (params.roomCryptoKey != null && updatedMessage.message != null && updatedMessage.ref != null) {
      // Encrypt message before sending it to server
      try {
        SendingMsgPerformanceServiceImpl.encryptTrace.start();
        updatedMessage.message = await EncryptHelper.instance.encrypt(
          text: updatedMessage.message!,
          cryptoKey: params.roomCryptoKey!,
          messageRef: updatedMessage.ref!,
        );
        updatedMessage.isEncrypted = true;
        SendingMsgPerformanceServiceImpl.encryptTrace.stop();
      } catch (e, stackTrace) {
        _log.e('Encrypt message before send error.', e, stackTrace);
      }
    }

    // Step 3: Send the message to server
    // Prepare the message payload
    final sendMessageRequestPayload = SendMessageRequest(
      roomId: params.chatRoomId,
      message: updatedMessage,
      initMessage: localMessage.copy(),
      ref: updatedMessage.ref!,
      replyId: updatedMessage.replyMessage?.id,
      contactId: updatedMessage.contact?.id,
      mobileContact: updatedMessage.mobileContact,
      isEncrypted: updatedMessage.isEncrypted,
      isLocked: updatedMessage.isLocked,
      bookmarkTagId: params.bookmarkTagId,
      onPermissionDenied: () async {
        if (params.customOnPermissionDenied != null) {
          await params.customOnPermissionDenied?.call();
        }
        await onPermissionDeniedCallback(
          updatedMessage,
          params.chatRoomId,
        );
      },
      onSendFail: () async {
        if (params.customOnSendFailed != null) {
          await params.customOnSendFailed?.call();
        }
        await onSendFailCallback(
          message: updatedMessage,
          roomId: params.chatRoomId,
          originalMessage: originalMessage,
        );
      },
      loopCount: params.loopCount,
    );

    // Add the message to the queue
    await MessageQueueService.messageInstance.addMessageToQueue(
      messageRequest: sendMessageRequestPayload,
      onProcessing: onSendMessageProcessing,
    );
  }

  Future<MessageCollection> putMessageToLocal(SendMessageToServerParams params) async {
    try {
      SendingMsgPerformanceServiceImpl.putMessageToLocalTrace.start();
      final initialMessage = params.message;
      final messageRef = MessageService.instance.generateMsgUid();

      if (params.isShare) {
        final existingLocalMessage = await messageDb.getMessageById(id: initialMessage.id ?? '');
        if (existingLocalMessage != null) {
          initialMessage.message = existingLocalMessage.message;
          if (existingLocalMessage.meta != null) {
            initialMessage.meta = existingLocalMessage.meta;
          }
        }
      }

      // If the message is not a resend message, we need to set the message parameters
      // but if it is a resend message, we don't need to set the message parameters
      // because the message is already set in the resend message, then use that setup message
      if (!params.isResend) {
        initialMessage
          ..id = messageRef
          ..ref = messageRef
          ..roomId = params.chatRoomId
          ..accountId = params.accountId
          ..createdAt = DateTime.now()
          ..replyMessage = params.replyMessage
          ..isLocked = params.isLocked;
      }

      if (params.isSending) {
        initialMessage.isSending = true;
      }

      final unencryptedMessage = initialMessage.copy();
      await messageDb.putMessage(unencryptedMessage);
      SendingMsgPerformanceServiceImpl.putMessageToLocalTrace.putTraceAttributes(
        messageRef: unencryptedMessage.ref!,
        messageType: unencryptedMessage.type?.value ?? 'unknown',
        isEmoji: unencryptedMessage.meta?.isEmoji == true,
      );

      return unencryptedMessage;
    } catch (e, stackTrace) {
      _log.e('Cannot put message to local.', e, stackTrace);
      rethrow;
    } finally {
      SendingMsgPerformanceServiceImpl.putMessageToLocalTrace.stop();
    }
  }

  Future<void> onSendMessageProcessing(SendMessageRequest requestData) async {
    try {
      SendingMsgPerformanceServiceImpl.sendMessageProcessingTrace.start();
      final messageInByte = utf8.encode(requestData.message.message ?? '');

      /// Put attributes to performance trace
      final messageRef = requestData.message.ref!;
      final messageType = requestData.message.type?.value ?? 'unknown';
      final isEmoji = requestData.message.meta?.isEmoji == true;
      final messageSizeInBytes = messageInByte.length;
      final loopCount = requestData.loopCount;
      SendingMsgPerformanceServiceImpl.mainTrace.putTraceAttributes(
        messageRef: messageRef,
        messageType: messageType,
        isEmoji: isEmoji,
        messageSizeInBytes: messageSizeInBytes,
        loopCount: loopCount,
      );
      SendingMsgPerformanceServiceImpl.sendMessageProcessingTrace.putTraceAttributes(
        messageRef: messageRef,
        messageType: messageType,
        isEmoji: isEmoji,
        messageSizeInBytes: messageSizeInBytes,
        loopCount: loopCount,
      );

      final msgResp = await messageServerRepository.sendMessage(requestData);

      final responseMessageCollection = msgResp?.message?.toCollection();
      if (responseMessageCollection == null) {
        // must have a message response if the message is sent
        // if the message is not sent, call the onSendFail callback
        requestData.onSendFail?.call();
        return;
      }

      // Update recently used sticker after message is sent successfully because requirement is save sticker history
      // only when message sent successfully.
      if (responseMessageCollection.type == MessageType.sticker) {
        final packId = responseMessageCollection.meta?.stickerPack;
        final stickerValue = responseMessageCollection.meta?.stickerValue;
        if (packId != null && stickerValue != null) {
          try {
            await StickerController.instance.updateRecentlyUsedSticker(packId, stickerValue);
          } catch (e, stackTrace) {
            _log.e('Update recently used sticker error.', e, stackTrace);
          }
        }
      }
      MessageCollection messageFromResp = responseMessageCollection;
      messageFromResp.isSending = false;

      // If message is encrypted, decrypt it first before saving it to
      // state or local db
      final roomId = messageFromResp.roomId;
      if (roomId == null) {
        throw Exception('Room ID is null in the message response.');
      }
      final room = await roomDb.getRoom(roomId);
      try {
        final roomCryptoKey = await room?.getRoomCryptoKeyObj();
        if (roomCryptoKey != null) {
          final result = (await EncryptHelper.instance.decryptMessageCollection(
            message: messageFromResp,
            cryptoKey: roomCryptoKey,
            room: room,
          ));
          if (result == null) {
            throw Exception('Decrypt message failed.');
          }
          messageFromResp = result;
        }
      } catch (e, stackTrace) {
        _log.e('decrypt message error.', e, stackTrace);
        rethrow;
      }

      await messageDb.putMessage(messageFromResp);
      final message = await messageDb.getMessageById(
        id: messageFromResp.id!,
      );

      final roomSub = await roomSubscriptionDb.getRoomSubscriptionWithRoomId(requestData.roomId);
      if (roomSub != null) {
        final messageSequence = message?.sequence ?? 0;

        final lastMessage = roomSub.lastMessage;
        final mySequence = lastMessage?.sequence ?? 0;

        if (lastMessage == null || messageSequence > mySequence) {
          roomSub.lastMessage = message!.toModel();
          await roomSubscriptionDb.putRoomSubscription(roomSub);
          eventBus.fire(
            RoomUpdateSubscriptionEvent(
              roomSubscription: roomSub.toEntity(),
            ),
          );
        }
      }

      if (message != null) {
        final messageType = message.type;
        if (messageType == null) {
          throw Exception('Message type is null in the message response.');
        }

        /// If this message has file, save that file data to local db
        String mediaType = EventProperty.getMessageTypeForEventParams(messageType);
        if ([MessageType.image, MessageType.video, MessageType.file].contains(messageType) &&
            message.files != null &&
            message.isLocked != true) {
          final files = RoomFileCollection.fromMessageCollection(
            message,
          );

          await roomFileDb.putAllRoomFileWithoutTxn(files);
        }

        GetIt.I<TaxonomyService>().sendEvent(
          EventName.messageReceived,
          eventProperties: EventProperty.messageReceived(
            EventProperty.getChatTypeForEventParams(room),
            mediaType,
          ),
        );

        eventBus.fire(MessageUpdateEvent(message: message));

        await hideFailedMessageIndicatorIfNeeded(
          roomId: roomId,
          messageDb: messageDb,
          room: room,
        );
      }
    } on DioException catch (e, stackTrace) {
      _log.d('Cannot send message.', e, stackTrace);

      if (e.type != DioExceptionType.cancel) {
        /// If the error is not a cancel error, we need to remove the file from the queue
        /// and update the message with onSendFail function
        requestData.onSendFail?.call();
      }

      GetIt.I<TaxonomyService>().sendEvent(EventName.chatErrorOccurred,
          eventProperties: EventProperty.appErrorOccurred(errorType: e.type.toString(), errorMessage: e.message));
    } on ApiException catch (e, stackTrace) {
      _log.d('Cannot send message.', e, stackTrace);
      final errorType = ApiExceptionType.from(e.type);
      GetIt.I<TaxonomyService>().sendEvent(EventName.chatErrorOccurred,
          eventProperties: EventProperty.appErrorOccurred(errorType: errorType, errorMessage: e.message));

      if (errorType == ApiExceptionType.messageRefDuplicateError) {
        // if the error is a message ref duplicate error, we need to update the message
        // by set the isSendFailed to false and isSending to false and put the message to local db
        // and fire the event to update the message in state to show the message as sent
        final sentMessage = requestData.initMessage.copy();
        sentMessage.isSendFailed = false;
        sentMessage.isSending = false;
        eventBus.fire(MessageUpdateEvent(message: sentMessage));
      } else if (errorType == ApiExceptionType.permissionDenied) {
        requestData.onPermissionDenied?.call();
      } else {
        requestData.onSendFail?.call();
        rethrow;
      }
    } catch (e, stackTrace) {
      _log.e('Cannot sendMessage.', e, stackTrace);
      requestData.onSendFail?.call();
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.chatErrorOccurred,
        eventProperties: EventProperty.appErrorOccurred(errorType: 'unknown', errorMessage: stackTrace.toString()),
      );
      rethrow;
    } finally {
      SendingMsgPerformanceServiceImpl.mainTrace.stop();
    }
  }

  Future<MessageCollection?> _lockMessage({
    required MessageCollection message,
    required String roomId,
  }) async {
    final roomSubscription = await roomSubscriptionDb.getRoomSubscriptionWithRoomId(roomId);
    if (roomSubscription == null) {
      _log.e('No room subscription found for room: $roomId');
      return null;
    }

    if (roomSubscription.password == null) {
      _log.e('No password found for room subscription: $roomId');
      return null;
    }

    const uuid = Uuid();
    final salt = uuid.v4();
    final iv = uuid.v4();

    // update message meta
    message.meta ??= MessageMetaModel();
    message.meta?.lockMessageSalt = salt;
    message.meta?.lockMessageIv = iv;

    final password = roomSubscription.password;
    if (password == null) return null;
    // Create locked message crypto key and encrypt the message
    final lockedKey = await EncryptHelper.instance.createCryptoKeyFromPbkdf2Key(
      password: password,
      salt: salt,
    );

    // There isn't any data in type sticker and contact that can be encrypt without breaking some process in server side.
    // type sticker and contact will use lockMessageData to encrypt / decrypt to validate password.
    final messageType = message.type;
    if (messageType == MessageType.text) {
      // Encrypt the message text
      final encryptedLockedMessage = await EncryptHelper.instance.encryptLockMessageText(
        message: message.message ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.message = encryptedLockedMessage;
    } else if (messageType == MessageType.mobileContact) {
      // Encrypt the contact name and phone number for mobile contact
      final name = await EncryptHelper.instance.encryptLockMessageText(
        message: message.mobileContact?.displayName ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      final phoneNumber = await EncryptHelper.instance.encryptLockMessageText(
        message: message.mobileContact?.phoneNumber ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.mobileContact?.displayName = name;
      message.mobileContact?.phoneNumber = phoneNumber;
    } else if (message.type == MessageType.contact) {
      // Encrypt the contact id for contact

      // type contact only have contact id data sent to server and there isn't any data to encrypt.
      // because all contact data come from server.
      // lock data is save in lockMessageData for using in decryption to check password.
      final lockData = await EncryptHelper.instance.encryptLockMessageText(
        message: message.contact?.id ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.lockMessageData = lockData;
    } else if (message.type == MessageType.gif) {
      // Encrypt the gif data
      final gifMp4Url = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.gifMp4Url ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.gifMp4Url = gifMp4Url;
      final gifUrl = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.gifUrl ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.gifUrl = gifUrl;
      final gifWebpUrl = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.gifWebpUrl ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.gifWebpUrl = gifWebpUrl;
      final giphyId = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.giphyId ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.giphyId = giphyId;
    } else if (message.type == MessageType.sticker) {
      // Encrypt the sticker data

      // stickerPack and stickerValue can't be encrypt because server need it.
      // lock data is save in lockMessageData for using in decryption to check password.
      final lockData = await EncryptHelper.instance.encryptLockMessageText(
        message: '${message.meta?.stickerPack}/${message.meta?.stickerValue}',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.lockMessageData = lockData;
    } else if (message.type == MessageType.location) {
      // Encrypt the location data
      final locationName = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.locationName ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.locationName = locationName;
      final locationVicinity = await EncryptHelper.instance.encryptLockMessageText(
        message: message.meta?.locationVicinity ?? '',
        iv: iv,
        cryptoKey: lockedKey,
      );
      message.meta?.locationVicinity = locationVicinity;
    }

    return message;
  }

  /// Callback when sending failed.
  ///
  /// This callback is used to update the message state when sending failed.
  Future<void> onSendFailCallback({
    required String roomId,
    required MessageCollection message,
    required String? originalMessage,
  }) async {
    try {
      // check if the message is still in sending state
      // if message id is null or message id is equal to message ref, it means the message is still in sending state
      if (roomId == message.roomId && (message.id == null || message.id == message.ref)) {
        message.isSending = false;
        message.isSendFailed = true;

        // Update state in RoomsController to show failed message.
        eventBus.fire(ToggleFailedMessageEvent(roomId: roomId, show: true));
        message.message = originalMessage;
        await messageDb.putMessage(message);
        // Fire event to add failed message to state for UI
        eventBus.fire(AddFailedMessageToStateEvent(message: message));
      }
    } catch (e, stackTrace) {
      _log.w('Cannot update failed message.', e, stackTrace);
    }
  }

  Future<void> onPermissionDeniedCallback(
    MessageCollection message,
    String roomId,
  ) async {
    try {
      // If sent message failed because of permission denied, Do not call onSendFail to show failed message in chat room
      // and remove the failed message from message list because showing resend option and then resend again will get permission denied again.
      final sentMessage = message.copy();
      if (Get.isRegistered<MessageListController>(tag: 'chat-room-$roomId')) {
        await Get.find<MessageListController>(tag: 'chat-room-$roomId').onRemoveFailedMessage(sentMessage);
        if (!Get.isRegistered<AppShareBottomSheetController>()) {
          // Do not show dialog only if sending message from share bottom sheet because it can show multiple dialog if share
          // to multiple room with permission denied. The error dialog will be handle from share use case.
          UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        }
      } else {
        await GetIt.I<RemoveFailedMessageUseCase>().call(RemoveFailedMessageParams(message: sentMessage));
      }
    } catch (e, stackTrace) {
      _log.w('Cannot update permission denied message.', e, stackTrace);
    }
  }
}
