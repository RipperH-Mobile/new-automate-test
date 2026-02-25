import 'package:get_it/get_it.dart';
import 'package:uchat/constants/files_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_system_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_delete_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_put_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/decrypt_message_text_use_case.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../typedefs.dart';
import 'sync_handle_update_message_bookmark_tags_use_case.dart';
import 'sync_handle_update_room_use_case.dart';

class SyncHandleUpdateMessageParams {
  // TODO: Move to MessageEntity
  final MessageCollection receiveMessage;

  SyncHandleUpdateMessageParams({required this.receiveMessage});
}

class SyncHandleUpdateMessageUseCase extends SimpleUseCase<EventListCallback, SyncHandleUpdateMessageParams> {
  final MessageLocalRepository messageLocalRepository;
  final RoomSubscriptionLocalRepository roomSubscriptionLocalRepository;
  final RoomFileLocalRepository roomFileLocalRepository;

  SyncHandleUpdateMessageUseCase({
    required this.messageLocalRepository,
    required this.roomSubscriptionLocalRepository,
    required this.roomFileLocalRepository,
  });

  SyncHandleUpdateRoomUseCase get syncHandleUpdateRoom {
    return GetIt.I<SyncHandleUpdateRoomUseCase>();
  }

  SyncHandleUpdateMessageBookmarkTagsUseCase get syncHandleUpdateMessageBookmarkTagsUseCase {
    return GetIt.I<SyncHandleUpdateMessageBookmarkTagsUseCase>();
  }

  DecryptMessageTextUseCase get decryptMessageTextUseCase {
    return GetIt.I<DecryptMessageTextUseCase>();
  }

