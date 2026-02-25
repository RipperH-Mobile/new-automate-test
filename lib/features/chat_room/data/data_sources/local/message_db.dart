import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

final _log = useLogger();

typedef IsarMessageCollection = IsarCollection<MessageCollection>;
typedef MessageCollectionList = List<MessageCollection>;
typedef MessageQueryAfterSortBy = QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>;
typedef MessageQuery = QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>;

class MessageDb {
  Isar? customDbInstance;

  MessageDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarMessageCollection get messageCollection {
    return dbInstance.messages;
  }

  static const namePrefix = 'messages';

  Future<MessageCollection?> getMessageByRef({required String ref}) async {
    return messageCollection.get(fastHash(ref));
  }

  Future<MessageCollection?> getMessageById({required String id}) async {
    return messageCollection.where().idEqualTo(id).findFirst();
  }

  Future<MessageCollectionList> getReplyMessageById({required String id}) async {
    return await messageCollection.filter().replyMessage((item) => item.idEqualTo(id)).findAll();
  }

  Future<MessageCollection?> getBookmarkMessageByOriginalMsgId({required String id}) async {
    return messageCollection.where().originalMessageIdEqualTo(id).findFirst();
  }

  Future<MessageCollection?> putMessage(
    MessageCollection message, {
    bool saveLocalFileUrl = true,
    bool replaceData = false,
  }) async {
    return await dbInstance.writeTxn(() async {
      try {
        if (replaceData) {
          await messageCollection.put(message);

          final data = await getMessageById(id: message.id!);
          return data;
        } else {
          final localMessage = await getMessageById(id: message.id!);
          if (localMessage != null) {
            // if update message
            localMessage.update(
              message,
              saveLocalFileUrl: saveLocalFileUrl,
            );
            await messageCollection.put(localMessage);

            return localMessage;
          } else {
            // if new message
            await messageCollection.put(message);

            return await getMessageById(id: message.id!);
          }
        }
      } catch (e, stacktrace) {
        _log.e('putMessageWithoutTxn error', e, stacktrace);
        return null;
      }
    });
  }

