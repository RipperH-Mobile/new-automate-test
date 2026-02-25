import 'dart:convert';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_reaction_collection.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/entities/services/message_reaction_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_local_message_reactions_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reaction_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/sync_message_reaction_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_local_message_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/entities/draft_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/save_draft_message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';

class MessageLocalRepositoryImpl implements MessageLocalRepository {
  MessageLocalRepositoryImpl({
    required this.messageDb,
    required this.messageReactionDb,
    required this.roomMemberDb,
    required this.configInstance,
  });

  final MessageDb messageDb;
  final MessageReactionDb messageReactionDb;
  final RoomMemberDb roomMemberDb;
  final ConfigInstance configInstance;

  @override
  Future<void> deleteAllMessageInRoom({required String roomId, bool useTxn = true}) async {
    if (useTxn) {
      await messageDb.deleteMessageByRoom(roomId: roomId);
    } else {
      await messageDb.deleteMessageByRoomWithoutTxn(roomId: roomId);
    }
  }

  @override
  Future<void> deleteMessageByRef({required String ref, bool useTxn = true}) async {
    if (useTxn) {
      await messageDb.deleteMessageByRef(ref: ref);
    } else {
      await messageDb.deleteMessageByRefWithoutTxn(ref: ref);
    }
  }

  @override
  Future<List<MessageEntity>> getAllSentMessage({
    required String roomId,
    int? limit,
    int? sequenceLessThan,
    int? sequenceGreaterThan,
    bool isMyNote = false,
    bool useGreaterThanOrEqual = false,
    String? emojiTagId,
  }) async {
    final response = await messageDb.getAllSentMessage(
      roomId: roomId,
      limit: limit,
      sequenceLessThan: sequenceLessThan,
      sequenceGreaterThan: sequenceGreaterThan,
      useGreaterThanOrEqual: useGreaterThanOrEqual,
      isMyNote: isMyNote,
      emojiTagId: emojiTagId,
    );
    return response.toEntities();
  }

  @override
  Future<List<MessageEntity>> getAllSendingMessage(String roomId) async {
    final messages = await messageDb.getAllSendingMessage(roomId: roomId);
    return messages.toEntities();
  }

  @override
  Future<PaginationPayload<MessageEntity>> searchMessageInRoom({
    required String roomId,
    required String keyword,
    required int page,
    required int pageSize,
  }) async {
    final response = await messageDb.searchMessageInRoom(
      roomId: roomId,
      keyword: keyword,
      page: page,
      pageSize: pageSize,
    );

    final total = await messageDb.searchMessageInRoomCount(roomId: roomId, keyword: keyword);
    return PaginationPayload<MessageEntity>(
      data: response.toEntities(),
      total: total,
      page: page,
      pageSize: pageSize,
      totalPages: (total / pageSize).ceil(),
    );
  }

  @override
  Future<MessageEntity?> getMessageById({required String id}) async {
    final response = await messageDb.getMessageById(id: id);
    return response?.toEntity();
  }

  @override
  Future<MessageEntity?> getMessageByRef({required String ref}) async {
    final response = await messageDb.getMessageByRef(ref: ref);
    return response?.toEntity();
  }

  @override
  Future<void> putAllMessages({required List<MessageEntity> messages, bool useTxn = true}) async {
    final collections = messages.toCollections();
    if (useTxn) {
      await messageDb.putAllMessages(collections);
    } else {
      await messageDb.putAllMessagesWithoutTxn(collections);
    }
  }

  @override
  Future<MessageEntity?> putMessage({
    required MessageEntity message,
    bool replaceData = false,
    bool saveLocalFileUrl = true,
    bool useTxn = true,
  }) async {
    final messageCollection = message.toCollection();
    MessageCollection? responseMessage;
    if (useTxn) {
      responseMessage = await messageDb.putMessage(
        messageCollection,
        replaceData: replaceData,
        saveLocalFileUrl: saveLocalFileUrl,
      );
    } else {
      responseMessage = await messageDb.putMessageWithoutTxn(
        messageCollection,
        replaceData: replaceData,
        saveLocalFileUrl: saveLocalFileUrl,
      );
    }
    return responseMessage?.toEntity();
  }