  @override
  Future<EventListCallback> call(SyncHandleUpdateMessageParams params) async {
    final EventListCallback eventList = [];
    final receiveMessage = params.receiveMessage;
    final receiveMessageId = receiveMessage.id;
    final receiveMessageRef = receiveMessage.ref;

    // Validate messageId and messageRef
    if (receiveMessageId == null) {
      useLogger().e('SyncHandleUpdateMessageUseCase: messageId is null');
      return eventList;
    }

    if (receiveMessageRef == null) {
      useLogger().e('SyncHandleUpdateMessageUseCase: messageRef is null');
      return eventList;
    }

    // Start the logic below
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

    final room = receiveMessage.room;
    final mySubscription = room?.mySubscription;

    // Create new room when [room] is not exist and have [mySubscription]
    if (room != null && mySubscription != null) {
      final eventCb = await syncHandleUpdateRoom.call(SyncHandleUpdateRoomParams(
        receiveRoom: room.toRoomCollection(),
        roomSubInRoom: mySubscription,
        isNewRoom: true,
      ));
      eventList.addAll(eventCb);
    }

    final localMessage = await messageLocalRepository.getMessageByRef(
      ref: receiveMessage.ref ?? receiveMessageId,
    );

    if (receiveMessage.type == MessageType.system &&
        receiveMessage.systemMessage?.type == MessageSystemType.unSentMessage) {
      final localReplyMessages =
          await messageLocalRepository.getMessageByReplyMessageId(replyMessageId: receiveMessageId);
      if (localReplyMessages.isNotEmpty) {
        for (final localEachReplyMessages in localReplyMessages) {
          // Convert entity back to collection to update model
          final localReplyCollection = localEachReplyMessages.toCollection();
          localReplyCollection.replyMessage = receiveMessage.toModel();
          // Convert back to entity for repository
          await messageLocalRepository.putMessage(message: localReplyCollection.toEntity(), useTxn: false);

          eventList.add(
            () => eventBus.fire(MessageUpdateEvent(message: localReplyCollection)),
          );
        }
      }
    }

    if ((receiveMessage.originalMessageId != null && receiveMessage.originalRoomId != null) ||
        receiveMessage.isMyNote == true) {
      // Update data in bookmark tag list
      if (receiveMessage.bookmarkEmojiTags case final bookmarkEmojiTags?) {
        final updatedTags = await syncHandleUpdateMessageBookmarkTagsUseCase.call(
          SyncHandleUpdateMessageBookmarkTagsParams(bookmarkEmojiTags: bookmarkEmojiTags),
        );

        if (updatedTags != null) {
          receiveMessage.bookmarkEmojiTags = updatedTags;
        }
      }
    }

    // -----------
    // If found the message in local db, update it.
    // -----------
    if (localMessage != null) {
      // if (receiveMessage.type == MessageType.video ||
      //     receiveMessage.type == MessageType.file ||
      //     receiveMessage.type == MessageType.image) {
      //   receiveMessage.file?.progressState = FileProgressState.uploaded;
      //   // eventBus.fire(UnsentOrRemoveLocalEvent(messageId, removedFileIds));
      //
      //   // if (receiveMessage.files?.isNotEmpty == true) {
      //   //   receiveMessage.files?.forEach((file) {
      //   //     eventList.add(
      //   //       () => eventBus.fire(
      //   //         FileStateChangeEvent(
      //   //           fileRef: file.refFile!,
      //   //           state: FileProgressState.uploaded,
      //   //         ),
      //   //       ),
      //   //     );
      //   //   });
      //   // }
      // }

      // Create a local collection from entity and update with received message
      final localMessageCollection = localMessage.toCollection();
      localMessageCollection.update(receiveMessage);

      /// (receiveMessage.type == MessageType.system && receiveMessage.systemMessage?.type == MessageSystemType.unSentMessage)
      /// is when message is unsent, Server will send update message state with type system and systemMessage type is unsent.
      /// MessageType.unsent is unused.
      if ((receiveMessage.type == MessageType.system &&
              receiveMessage.systemMessage?.type == MessageSystemType.unSentMessage) ||
          receiveMessage.type == MessageType.remove ||
          receiveMessage.type == MessageType.removeOthers) {
        // If message is unsent delete all RoomFileCollection with this message id.
        await roomFileLocalRepository.deleteAllFileWithMessageId(DeleteAllFileWithMessageIdRequest(
          messageId: receiveMessageId,
          useTxn: false,
        ));

        final msgDeleted = await messageLocalRepository.getMessageByReplyMessageId(replyMessageId: receiveMessageId);

        final receiveMessageModel = receiveMessage.toModel();
        final updatedMessages = msgDeleted.map((msg) {
          final updatedMsg = msg.copyWith(replyMessage: receiveMessageModel);
          eventList.add(() => eventBus.fire(MessageUpdateEvent(message: updatedMsg.toCollection())));
          return updatedMsg;
        }).toList();
        if (updatedMessages.isNotEmpty) {
          await messageLocalRepository.putAllMessages(messages: updatedMessages, useTxn: false);
        }
      }
      // If this message update has file, update that file data to local db
      else if (filesType.contains(receiveMessage.type) && receiveMessage.files != null) {
        // Remove all files with this message id first.
        await roomFileLocalRepository.deleteAllFileWithMessageId(DeleteAllFileWithMessageIdRequest(
          messageId: receiveMessageId,
          useTxn: false,
        ));

        // Create a list of new files.
        // TODO: Change [RoomFileCollection] to [RoomFileEntity]
        final files = RoomFileCollection.fromMessageCollection(receiveMessage);

        final filesEntity = files.map((e) => e.toEntity()).toList();

        // Update new list of file into local db.
        await roomFileLocalRepository.putAllRoomFiles(PutAllRoomFilesRequest(
          files: filesEntity,
          useTxn: false,
        ));
      }

      // Decrypt message. This code block will do nothing if this room
      // doesn't use encryption and the server doesn't have public key.
      final decryptedMessageEntity =
          await decryptMessageTextUseCase.call(DecryptMessageTextParams(message: receiveMessage.toEntity()));
      final decryptedMessage = decryptedMessageEntity?.toCollection();
      if (decryptedMessage != null) {
        localMessageCollection.update(decryptedMessage);
      }

      // When edit the message, find reply message with this message and update it.
      if (receiveMessage.isEdited) {
        final messagesWithThisReply = await messageLocalRepository.getMessageByReplyMessageId(
          replyMessageId: localMessage.id!,
        );

        // Convert entities to collections for updating
        final messageCollections = messagesWithThisReply.map((e) => e.toCollection()).toList();

        for (final messageCollection in messageCollections) {
          messageCollection.replyMessage?.message = localMessage.message;
          eventList.add(() => eventBus.fire(MessageUpdateEvent(message: messageCollection)));
        }

        // Convert back to entities for repository
        await messageLocalRepository.putAllMessages(
            messages: messageCollections.map((e) => e.toEntity()).toList(), useTxn: false);
      }

      // Convert to entity before sending to repository
      final eventData = await messageLocalRepository.putMessage(
        message: localMessageCollection.toEntity(),
        replaceData: receiveMessage.bookmarkMessageId == '',
        useTxn: false,
      );

      if (eventData != null) {
        // Convert back to collection for event
        eventList.add(() => eventBus.fire(MessageUpdateEvent(message: eventData.toCollection())));
      }
    }
    // -----------
    // If not found, create new message.
    // -----------
    else {
      // Create room crypto key. This code block will do nothing if this room
      // doesn't use encryption and the server doesn't have public key.
      final decryptedMessageEntity =
          await decryptMessageTextUseCase.call(DecryptMessageTextParams(message: receiveMessage.toEntity()));
      final decryptedMessage = decryptedMessageEntity?.toCollection();
      if (decryptedMessage != null) {
        receiveMessage.update(decryptedMessage);
      }

      // Only bookmark's message, update last message time.
      if (receiveMessage.originalMessageId != null && receiveMessage.originalRoomId != null) {
        if (receiveMessage.roomId case final roomId?) {
          RoomSubscriptionEntity? roomSub =
              await roomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: roomId);

          if (roomSub != null) {
            roomSub = roomSub.copyWith(
              lastMessage: receiveMessage.toModel(),
            );
            roomSub.lastMessage?.createdAt = DateTime.now();
            roomSub.lastMessage?.updatedAt = DateTime.now();
            await roomSubscriptionLocalRepository.putRoomSubscription(roomSub: roomSub, useTxn: false);
          }
        }
      }

      // Convert to entity before calling repository
      final eventEntity = await messageLocalRepository.putMessage(message: receiveMessage.toEntity(), useTxn: false);
      // Convert back to collection for event bus
      final eventData = eventEntity?.toCollection();

      // If this message has file, save that file data to local db
      if (filesType.contains(receiveMessage.type) && receiveMessage.files != null) {
        final files = RoomFileCollection.fromMessageCollection(receiveMessage);
        final filesEntity = files.map((e) => e.toEntity()).toList();
        await roomFileLocalRepository.putAllRoomFiles(PutAllRoomFilesRequest(
          files: filesEntity,
          useTxn: false,
        ));
      }

      if (eventData != null) {
        eventList.add(() => eventBus.fire(MessageNewEvent(message: eventData)));
      }
    }

    return eventList;
  }
}
