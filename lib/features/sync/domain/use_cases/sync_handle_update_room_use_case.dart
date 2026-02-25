import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_room_subscription_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';

import '../typedefs.dart';
import 'sync_handle_update_has_first_other_in_room_use_case.dart';

class SyncHandleUpdateRoomParams {
  final RoomCollection receiveRoom;
  final RoomSubscriptionCollection? roomSubInRoom;
  final bool isNewRoom;

  SyncHandleUpdateRoomParams({
    required this.receiveRoom,
    this.roomSubInRoom,
    this.isNewRoom = false,
  });
}

class SyncHandleUpdateRoomUseCase extends SimpleUseCase<EventListCallback, SyncHandleUpdateRoomParams> {
  RoomDb get _roomDb {
    return GetIt.I<RoomDb>();
  }

  RoomSubscriptionDb get _roomSubDb {
    return GetIt.I<RoomSubscriptionDb>();
  }

  SyncService get _syncService {
    return GetIt.I<SyncService>();
  }

  SyncHandleUpdateRoomSubscriptionUseCase get _handleUpdateRoomSubscriptionUseCase {
    return GetIt.I<SyncHandleUpdateRoomSubscriptionUseCase>();
  }

  SyncHandleUpdateHasFirstOtherInRoomUseCase get _updateHasFirstOtherInRoom {
    return GetIt.I<SyncHandleUpdateHasFirstOtherInRoomUseCase>();
  }

  FetchRoomMemberUseCase get _fetchRoomMemberUseCase {
    return GetIt.I<FetchRoomMemberUseCase>();
  }

  @override
  Future<EventListCallback> call(SyncHandleUpdateRoomParams params) async {
    final EventListCallback eventList = [];

    final roomId = params.receiveRoom.id;
    if (roomId == null) {
      return [];
    }

    RoomCollection receiveRoom = params.receiveRoom;

    final room = await _roomDb.getRoom(roomId);
    if (room == null || params.isNewRoom) {
      final tempRoomSubscriptionList = _syncService.tempRoomSubscriptionList;
      final tempRoomSubscription = tempRoomSubscriptionList[roomId];

      // if this is new room and last message in subscription isn't decrypted yet
      if (tempRoomSubscription != null) {
        final eventCb = await _handleUpdateRoomSubscriptionUseCase.call(SyncHandleUpdateRoomSubscriptionParams(
          receiveRoomSubscription: tempRoomSubscription.toEntity(),
          checkRoomFile: false,
        ));
        eventList.addAll(eventCb);

        tempRoomSubscriptionList.remove(receiveRoom.id);
      }

      // Create room crypto key. This code block will do nothing if this room
      // doesn't use encryption and the server doesn't have public key.
      // useTransaction: false is used because this file and function is already in writeTxn,
      // If another writeTxn is called here it will cause an error.
      final roomWithCryptoKey = await EncryptHelper.instance.createRoomCryptoKey(receiveRoom, useTransaction: false);
      if (roomWithCryptoKey != null) {
        receiveRoom = roomWithCryptoKey;
      }

      final roomSubInRoom = params.roomSubInRoom;
      if (roomSubInRoom != null) {
        final lastMessage = roomSubInRoom.lastMessage;

        // If message need to be decrypted
        if (lastMessage != null &&
            lastMessage.type == MessageType.text &&
            lastMessage.isEncrypted == true &&
            lastMessage.message?.isNotEmpty == true) {
          try {
            final romCryptoKey = await receiveRoom.getRoomCryptoKeyObj();
            final messageRef = lastMessage.ref;
            final message = lastMessage.message;

            if (messageRef == null || message == null) {
              useLogger().e(
                'Cannot decrypt message because message ref or message is null, room id: ${receiveRoom.id}',
              );
              return eventList;
            }

            // Decrypt message before saving it to local db
            if (romCryptoKey != null) {
              roomSubInRoom.lastMessage?.message = await EncryptHelper.instance.decrypt(
                text: message,
                cryptoKey: romCryptoKey,
                messageRef: messageRef,
              );
              roomSubInRoom.lastMessage?.isDecryptFailed = false;
            } else {
              useLogger().e(
                UChatLogMessage(
                  message: 'decrypt-message-error',
                  additionalMessage: 'roomsub message is ${lastMessage.message}',
                  additionalData: {
                    'message': lastMessage.toMap(),
                    'room': receiveRoom.toMap(),
                    'cryptoKey': romCryptoKey?.exportJsonWebKey(),
                  },
                  error: Exception('Cannot decrypt message because room crypto key is null'),
                  stackTrace: StackTrace.current,
                ),
              );
              roomSubInRoom.lastMessage?.isDecryptFailed = true;
            }
          } catch (e, stackTrace) {
            useLogger().e(
              UChatLogMessage(
                message: 'decrypt-message-error',
                additionalMessage: 'roomsub message is ${lastMessage.message}',
                additionalData: {
                  'message': lastMessage.toMap(),
                  'room': receiveRoom.toMap(),
                },
                error: e,
                stackTrace: stackTrace,
              ),
            );
            roomSubInRoom.lastMessage?.isDecryptFailed = true;
          }
        }

        // Update or put room subscription
        await _roomSubDb.putRoomSubscriptionWithoutTxn(roomSubInRoom);
        eventList.add(() => eventBus.fire(NewRoomAfterDeleteEvent(roomId: receiveRoom.id!)));
      }

      final eventData = await _roomDb.putRoomWithoutTxn(receiveRoom);

      if (eventData != null) {
        eventList.add(() => eventBus.fire(RoomNewEvent(room: eventData)));
      }
    } else {
      room.update(receiveRoom, ignoreMySubscription: true);
      if (room.isSecretRoom == true && room.expireAt?.isBefore(DateTime.now()) == true) {
        room.draftMessage = null;
        room.draftReplyMessage = null;
      }

      final eventData = await _roomDb.putRoomWithoutTxn(room, replaceData: true);
      if (eventData != null) {
        eventList.add(() => eventBus.fire(RoomUpdateEvent(room: eventData)));
      }

      // Mirror room name from room to room sub for room type group only
      // for direct room that will be done in update friend state.
      try {
        final roomName = await receiveRoom.getRoomName();
        if (roomName != null && room.roomType == RoomType.group) {
          final roomSub = await _roomSubDb.getRoomSubscriptionWithRoomId(receiveRoom.id ?? '');
          if (roomSub != null) {
            final roomName = await receiveRoom.getRoomName();
            if (roomName != null) {
              roomSub.roomName = roomName;
            }
            if (receiveRoom.roomType != null) {
              roomSub.roomType = receiveRoom.roomType;
            }
            await _roomSubDb.putRoomSubscriptionWithoutTxn(roomSub);
          }
        }
      } catch (e, stacktrace) {
        useLogger().e('Mirror room name from room to room sub error', e, stacktrace);
      }
    }

    final getMembers = params.isNewRoom;
    if (getMembers) {
      if (receiveRoom.isSecretRoom) {
        await EncryptHelper.instance.createSecretRoomCryptoKey(receiveRoom, useTransaction: false);
      }

      await _fetchRoomMemberUseCase.call(
        FetchRoomMemberParams(
          roomId: receiveRoom.id,
          useTransaction: false,
        ),
      );
      await _updateHasFirstOtherInRoom.call(receiveRoom.id!);
    }

    return eventList;
  }
}
