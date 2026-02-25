import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/call_log/data/models/mapper/call_log_collection_mapper.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/call_log/domain/params/get_call_logs_by_room_and_friend_ids_request.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarCallLogCollection = IsarCollection<CallLogCollection>;
typedef CallLogCollectionList = List<CallLogCollection>;
typedef CallLogQueryAfterFilter = QueryBuilder<CallLogCollection, CallLogCollection, QAfterFilterCondition>;

class CallLogDb {
  Isar? customDbInstance;

  CallLogDb({this.customDbInstance});

  Isar? get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance;
  }

  IsarCallLogCollection? get callLogCollection {
    return dbInstance?.callLogs;
  }

  Future<void> putCallLog(CallLogCollection callLog) async {
    await dbInstance?.writeTxn(() async {
      await callLogCollection?.put(callLog);
    });
  }

  Future<void> putAllCallLogs(List<CallLogCollection> callLogs) async {
    await dbInstance?.writeTxn(() async {
      await callLogCollection?.putAll(callLogs);
    });
  }

  Future<List<CallLogEntity>> getAllCallLogs({int? limit, CallActionType? callActionType}) async {
    final query = callActionType != null
        ? callLogCollection?.where().callActionTypeEqualTo(callActionType).sortByLastStartedAtDesc()
        : callLogCollection?.where().sortByLastStartedAtDesc();

    final collections = limit != null ? await query?.limit(limit).findAll() : await query?.findAll();

    if (collections == null) return [];
    return CallLogCollectionMapper.toEntities(collections);
  }

  Future<CallLogEntity?> getCallLog(String id) async {
    final collection = await callLogCollection?.get(fastHash(id));
    if (collection == null) return null;
    return CallLogCollectionMapper.toEntity(collection);
  }

  Future<List<CallLogEntity>> getCallLogsByRoomAndFriendIds(
    GetCallLogsByRoomAndFriendIdsRequest request,
  ) async {
    final filteredRoomIds = request.roomIds.where((id) => id.isNotEmpty).toSet().toList();
    final filteredFriendIds = request.friendIds.where((id) => id.isNotEmpty).toSet().toList();

    if (filteredRoomIds.isEmpty && filteredFriendIds.isEmpty) return [];

    if (filteredFriendIds.isEmpty) {
      final roomQuery = callLogCollection
          ?.where()
          .anyOf(filteredRoomIds, (q, String roomId) => q.roomIdEqualTo(roomId))
          .sortByLastStartedAtDesc();
      final roomCollections =
          request.limit != null ? await roomQuery?.limit(request.limit!).findAll() : await roomQuery?.findAll();
      return CallLogCollectionMapper.toEntities(roomCollections ?? []);
    }

    if (filteredRoomIds.isEmpty) {
      final friendQuery = callLogCollection
          ?.where()
          .anyOf(filteredFriendIds, (q, String friendId) => q.friendIdEqualTo(friendId))
          .sortByLastStartedAtDesc();
      final friendCollections =
          request.limit != null ? await friendQuery?.limit(request.limit!).findAll() : await friendQuery?.findAll();
      return CallLogCollectionMapper.toEntities(friendCollections ?? []);
    }

    final roomCollections = await callLogCollection
            ?.where()
            .anyOf(filteredRoomIds, (q, String roomId) => q.roomIdEqualTo(roomId))
            .findAll() ??
        [];
    final friendCollections = await callLogCollection
            ?.where()
            .anyOf(filteredFriendIds, (q, String friendId) => q.friendIdEqualTo(friendId))
            .findAll() ??
        [];

    final mergedById = <String, CallLogCollection>{
      for (final callLog in roomCollections) _callLogDedupKey(callLog): callLog,
      for (final callLog in friendCollections) _callLogDedupKey(callLog): callLog,
    };

    final mergedCollections = mergedById.values.toList()
      ..sort((a, b) {
        final aTime = a.lastStartedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.lastStartedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });

    final limitedCollections =
        request.limit != null ? mergedCollections.take(request.limit!).toList() : mergedCollections;
    return CallLogCollectionMapper.toEntities(limitedCollections);
  }

  String _callLogDedupKey(CallLogCollection callLog) {
    return callLog.id ??
        '${callLog.roomId}-${callLog.friendId}-${callLog.lastStartedAt?.millisecondsSinceEpoch}-${callLog.callType}-${callLog.callActionType}';
  }

  Future<bool> deleteCallLog(String id) async {
    return await dbInstance?.writeTxn(() async {
          return await callLogCollection?.delete(fastHash(id)) ?? false;
        }) ??
        false;
  }

  Future<void> deleteAllCallLogs(List<String> ids) async {
    await dbInstance?.writeTxn(() async {
      final hashedIds = ids.map((id) => fastHash(id)).toList();
      await callLogCollection?.deleteAll(hashedIds);
    });
  }

  Future<void> clearCollection() async {
    await dbInstance?.writeTxn(() async {
      await callLogCollection?.clear();
    });
  }
}
