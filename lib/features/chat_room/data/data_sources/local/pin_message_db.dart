import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';

typedef IsarPinMessageCollection = IsarCollection<PinMessageCollection>;
typedef PinMessageCollectionList = List<PinMessageCollection>;
typedef PinMessageSubscription = StreamSubscription<List<PinMessageCollection>>;
typedef PinMessageQAfterFilterCondition
    = QueryBuilder<PinMessageCollection, PinMessageCollection, QAfterFilterCondition>;

class PinMessageDb {
  // Singleton pattern
  static final PinMessageDb instance = PinMessageDb._internal();

  factory PinMessageDb() => instance;

  PinMessageDb._internal();

  // Start body
  Isar? get dbInstance {
    return DbManager().authenticatedInstance;
  }

  IsarPinMessageCollection? get pinMessageCollection {
    return dbInstance?.pinMessage;
  }

  /// Pin a message
  Future<void> pinMessage(PinMessageCollection pinMessage) async {
    await dbInstance?.writeTxn(() async {
      await pinMessageCollection?.put(pinMessage);
    });
  }

  /// Pin a message without transaction
  Future<void> pinMessageNoTxn(PinMessageCollection pinMessage) async {
    await pinMessageCollection?.put(pinMessage);
  }

  /// Put all pin messages
  Future<void> putAllPinMessages(List<PinMessageCollection> pinMessages) async {
    await dbInstance?.writeTxn(() async {
      await putAllPinMessagesNoTxn(pinMessages);
    });
  }

  /// Put all pin messages without transaction
  Future<void> putAllPinMessagesNoTxn(List<PinMessageCollection> pinMessages) async {
    await pinMessageCollection?.putAll(pinMessages);
  }

  /// Unpin a specific message by pinId
  Future<void> unpinMessage(String id) async {
    if (pinMessageCollection == null) return;

    await dbInstance?.writeTxn(() async {
      await unpinMessageNoTxn(id);
    });
  }

  /// Unpin a specific message by pinId without transaction
  Future<void> unpinMessageNoTxn(String id) async {
    if (pinMessageCollection == null) return;

    await pinMessageCollection!.where().idEqualTo(id).deleteFirst();
  }

  /// Unpin all messages in a room
  Future<void> unpinAllMessagesInRoom(String roomId) async {
    if (pinMessageCollection == null) return;

    await dbInstance?.writeTxn(() async {
      await unpinAllMessagesInRoomNoTxn(roomId);
    });
  }

  /// Unpin all messages in a room without transaction
  Future<void> unpinAllMessagesInRoomNoTxn(String roomId) async {
    if (pinMessageCollection == null) return;
    await pinMessageCollection!.where().roomIdEqualTo(roomId).deleteAll();
  }

  /// Get all pin messages in a room
  Future<List<PinMessageCollection>> getPinMessagesInRoom({
    required String roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (pinMessageCollection == null) return [];

    return pinMessageCollection!
        .where()
        .roomIdEqualTo(roomId)
        .sortByCreatedAtDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  /// Get a specific pin message by pinId
  Future<PinMessageCollection?> getById(String id) async {
    if (pinMessageCollection == null) return null;

    final results = await pinMessageCollection!.where().idEqualTo(id).findAll();

    return results.isNotEmpty ? results.first : null;
  }

  /// Watch pin messages changes in a room
  /// Note: For streams, we only use limit (pageSize) without offset to maintain real-time consistency
  Stream<List<PinMessageCollection>> watchPinMessagesInRoom({
    required String roomId,
    int? pageSize,
  }) {
    if (pinMessageCollection == null) {
      return const Stream.empty();
    }

    if (pageSize != null) {
      return pinMessageCollection!
          .where()
          .roomIdEqualTo(roomId)
          .sortByCreatedAtDesc()
          .limit(pageSize)
          .watch(fireImmediately: true);
    }

    return pinMessageCollection!.where().roomIdEqualTo(roomId).sortByCreatedAtDesc().watch(fireImmediately: true);
  }

  Future<PinMessageCollection?> getByRef(String ref) {
    if (pinMessageCollection == null) return Future.value(null);

    return pinMessageCollection!.where().refEqualTo(ref).findFirst();
  }
}