  @override
  Future<MessageEntity?> getFirstSequenceByRoom(String roomId) async {
    final message = await messageDb.getFirstSequenceByRoom(roomId: roomId);
    return message?.toEntity();
  }

  @override
  Future<MessageEntity?> getLastSequenceByRoom(String roomId) async {
    final message = await messageDb.getLastSequenceByRoom(roomId: roomId);
    return message?.toEntity();
  }

  @override
  Future<List<MessageEntity>> getAllSentMessageMediaFiles(String roomId) async {
    final messages = await messageDb.getAllSentMessageMediaFiles(roomId: roomId);
    return messages.toEntities();
  }

  @override
  Future<List<MessageEntity>> getMessageByReplyMessageId({required String replyMessageId}) async {
    final messages = await messageDb.getReplyMessageById(id: replyMessageId);
    return messages.toEntities();
  }

  @override
  Future<List<MessageEntity>> getAllBookmarkMessages() async {
    final messages = await messageDb.getAllBookmarkMessages();
    return messages.toEntities();
  }

  @override
  Future<MessageEntity?> getBookmarkMessageByMessageId({required String id}) async {
    final message = await messageDb.getBookmarkMessageByOriginalMsgId(id: id);
    return message?.toEntity();
  }

  @override
  Future<MessageEntity?> getMessagesByBookmarkMessageId({required String bookmarkMessageId}) async {
    final message = await messageDb.getOriginalMessagesByBookmarkMsgId(msgId: bookmarkMessageId);
    return message?.toEntity();
  }

  @override
  Future<List<MessageEntity>> getAllSendingMessagesAcrossRooms() async {
    final messages = await messageDb.getAllSendingMessagesAcrossRooms();
    return messages.toEntities();
  }

