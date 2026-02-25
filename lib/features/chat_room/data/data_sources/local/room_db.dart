import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

typedef IsarRoomCollection = IsarCollection<RoomCollection>;
typedef RoomCollectionList = List<RoomCollection>;
typedef RoomSubscription = StreamSubscription<List<RoomCollection>>;
typedef RoomQAfterFilterCondition = QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>;
typedef RoomQAfterSort = QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>;
typedef RoomsCollectionList = List<RoomCollection>;

class RoomDb {
  Isar? customDbInstance;

  RoomDb({this.customDbInstance});

  // Start body
  Isar? get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance;
  }

  IsarRoomCollection? get roomCollection {
    return dbInstance?.rooms;
  }

  /// Set [replaceData] to true if you want to replace some value with null.
  /// If [replaceData] is false all null properties in [room] will be ignored and local db
  /// data will be updated with non null properties from [room] only.
  Future<void> putRoom(RoomCollection room, {
    bool replaceData = false,
  }) async {
    await dbInstance?.writeTxn(() async {
      if (replaceData) {
        await roomCollection?.put(room);
      } else {
        try {
          final localRoom = await getRoom(room.id!);
          if (localRoom != null) {
            // if update room
            localRoom.update(room);
            await roomCollection?.put(localRoom);
            return localRoom;
          } else {
            // if new room
            await roomCollection?.put(room);
            return room;
          }
        } catch (e, stacktrace) {
          _log.e('putRoomWithoutTxn error', e, stacktrace);
          return null;
        }
      }
    });
  }

  /// Update all rooms in local db with [rooms]'s data.
  Future<void> updateAllRoom(List<RoomCollection> rooms) async {
    await dbInstance?.writeTxn(() async {
      for (final room in rooms) {
        await putRoomWithoutTxn(room);
      }
    });
  }

  /// Put and replace all rooms in local db with [rooms]'s data.
  Future<int?> putAllRoom(List<RoomCollection> rooms) async {
    return await dbInstance?.writeTxn(() async {
      return (await roomCollection?.putAll(rooms))?.length;
    });
  }

  Future<int?> putAllRoomWithoutTxn(List<RoomCollection> rooms) async {
    return (await roomCollection?.putAll(rooms))?.length;
  }

  /// Update all rooms in local db with [rooms]'s data.
  Future<void> updateAllRoomWithoutTxn(List<RoomCollection> rooms) async {
    for (final room in rooms) {
      await putRoomWithoutTxn(room);
    }
  }

  Future<RoomCollection?> putRoomWithoutTxn(RoomCollection room, {
    bool replaceData = false,
  }) async {
    try {
      if (replaceData) {
        await roomCollection?.put(room);
        return room;
      } else {
        final localRoom = await getRoom(room.id!);
        if (localRoom != null) {
          // if update room
          localRoom.update(room);
          await roomCollection?.put(localRoom);
          return localRoom;
        } else {
          // if new room
          await roomCollection?.put(room);
          return room;
        }
      }
    } catch (e, stacktrace) {
      _log.e('putRoomWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> putOrUpdateRoom(RoomCollection room) async {
    await dbInstance?.writeTxn(() async {
      try {
        final localRoom = await getRoom(room.id!);
        if (localRoom != null) {
          // if update room
          localRoom.update(room);
          await roomCollection?.put(localRoom);
        } else {
          // if new room
          await roomCollection?.put(room);
        }
      } catch (e, stacktrace) {
        _log.e('putOrUpdateRoom error', e, stacktrace);
      }
    });
  }

  Future<RoomCollection?> getRoom(String id) async {
    return roomCollection?.get(fastHash(id));
  }

  RoomCollection? getRoomSync(String id) {
    return roomCollection?.getSync(fastHash(id));
  }

  Future<List<RoomCollection>?>? getRooms(List<String> ids) async {
    return roomCollection?.where().anyOf(ids, (q, element) => q.idEqualTo(element)).findAll();
  }

  Future<List<RoomCollection>?> getRoomsNotSecretAndNotBookmark(List<String> ids) async {
    if (roomCollection == null) return null;
    return roomCollection!
        .where()
        .anyOf(ids, (q, element) => q.idEqualTo(element))
        .filter()
        .isSecretRoomEqualTo(false)
        .isBookmarkEqualTo(false)
        .findAll();
  }

  Future<RoomCollection?> getBookmarkRoom() async {
    if (roomCollection == null) return null;
    return roomCollection!
        .filter()
        .isBookmarkEqualTo(true)

    /// sortById is used to handle rare case when there is more than 1 bookmark room.
    /// In that case the correct room to use should be the oldest one.
        .sortById()
        .findFirst();
  }

  RoomQAfterSort? getLatestSearchQuery() {
    if (roomCollection == null) return null;
    return roomCollection!.where().canShowInLatestSearchEqualTo(true).sortByLatestSearchDesc();
  }

  Future<RoomCollectionList?> getRoomLatestSearch({int? limit}) async {
    final query = getLatestSearchQuery();

    if (query == null) return null;

    if (limit != null) {
      return query.limit(limit).findAllSync();
    }

    return await query.findAll();
  }

  Future<void> clearAllLatestSearch() async {
    RoomCollectionList? roomList = await getRoomLatestSearch();
    if (roomList == null) return;
    return await dbInstance?.writeTxn(() async {
      for (final room in roomList) {
        room.latestSearch = null;
      }
      await roomCollection?.putAll(roomList);
    });
  }

  Future<bool> deleteRoom(String id) async {
    if (roomCollection == null || dbInstance == null) return false;
    return await dbInstance!.writeTxn(() async {
      return await roomCollection!.delete(fastHash(id));
    });
  }

  Future<bool> deleteRoomWithoutTxn(String id) async {
    if (roomCollection == null) return false;
    return await roomCollection!.delete(fastHash(id));
  }

  Future<RoomCollectionList?> getRoomTypeGroup() async {
    if (roomCollection == null) return null;
    return roomCollection!
        .where()
        .isGroupEqualTo(true)
        .sortByNameLowercase()
        .thenByOriginalRoomName()
        .thenById()
        .findAll();
  }

  Future<RoomCollectionList?> getGroupsWithMeAsAnOwner() async {
    if (roomCollection == null) return null;
    return roomCollection!
        .where()
        .isGroupEqualTo(true)
        .filter()
        .meIsOwnerEqualTo(true)
        .sortByNameLowercase()
        .thenByOriginalRoomName()
        .thenById()
        .findAll();
  }

  Future<RoomCollectionList?> searchRoomTypeGroup(String keyword) async {
    if (roomCollection == null) return null;
    return roomCollection!
        .where()
        .isGroupEqualTo(true)
        .filter()
        .originalRoomNameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByOriginalRoomName()
        .thenById()
        .findAll();
  }

  RoomCollectionList? getRoomTypeDirectSync() {
    return roomCollection?.where().isDirectEqualTo(true).findAllSync();
  }

  Stream<void>? watchLazy({
    bool fireImmediately = false,
  }) {
    return roomCollection?.watchLazy(fireImmediately: fireImmediately);
  }

  Future<void> clearCollection() async {
    await roomCollection?.clear();
  }
}
