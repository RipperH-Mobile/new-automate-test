import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_local_message_reactions_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reaction_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/sync_message_reaction_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_local_message_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/entities/draft_message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/save_draft_message_entity.dart';

abstract class MessageLocalRepository {
  Future<List<MessageEntity>> getAllSentMessage({
    required String roomId,
    int? limit,
    int? sequenceLessThan,
    int? sequenceGreaterThan,
    bool isMyNote = false,
    bool useGreaterThanOrEqual = false,
    String? emojiTagId,
  });

  Future<List<MessageEntity>> getAllSentMessageMediaFiles(String roomId);

  Future<MessageEntity?> getMessageByRef({required String ref});

  Future<MessageEntity?> getMessageById({required String id});

  Future<MessageEntity?> putMessage({
    required MessageEntity message,
    bool replaceData = false,
    bool saveLocalFileUrl = true,
    bool useTxn = true,
  });

  Future<void> putAllMessages({required List<MessageEntity> messages, bool useTxn = true});

  Future<void> deleteMessageByRef({required String ref, bool useTxn = true});

  Future<void> deleteAllMessageInRoom({required String roomId, bool useTxn = true});

  Future<List<MessageEntity>> getAllSendingMessage(String roomId);

  Future<PaginationPayload<MessageEntity>> searchMessageInRoom({
    required String roomId,
    required String keyword,
    required int page,
    required int pageSize,
  });

  Future<MessageEntity?> getLastSequenceByRoom(String roomId);

  Future<MessageEntity?> getFirstSequenceByRoom(String roomId);

  Future<List<MessageEntity>> getMessageByReplyMessageId({required String replyMessageId});

  Future<MessageEntity?> getBookmarkMessageByMessageId({required String id});

  Future<MessageEntity?> getMessagesByBookmarkMessageId({required String bookmarkMessageId});

  Future<List<MessageEntity>> getAllBookmarkMessages();

  Future<List<MessageEntity>> getAllSendingMessagesAcrossRooms();

  Future<void> saveDraftMessage(SaveDraftMessageEntity entity);

  Future<DraftMessageEntity?> getDraftMessage();

  Future<void> clearDraftMessage();

  Future<void> syncMessageReactionData(SyncMessageReactionRequest request);

  Future<List<MessageReactionEntity>?> getAllMessageReactionByRoomIdAndMsgId(GetLocalMessageReactionsRequest request);

  Future<void> removeReaction(RemoveReactionRequest request);

  Future<void> removeReactionsByRoomId(RemoveReactionsByRoomIdRequest request);

  Future<void> updateLocalMessageReaction(UpdateLocalMessageReactionRequest request);

  Future<int> countMessages({required String roomId});
}