  // TODO: unit test
  @override
  Future<DraftMessageEntity?> getDraftMessage() async {
    final jsonString = await configInstance.getString(key: ConfigDb.getDraftMessageKey());
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final savedDraft = SaveDraftMessageEntity.fromJson(json);

      MessageEntity? replyMessage;
      if (savedDraft.replyMessageId != null) {
        final messageCollection = await messageDb.getMessageById(id: savedDraft.replyMessageId!);
        replyMessage = messageCollection?.toEntity();
      }

      return DraftMessageEntity(
        roomId: savedDraft.roomId,
        message: savedDraft.message,
        replyMessage: replyMessage,
      );
    } else {
      return null; // No draft message found for the room
    }
  }

  // TODO: unit test
  @override
  Future<void> saveDraftMessage(SaveDraftMessageEntity entity) async {
    final json = entity.toJson();
    final String jsonString = jsonEncode(json);
    return configInstance.saveConfig(
      key: ConfigDb.getDraftMessageKey(),
      value: jsonString,
    );
  }

  // TODO: unit test
  @override
  Future<void> clearDraftMessage() {
    return configInstance.clearConfig(key: ConfigDb.getDraftMessageKey());
  }

  @override
  Future<void> syncMessageReactionData(SyncMessageReactionRequest request) async {
    final message = await messageDb.getMessageById(id: request.msgId);
    if (message == null) return;

    // Handle adding new emoji reaction
    if (request.newEmojiId != null) {
      await _addEmojiReaction(request);
    }

    // Handle removing emoji reaction
    if (request.removeEmojiId != null) {
      await _removeEmojiReaction(request);
    }

    // Update message with latest emoji data
    await _updateMessageEmojiData(message, request);
  }

  Future<void> _addEmojiReaction(SyncMessageReactionRequest request) async {
    final member = await roomMemberDb.getOneMemberInRoom(
      request.roomId,
      request.accountId ?? '',
    );

    final fileId = request.lastEmojis.where((e) => request.newEmojiId == e.emojiId).firstOrNull?.fileId ?? '';

    final newMessageReaction = MessageReactionCollection(
      msgId: request.msgId,
      roomId: request.roomId,
      emojiId: request.newEmojiId,
      accountId: request.accountId,
      displayName: member?.account?.shortName,
      avatarPath: member?.account?.avatarId,
      createdAt: DateTime.now().toUtc(),
      fileId: fileId,
    );

    if (request.isFromSyncProcess) {
      await messageReactionDb.putMessageReactionWithoutTxn(newMessageReaction);
    } else {
      await messageReactionDb.putMessageReaction(newMessageReaction);
    }
  }

  Future<void> _removeEmojiReaction(SyncMessageReactionRequest request) async {
    final reactionId = '${request.roomId}-${request.msgId}-${request.removeEmojiId}-${request.accountId}';

    if (request.isFromSyncProcess) {
      await messageReactionDb.deleteMessageReactionByIdWithoutTxn(id: reactionId);
    } else {
      await messageReactionDb.deleteMessageReactionById(id: reactionId);
    }
  }

  Future<void> _updateMessageEmojiData(
    MessageCollection message,
    SyncMessageReactionRequest request,
  ) async {
    // Sort emojis by updated time (newest first)
    request.lastEmojis.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt ?? DateTime.now()));

    message.lastEmojis = request.lastEmojis.toModels();
    message.emojiAmount = request.emojiAmount;

    if (request.selectedReactionList != null) {
      message.selectedReactionList = request.selectedReactionList;
    }

    if (request.isFromSyncProcess) {
      await messageDb.putMessageWithoutTxn(message);
    } else {
      await messageDb.putMessage(message);
    }
  }

  @override
  Future<List<MessageReactionEntity>> getAllMessageReactionByRoomIdAndMsgId(
      GetLocalMessageReactionsRequest request) async {
    final collections = await messageReactionDb.getAllMessageReactionByRoomIdAndMsgId(
      roomId: request.roomId,
      msgId: request.msgId,
    );
    if (collections == null) throw NullResponseException();
    return collections.toEntities();
  }

  @override
  Future<void> removeReaction(RemoveReactionRequest request) async {
    await messageReactionDb.removeAllMessageReactionByRoomIdAndMsgId(
      roomId: request.roomId,
      msgId: request.msgId,
    );
  }

  @override
  Future<void> removeReactionsByRoomId(RemoveReactionsByRoomIdRequest request) async {
    await messageReactionDb.removeAllMessageReactionWithRoomId(roomId: request.roomId);
  }

  @override
  Future<void> updateLocalMessageReaction(UpdateLocalMessageReactionRequest request) async {
    final localReactionList = await getAllMessageReactionByRoomIdAndMsgId(
      GetLocalMessageReactionsRequest(
        roomId: request.roomId,
        msgId: request.msgId,
      ),
    );
    for (final reactionData in request.reactions) {
      final existingReactionIndex = localReactionList.indexWhere((localReaction) =>
          localReaction.accountId == reactionData.accountId &&
          localReaction.displayName == reactionData.displayName &&
          localReaction.avatarPath == reactionData.avatarPath);

      // Only add new reactions (avoid duplicates)
      // or has updated displayName or avatarPath
      if (existingReactionIndex == -1) {
        final newReaction = MessageReactionCollection(
          roomId: request.roomId,
          msgId: request.msgId,
          accountId: reactionData.accountId,
          emojiId: reactionData.emojiId,
          fileId: reactionData.fileId,
          displayName: reactionData.displayName,
          avatarPath: reactionData.avatarPath,
          createdAt: reactionData.createdAt,
        );

        await messageReactionDb.putMessageReaction(newReaction);
      }
    }
  }

  @override
  Future<int> countMessages({required String roomId}) async {
    return await messageDb.countMessages(roomId: roomId);
  }
}
