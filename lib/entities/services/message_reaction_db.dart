import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_reaction_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

typedef IsarMessageReactionCollection = IsarCollection<MessageReactionCollection>;
typedef MessageReactionCollectionList = List<MessageReactionCollection>;
typedef MessageQueryAfterSortBy = QueryBuilder<MessageReactionCollection, MessageReactionCollection, QAfterSortBy>;

class MessageReactionDb {
  // Singleton pattern
  static final MessageReactionDb instance = MessageReactionDb._internal();

  factory MessageReactionDb() => instance;

  MessageReactionDb._internal();

  // Start body
  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarMessageReactionCollection get messageReactionCollection {
    return dbInstance.messageReaction;
  }

  static const namePrefix = 'messageReaction';

  Future<MessageReactionCollection?> getMessageReactionByUserIdAndMsgId({
    required String accountId,
    required String msgId,
  }) async {
    return messageReactionCollection.where().accountIdMsgIdEqualTo(accountId, msgId).findFirst();
  }

  Future<MessageReactionCollection?> getMessageReaction({required String localDbId}) async {
    return messageReactionCollection.get(fastHash(localDbId));
  }

  Future<List<MessageReactionCollection>?> getAllMessageReactionByRoomIdAndMsgId({
    required String roomId,
    required String msgId,
  }) async {
    return messageReactionCollection.where().roomIdMsgIdEqualTo(roomId, msgId).sortByCreatedAt().findAll();
  }

  Future<void> removeAllMessageReactionByRoomIdAndMsgId({
    required String roomId,
    required String msgId,
  }) async {
    messageReactionCollection.where().roomIdMsgIdEqualTo(roomId, msgId).deleteAll();
  }

  Future<List<MessageReactionCollection>?> getAllMessageReactionByRoomId({
    required String roomId,
  }) async {
    return messageReactionCollection.where().roomIdEqualTo(roomId).sortByCreatedAt().findAll();
  }

  Future<void> removeAllMessageReactionWithRoomId({
    required String roomId,
  }) async {
    messageReactionCollection.where().roomIdEqualTo(roomId).deleteAll();
  }

  Future<void> putMessageReaction(MessageReactionCollection messageReaction) async {
    await dbInstance.writeTxn(() async {
      try {
        final localMessageReaction = await getMessageReaction(localDbId: messageReaction.localDbId!);
        if (localMessageReaction != null) {
          // if update messageReaction
          localMessageReaction.update(messageReaction);
          await messageReactionCollection.put(localMessageReaction);
        } else {
          // if new messageReaction
          await messageReactionCollection.put(messageReaction);
        }
      } catch (e, stacktrace) {
        _log.e('putMessageReaction error', e, stacktrace);
        return null;
      }
    });
  }

  Future<MessageReactionCollection?> putMessageReactionWithoutTxn(
    MessageReactionCollection messageReaction,
  ) async {
    try {
      final localMessageReaction = await getMessageReaction(localDbId: messageReaction.localDbId!);
      if (localMessageReaction != null) {
        // if update messageReaction
        localMessageReaction.update(messageReaction);
        await messageReactionCollection.put(localMessageReaction);

        return localMessageReaction;
      } else {
        // if new messageReaction
        await messageReactionCollection.put(messageReaction);

        return await getMessageReaction(localDbId: messageReaction.localDbId!);
      }
    } catch (e, stacktrace) {
      _log.e('putMessageReactionWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> putAllMessageReaction(List<MessageReactionCollection> messageReaction) async {
    await dbInstance.writeTxn(() async {
      await messageReactionCollection.putAll(messageReaction);
    });
  }

  Future<void> putAllMessageReactionWithoutTxn(List<MessageReactionCollection> messageReaction) async {
    await messageReactionCollection.putAll(messageReaction);
  }

  Future<void> deleteMessageReactionById({required String id}) async {
    await dbInstance.writeTxn(() async {
      await messageReactionCollection.delete(fastHash(id));
    });
  }

  Future<void> deleteMessageReactionByIdWithoutTxn({required String id}) async {
    await messageReactionCollection.delete(fastHash(id));
  }

  Future<void> clearCollection() async {
    await messageReactionCollection.clear();
  }

  Future<int> countAllMessageReactionByMsgId({required String roomId, required String msgId}) async {
    return await messageReactionCollection.where().roomIdMsgIdEqualTo(roomId, msgId).count();
  }

  Future<int> countMessageReactionByEmojiId({required String msgId, required String emojiId}) async {
    return await messageReactionCollection.where().emojiIdMsgIdEqualTo(emojiId, msgId).count();
  }
}