  Future<MessageCollection?> putMessageWithoutTxn(
    MessageCollection message, {
    bool replaceData = false,
    bool saveLocalFileUrl = true,
  }) async {
    try {
      if (replaceData) {
        await messageCollection.put(message);

        final data = await getMessageById(id: message.id!);
        return data;
      } else {
        final localMessage = await getMessageById(id: message.id!);
        if (localMessage != null) {
          // if update message
          localMessage.update(
            message,
            saveLocalFileUrl: saveLocalFileUrl,
          );
          await messageCollection.put(localMessage);

          return localMessage;
        } else {
          // if new message
          await messageCollection.put(message);

          return await getMessageById(id: message.id!);
        }
      }
    } catch (e, stacktrace) {
      _log.e('putMessageWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> putAllMessages(List<MessageCollection> messages) async {
    await dbInstance.writeTxn(() async {
      await messageCollection.putAll(messages);
    });
  }

  Future<void> putAllMessagesWithoutTxn(List<MessageCollection> messages) async {
    await messageCollection.putAll(messages);
  }

  Future<void> deleteMessageByRefWithoutTxn({required String ref}) async {
    await messageCollection.deleteAllByRef([ref]);
  }

  Future<void> deleteMessageByRef({required String ref}) async {
    await dbInstance.writeTxn(() async {
      await messageCollection.deleteAllByRef([ref]);
    });
  }

  Future<void> deleteMessageByRoom({required String roomId}) async {
    await dbInstance.writeTxn(() async {
      await messageCollection.where().roomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<void> deleteMessageByRoomWithoutTxn({required String roomId}) async {
    await messageCollection.where().roomIdEqualTo(roomId).deleteAll();
  }

  Future<void> deleteMessageByRoomWithoutTxnBeforeSequence({
    required String roomId,
    required int lastSequenceFromServer,
  }) async {
    await messageCollection.where().roomIdEqualTo(roomId).filter().sequenceLessThan(lastSequenceFromServer).deleteAll();
    await messageCollection.where().roomIdEqualTo(roomId).filter().sequenceEqualTo(lastSequenceFromServer).deleteAll();
  }

  Future<void> deleteBookmarkMessageByOriginalMsgId({required String msgId}) async {
    await dbInstance.writeTxn(() async {
      await messageCollection.where().originalMessageIdEqualTo(msgId).deleteFirst();
    });
  }

  Future<void> deleteBookmarkMessageByOriginalMsgIdWithoutTxn({required String msgId}) async {
    await messageCollection.where().originalMessageIdEqualTo(msgId).deleteFirst();
  }

  Future<void> deleteBookmarkMessagesByOriginalRoomId({required String roomId}) async {
    await dbInstance.writeTxn(() async {
      await messageCollection.where().originalRoomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<void> deleteBookmarkMessagesByOriginalRoomIdWithoutTxn({required String roomId}) async {
    await messageCollection.where().originalRoomIdEqualTo(roomId).deleteAll();
  }

  Future<MessageCollection?> getFirstSequenceByRoom({
    required String roomId,
  }) async {
    return messageCollection.where().isSentRoomIdEqualTo(true, roomId).sortBySequence().limit(1).findFirst();
  }

  Future<MessageCollection?> getLastSequenceByRoom({required String roomId}) async {
    return messageCollection.where().isSentRoomIdEqualTo(true, roomId).sortBySequenceDesc().limit(1).findFirst();
  }

  MessageCollection? getLastSequenceByRoomSync({required String roomId}) {
    return messageCollection.where().isSentRoomIdEqualTo(true, roomId).sortBySequenceDesc().limit(1).findFirstSync();
  }

  Future<MessageCollectionList> getAllSentMessage({
    required String roomId,
    int? limit,
    int? sequenceLessThan,
    int? sequenceGreaterThan,
    bool isMyNote = false,
    bool useGreaterThanOrEqual = false,
    String? emojiTagId,
  }) async {
    _log.d(
        'getAllSentMessage from room: $roomId, sequenceLessThan: $sequenceLessThan, sequenceGreaterThan: $sequenceGreaterThan');
    late MessageQueryAfterSortBy query;

    if (sequenceLessThan == null && sequenceGreaterThan == null) {
      // Case 1: No sequence filters, get all messages
      final q = messageCollection.where().canShowInSentMessageListRoomIdEqualTo(true, roomId);
      if (isMyNote) {
        query = q.filter().isMyNoteEqualTo(true).sortBySequenceDesc();
      } else {
        query = q.sortBySequenceDesc();
      }
    } else if (sequenceLessThan != null && sequenceGreaterThan == null) {
      // Case 2: Only sequenceLessThan is provided
      final q = messageCollection
          .where()
          .roomIdEqualToSequenceLessThan(roomId, sequenceLessThan)
          .filter()
          .canShowInSentMessageListEqualTo(true);
      if (isMyNote) {
        query = q.isMyNoteEqualTo(true).sortBySequenceDesc();
      } else {
        query = q.sortBySequenceDesc();
      }
    } else if (sequenceLessThan == null && sequenceGreaterThan != null) {
      // Case 3: Only sequenceGreaterThan is provided
      final q = messageCollection
          .where()
          .roomIdEqualToSequenceGreaterThan(roomId, sequenceGreaterThan)
          .filter()
          .canShowInSentMessageListEqualTo(true);
      if (isMyNote) {
        query = q.isMyNoteEqualTo(true).sortBySequenceDesc();
      } else {
        query = q.sortBySequenceDesc();
      }
    } else if (sequenceLessThan != null && sequenceGreaterThan != null && useGreaterThanOrEqual) {
      // Case 4: Both sequenceLessThan and sequenceGreaterThan are provided and useGreaterThanOrEqual is true
      final q = messageCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .group((q) => q.sequenceGreaterThan(sequenceGreaterThan).or().sequenceEqualTo(sequenceGreaterThan))
          .sequenceLessThan(sequenceLessThan)
          .canShowInSentMessageListEqualTo(true);
      if (isMyNote) {
        query = q.isMyNoteEqualTo(true).sortBySequenceDesc();
      } else {
        query = q.sortBySequenceDesc();
      }
    } else {
      // Case 5: Both sequenceLessThan and sequenceGreaterThan are provided and useGreaterThanOrEqual is false
      final q = messageCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .sequenceLessThan(sequenceLessThan!)
          .sequenceGreaterThan(sequenceGreaterThan!)
          .canShowInSentMessageListEqualTo(true);
      if (isMyNote) {
        query = q.isMyNoteEqualTo(true).sortBySequenceDesc();
      } else {
        query = q.sortBySequenceDesc();
      }
    }

    // Fetch results from the database
    final results = await (limit != null ? query.limit(limit).findAll() : query.findAll());

    // Manually filter by emojiTagId if provided
    if (emojiTagId != null) {
      return results.where((message) {
        return message.bookmarkEmojiTags?.any((tag) => tag.emojiTagId == emojiTagId) ?? false;
      }).toList();
    }

    return results;
  }

  Future<MessageCollectionList> getAllSentMessageWithFile({
    required String roomId,
    int? limit,
    int? sequenceLessThan,
  }) async {
    _log.d('getAllSentMessage from room: $roomId');
    late MessageQueryAfterSortBy query;

    if (sequenceLessThan == null) {
      query = messageCollection
          .where()
          .canShowInSentMessageListRoomIdEqualTo(true, roomId)
          .filter()
          .group((q) =>
              q.typeEqualTo(MessageType.image).or().typeEqualTo(MessageType.video).or().typeEqualTo(MessageType.file))
          // Don't return file from locked message.
          .group((q) => q.isLockedEqualTo(false).or().isLockedIsNull())
          .sortBySequenceDesc();
    } else {
      query = messageCollection
          .where()
          .roomIdEqualToSequenceLessThan(roomId, sequenceLessThan)
          .filter()
          .group((q) => q
              .typeEqualTo(MessageType.image)
              .or()
              .typeEqualTo(MessageType.video)
              .or()
              .typeEqualTo(MessageType.file)
              .canShowInSentMessageListEqualTo(true))
          // Don't return file from locked message.
          .group((q) => q.isLockedEqualTo(false).or().isLockedIsNull())
          .sortBySequenceDesc();
    }

    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  Future<MessageCollectionList> getAllSentMessageMediaFiles({
    required String roomId,
    int? limit,
    int? sequenceLessThan,
  }) async {
    _log.d('getAllSentMessage from room: $roomId, sequenceLessThan: $sequenceLessThan');
    late MessageQueryAfterSortBy query;

    if (sequenceLessThan == null) {
      query = messageCollection
          .where()
          .canShowInSentMessageListRoomIdEqualTo(true, roomId)
          .filter()
          .group((q) => q.typeEqualTo(MessageType.image).or().typeEqualTo(MessageType.video))
          // Don't return file from locked message.
          .group((q) => q.isLockedEqualTo(null).or().isLockedEqualTo(false))
          .sequenceIsNotNull()
          .sortBySequence();
    } else {
      query = messageCollection
          .where()
          .roomIdEqualToSequenceLessThan(roomId, sequenceLessThan)
          .filter()
          .group((q) => q
              .canShowInSentMessageListEqualTo(true)
              .typeEqualTo(MessageType.image)
              .or()
              .typeEqualTo(MessageType.video)
              .sequenceIsNotNull())
          .group((q) => q.isLockedEqualTo(null).or().isLockedEqualTo(false))
          .sortBySequence();
    }

    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  Future<MessageCollectionList> getAllSendingMessage({
    required String roomId,
  }) async {
    return messageCollection
        .where()
        .isSentRoomIdEqualTo(false, roomId)
        // .or()
        // .roomIdEqualToSeqIsNull(roomId)
        .sortByCreatedAt()
        .findAll();
  }

  Future<MessageCollectionList> getAllBookmarkMessages() async {
    return messageCollection
        .filter()
        .canShowInSentMessageListEqualTo(true)
        .isMyNoteEqualTo(true)
        .or()
        .canShowInSentMessageListEqualTo(true)
        .originalRoomIdIsNotNull()
        .originalMessageIdIsNotNull()
        .findAll();
  }

  Future<MessageCollectionList> getAllBookmarkMessagesWithTags() async {
    return messageCollection
        .filter()
        .canShowInSentMessageListEqualTo(true)
        .isMyNoteEqualTo(true)
        .bookmarkEmojiTagsIsNotNull()
        .bookmarkEmojiTagsIsNotEmpty()
        .or()
        .canShowInSentMessageListEqualTo(true)
        .originalRoomIdIsNotNull()
        .originalMessageIdIsNotNull()
        .bookmarkEmojiTagsIsNotNull()
        .bookmarkEmojiTagsIsNotEmpty()
        .findAll();
  }

  Future<int> getAllBookmarkMessagesCount() async {
    return messageCollection.filter().originalRoomIdIsNotNull().originalMessageIdIsNotNull().count();
  }

  Future<MessageCollectionList> getAllOriginalMessagesOfBookmark() async {
    return messageCollection.where().filter().bookmarkMessageIdIsNotNull().findAll();
  }

  Future<MessageCollection?> getOriginalMessagesByBookmarkMsgId({required String msgId}) async {
    return messageCollection.where().bookmarkMessageIdEqualTo(msgId).findFirst();
  }

  Future<void> clearCollection() async {
    await messageCollection.clear();
  }

  Future<MessageCollectionList> searchMessageInRoom({
    required String roomId,
    required String keyword,
    int? page,
    int? pageSize,
  }) {
    final query = messageCollection
        .where()
        .isSentRoomIdEqualTo(true, roomId)
        .filter()
        .messageContains(keyword)
        .sortBySequenceDesc();
    if (page != null && pageSize != null) {
      return query.offset((page - 1) * pageSize).limit(pageSize).findAll();
    } else {
      return query.findAll();
    }
  }

  Future<int> searchMessageInRoomCount({
    required String roomId,
    required String keyword,
  }) {
    return messageCollection.where().isSentRoomIdEqualTo(true, roomId).filter().messageContains(keyword).count();
  }

  Future<int> countMessageInRoom({
    required String roomId,
    required String keyword,
  }) {
    final query = messageCollection
        .where()
        .isSentRoomIdEqualTo(true, roomId)
        .filter()
        .messageContains(keyword)
        .sortBySequenceDesc();
    return query.count();
  }

  Future<MessageCollectionList> searchMessageInRoomWithBookmarkTag({
    required String roomId,
    required String keyword,
    int? page,
    int? pageSize,
    String? emojiTagId,
  }) async {
    // Search contacts whose names match the keyword
    final matchingContacts = await dbInstance.contacts
        .filter()
        .displayNameContains(keyword, caseSensitive: false)
        .or()
        .nicknameContains(keyword, caseSensitive: false)
        .or()
        .usernameContains(keyword, caseSensitive: false)
        .findAll();

    // Collect matching account IDs
    final matchingAccountIds = matchingContacts.map((contact) => contact.id).toSet();

    // Search messages in the room by content
    final messageQuery = messageCollection
        .where()
        .isSentRoomIdEqualTo(true, roomId)
        .filter()
        .group((q) => q.messageContains(keyword)) // Search by message content
        .sortBySequenceDesc();

    // Apply pagination if specified
    if (page != null && pageSize != null) {
      messageQuery.offset(page * pageSize).limit(pageSize);
    }

    // Fetch messages that match by content
    final messagesByContent = await messageQuery.findAll();

    // Combine messages that match by content and messages sent by matching accounts
    List<MessageCollection> combinedResults = messagesByContent;

    if (matchingAccountIds.isNotEmpty) {
      // Fetch additional messages sent by accounts whose names matched the keyword
      final messagesByAccounts = await messageCollection
          .where()
          .isSentRoomIdEqualTo(true, roomId)
          .filter()
          .anyOf(matchingAccountIds, (q, accountId) => q.accountIdEqualTo(accountId))
          .sortBySequenceDesc()
          .findAll();

      // Combine results, avoiding duplicates
      final uniqueMessageIds = <String>{};
      combinedResults.addAll(messagesByAccounts.where((msg) => uniqueMessageIds.add(msg.id!)));
    }

    // Optionally filter messages by bookmark emojiTagId if provided
    if (emojiTagId != null) {
      combinedResults = combinedResults.where((message) {
        return message.bookmarkEmojiTags?.any((tag) => tag.emojiTagId == emojiTagId) ?? false;
      }).toList();
    }

    return combinedResults;
  }

  Future<MessageCollectionList> searchMessageInAllRoom({
    required String keyword,
    int? page,
    int? pageSize,
  }) {
    final query =
        messageCollection.where().isSentEqualToAnyRoomId(true).filter().messageContains(keyword).sortBySequence();
    if (page != null && pageSize != null) {
      return query.offset((page - 1) * pageSize).limit(pageSize).findAll();
    } else {
      return query.findAll();
    }
  }

  /// Count how many message is between [startSequence] and [endSequence]
  Future<int> countMessageFromSequence({
    required String roomId,
    required int startSequence,
    required int endSequence,
  }) async {
    return await messageCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .sequenceBetween(startSequence, endSequence)
        .canShowInSentMessageListEqualTo(true)
        .count();
  }

  Future<int> countSendFailedMessageFromSequence({required String roomId}) async {
    return await messageCollection.where().roomIdEqualTo(roomId).filter().isSendFailedEqualTo(true).count();
  }

  /// Count how many message is between [startSeq] and [endSeq]
  Future<int> countMessages({required String roomId}) async {
    return await messageCollection.where().roomIdEqualTo(roomId).filter().canShowInSentMessageListEqualTo(true).count();
  }

  Future<MessageCollectionList> getAllSentMessagesByType({
    required String roomId,
    required MessageType messageType,
    int? limit,
    int? sequenceLessThan,
    bool isMyNote = false,
    bool excludeLockMessage = false,
  }) async {
    _log.d('getAllSentMessagesByType from room: $roomId');
    late MessageQueryAfterSortBy query;

    MessageQuery q;

    /// Use different query for sequenceLessThan case and normal case
    if (sequenceLessThan == null) {
      q = messageCollection
          .where()
          .canShowInSentMessageListRoomIdEqualTo(true, roomId)
          .filter()
          .typeEqualTo(messageType);
    } else {
      q = messageCollection
          .where()
          .roomIdEqualToSequenceLessThan(roomId, sequenceLessThan)
          .filter()
          .canShowInSentMessageListEqualTo(true)
          .typeEqualTo(messageType);
    }

    /// Add isMyNote condition if isMyNote is true.
    if (isMyNote) {
      q = q.isMyNoteEqualTo(true);
    }

    /// Add isLock must not be true condition if excludeLockMessage is true.
    if (excludeLockMessage) {
      q = q.group((q) => q.isLockedIsNull().or().isLockedEqualTo(false));
    }

    query = q.sortBySequenceDesc();

    /// Add result limit.
    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  Future<MessageCollectionList> getAllSendingMessagesAcrossRooms() async {
    return messageCollection.where().isSendingEqualToAnyRoomId(true).findAll();
  }

  /// pined message
  Future<void> pinMessage(String messageId) async {
    await dbInstance.writeTxn(() async {
      await pinMessageNoTxn(messageId);
    });
  }

  Future<void> pinMessageNoTxn(String messageId) async {
    final message = await getMessageById(id: messageId);
    if (message != null) {
      message.isPinned = true;
      await messageCollection.put(message);
    }
  }

  /// pined messages
  Future<void> pinMessages(List<String> messageIds) async {
    if (messageIds.isEmpty) return;

    await dbInstance.writeTxn(() async {
      // Bulk fetch all messages at once
      final messages =
          await messageCollection.where().anyOf(messageIds, (q, messageId) => q.idEqualTo(messageId)).findAll();

      if (messages.isNotEmpty) {
        // Update isPinned property for all found messages
        for (final message in messages) {
          message.isPinned = true;
        }

        // Bulk update all messages in single operation
        await messageCollection.putAll(messages);
      }
    });
  }

  /// unpined message
  Future<void> unpinMessage(String messageId) async {
    await dbInstance.writeTxn(() async {
      await unpinMessageNoTxn(messageId);
    });
  }

  Future<void> unpinMessageNoTxn(String messageId) async {
    final message = await getMessageById(id: messageId);
    if (message != null) {
      message.isPinned = false;
      await messageCollection.put(message);
    }
  }

  /// unpined all messages in room
  Future<void> unpinAllMessagesInRoom(String roomId) async {
    await dbInstance.writeTxn(() async {
      await unpinAllMessagesInRoomNoTxn(roomId);
    });
  }

  Future<void> unpinAllMessagesInRoomNoTxn(String roomId) async {
    // Only fetch messages that are actually pinned to reduce unnecessary operations
    final pinnedMessages =
        await messageCollection.where().roomIdEqualTo(roomId).filter().isPinnedEqualTo(true).findAll();

    if (pinnedMessages.isNotEmpty) {
      // Update isPinned property for all pinned messages
      for (final message in pinnedMessages) {
        message.isPinned = false;
      }

      // Bulk update all messages in single operation
      await messageCollection.putAll(pinnedMessages);
    }
  }

  // delete account data from deleted contact
  Future<void> deleteAccountDataFromMessages(String accountId) async {
    await dbInstance.writeTxn(() async {
      final messages = await messageCollection.filter().accountIdEqualTo(accountId).findAll();
      for (final message in messages) {
        message.account?.isDeleted = true;
        message.account?.displayName = null;
        message.account?.nickname = null;
      }
      await messageCollection.putAll(messages);
    });
  }

  Future<void> deleteAccountDataFromMessagesWithoutTxn(String accountId) async {
    final messages = await messageCollection.filter().accountIdEqualTo(accountId).findAll();
    for (final message in messages) {
      message.account?.isDeleted = true;
      message.account?.displayName = null;
      message.account?.nickname = null;
    }
    await messageCollection.putAll(messages);
  }
}
