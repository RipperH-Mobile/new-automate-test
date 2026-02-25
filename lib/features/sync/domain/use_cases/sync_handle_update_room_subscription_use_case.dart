import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_folder/domain/events/chat_folder_unread_update_event.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_subscription_mapper_extension.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_get_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_put_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/features/sync/domain/typedefs.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';

class SyncHandleUpdateRoomSubscriptionParams {
  final RoomSubscriptionEntity receiveRoomSubscription;
  final bool isDeleteLastMessage;
  final bool checkRoomFile;

  SyncHandleUpdateRoomSubscriptionParams({
    required this.receiveRoomSubscription,
    this.isDeleteLastMessage = false,
    this.checkRoomFile = false,
  });
}

class SyncHandleUpdateRoomSubscriptionUseCase
    extends SimpleUseCase<EventListCallback, SyncHandleUpdateRoomSubscriptionParams> {
  final LoggerService log;
  final EventBus eventBus;
  final SyncService syncService;
  final IChatRoomUtils chatRoomUtils;
  final IEncryptionHelper encryptHelper;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;
  final RoomSubscriptionLocalRepository roomSubscriptionLocalRepository;
  final RoomFileLocalRepository roomFileLocalRepository;
  final MessageLocalRepository messageLocalRepository;

  SyncHandleUpdateRoomSubscriptionUseCase({
    required this.log,
    required this.eventBus,
    required this.syncService,
    required this.chatRoomUtils,
    required this.encryptHelper,
    required this.chatRoomLocalRepository,
    required this.roomSubscriptionLocalRepository,
    required this.roomFileLocalRepository,
    required this.messageLocalRepository,
  });

  @override
  Future<EventListCallback> call(SyncHandleUpdateRoomSubscriptionParams params) async {
    final EventListCallback eventList = [];

    log.d('_updateRoomSubscription: ${params.receiveRoomSubscription}');

    var receiveRoomSubscription = params.receiveRoomSubscription;

    final roomId = receiveRoomSubscription.roomId;
    var room = (roomId != null) ? await chatRoomLocalRepository.getRoom(roomId) : null;

    // If room not found on local db but receive room subscription update,
    // then save to temp first and use this info after.
    if (room == null) {
      if (roomId != null) {
        final tempRoomSubscription = syncService.tempRoomSubscriptionList;
        // _log.i('_updateRoomSubscription > Cannot get room: ${roomSubscription.roomId!}');

        // if this room doesn't exist in roomDB save subscription data for later
        final savedUpdatedAt = tempRoomSubscription[roomId]?.updatedAt;

        if (tempRoomSubscription.containsKey(roomId) && savedUpdatedAt != null) {
          // save the latest subscription
          if (receiveRoomSubscription.updatedAt?.isAfter(savedUpdatedAt) ?? false) {
            tempRoomSubscription[roomId] = receiveRoomSubscription.toCollection();
          }
        } else {
          tempRoomSubscription[roomId] = receiveRoomSubscription.toCollection();
        }
      }

      return eventList;
    }

    final lastMessage = receiveRoomSubscription.lastMessage;

    if (lastMessage != null && receiveRoomSubscription.unreadCount != 0) {
      //NOTE. event to show blue dot in chat category
      eventList.add(
        () => eventBus.fire(
          ChatCategoryUnreadUpdateEvent(
            receiveRoomSubscription: receiveRoomSubscription.toCollection(),
          ),
        ),
      );

      eventList.add(
        () =>
            eventBus.fire(ChatFolderUnreadUpdateEvent(receiveRoomSubscription: receiveRoomSubscription.toCollection())),
      );
    }

    // Check and decrypt last message if needed
    if (lastMessage != null &&
        lastMessage.type == MessageType.text &&
        lastMessage.isEncrypted == true &&
        lastMessage.message?.isNotEmpty == true) {
      try {
        // Create room crypto key. This code block will do nothing if this room
        // doesn't use encryption and the server doesn't have public key.
        if (room.roomCryptoKey == null) {
          // useTransaction: false is used because this file and function is already in writeTxn,
          // If another writeTxn is called here it will cause an error.
          final roomWithCryptoKey = await encryptHelper.createRoomCryptoKey(room.toCollection(), useTransaction: false);

          if (roomWithCryptoKey != null) {
            room = roomWithCryptoKey.toEntity();
          }
        }
        final roomCryptoKey = await encryptHelper.getCryptoKeyObj(cryptoKey: room.roomCryptoKey);
        final latestLocalMessageEntity = await messageLocalRepository.getMessageById(id: lastMessage.id ?? '');
        final localMessage = latestLocalMessageEntity?.message ?? '';
        final message = lastMessage.message ?? '';
        final messageRef = lastMessage.ref ?? '';
        final subSequence = lastMessage.sequence ?? 0;
        final localSequence = latestLocalMessageEntity?.sequence ?? 0;

        if (subSequence >= localSequence && message.isNotEmpty && messageRef.isNotEmpty) {
          receiveRoomSubscription = receiveRoomSubscription.copyWith(
            lastMessage: lastMessage.copyWith(
              message: await encryptHelper.decrypt(
                text: message,
                cryptoKey: roomCryptoKey!,
                messageRef: messageRef,
              ),
              isDecryptFailed: false,
            ),
          );
        } else if (localMessage.isNotEmpty) {
          receiveRoomSubscription = receiveRoomSubscription.copyWith(
            lastMessage: latestLocalMessageEntity?.toModel(),
          );
        }
      } catch (e, stackTrace) {
        log.e(
          UChatLogMessage(
            message: 'decrypt-message-error',
            additionalMessage: 'sync room subscription message is ${lastMessage.message}',
            additionalData: {
              'message': lastMessage.toMap(),
              'room': room?.toMap(),
            },
            error: e,
            stackTrace: stackTrace,
          ),
        );
        receiveRoomSubscription = receiveRoomSubscription.copyWith(
          lastMessage: receiveRoomSubscription.lastMessage?.copyWith(
            isDecryptFailed: true,
          ),
        );
      }
    } else if (receiveRoomSubscription.lastMessage != null &&
        receiveRoomSubscription.lastMessage?.isEncrypted == false &&
        receiveRoomSubscription.lastMessage?.message?.isHex == true) {
      log.e(
        UChatLogMessage(
          message: 'decrypt-message-error',
          additionalMessage: 'hex message is ${receiveRoomSubscription.lastMessage?.message}',
          additionalData: {
            'message': receiveRoomSubscription.lastMessage?.toMap(),
            'room': room.toMap(),
          },
          error: Exception('Cannot decrypt message because message is not encrypted'),
          stackTrace: StackTrace.current,
        ),
      );
      receiveRoomSubscription = receiveRoomSubscription.copyWith(
        lastMessage: receiveRoomSubscription.lastMessage?.copyWith(
          isDecryptFailed: false,
        ),
      );
    } else if (receiveRoomSubscription.lastMessage != null &&
        receiveRoomSubscription.lastMessage?.isEncrypted == false) {
      // If last message is not encrypted, Reset isDecryptedFailed to false.
      receiveRoomSubscription = receiveRoomSubscription.copyWith(
        lastMessage: receiveRoomSubscription.lastMessage?.copyWith(
          isDecryptFailed: false,
        ),
      );
    }

    // Mirror room name to room sub.
    final roomName = await chatRoomUtils.getRoomName(room: room);
    final roomType = room?.roomType;

    receiveRoomSubscription = receiveRoomSubscription.copyWith(
      roomName: roomName,
      roomType: roomType,
      hasCryptoKey: roomType == RoomType.directSecret ? room?.roomCryptoKey != null : null,
    );

    RoomSubscriptionEntity? eventData;

    if (params.isDeleteLastMessage || receiveRoomSubscription.isRoomDeleted == true) {
      // Force to set lastMessage to null
      if (receiveRoomSubscription.roomId case final roomId?) {
        RoomSubscriptionEntity? newRoomSub =
            await roomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: roomId);
        if (newRoomSub != null) {
          newRoomSub = newRoomSub.copyWithEntity(receiveRoomSubscription);
          newRoomSub = newRoomSub.copyWith(
            lastMessage: null,
          );
          final roomSub = await roomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: newRoomSub,
            replaceData: true,
            useTxn: false,
          );
          eventData = roomSub;
        }
      }
    } else {
      final roomSubCollection = await roomSubscriptionLocalRepository.putRoomSubscription(
        roomSub: receiveRoomSubscription,
        useTxn: false,
      );
      eventData = roomSubCollection;
    }

    // photo and video is hidden
    if (roomId != null && params.checkRoomFile) {
      final roomHiddenList =
          await roomFileLocalRepository.getPhotosAndVideosByRoomId(GetPhotosAndVideosByRoomIdRequest(roomId: roomId));
      for (RoomFileEntity file in roomHiddenList) {
        // file.isHidden = receiveRoomSubscription.isHidden;
        file = file.copyWith(
          isHidden: receiveRoomSubscription.isHidden,
          isDownload: false, // reset download status
        );
      }
      final filesEntity = roomHiddenList.map((e) => e).toList();
      await roomFileLocalRepository.putAllRoomFiles(PutAllRoomFilesRequest(
        files: filesEntity,
        useTxn: false,
      ));

      // file is hidden
      final roomFileHiddenList = await roomFileLocalRepository.getFilesByRoomId(roomId: roomId);
      for (RoomFileEntity file in roomFileHiddenList) {
        file = file.copyWith(
          isHidden: receiveRoomSubscription.isHidden,
        );
      }

      await roomFileLocalRepository.putAllRoomFiles(PutAllRoomFilesRequest(
        files: roomFileHiddenList,
        useTxn: false,
      ));
    }

    if (eventData != null) {
      eventList.add(
        () => eventBus.fire(RoomUpdateSubscriptionEvent(roomSubscription: eventData!)),
      );
    }

    return eventList;
  }
}
