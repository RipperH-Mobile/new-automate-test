import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/chat_folder_model.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarRoomSubscriptionCollection = IsarCollection<RoomSubscriptionCollection>;

final _log = useLogger();

class RoomSubscriptionDb {
  Isar? customDbInstance;

  RoomSubscriptionDb({this.customDbInstance});

  // Start body
  // TODO: fix to null safety
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarRoomSubscriptionCollection get roomSubscriptionCollection {
    return dbInstance.roomSubscription;
  }

  Future<RoomSubscriptionCollection?> getRoomSubscriptionWithId(String id) async {
    return await roomSubscriptionCollection.get(fastHash(id));
  }

  Future<RoomSubscriptionCollection?> getRoomSubscriptionWithRoomId(String id) async {
    return await roomSubscriptionCollection.where().roomIdEqualTo(id).findFirst();
  }

  RoomSubscriptionCollection? getRoomSubscriptionWithRoomIdSync(String id) {
    return roomSubscriptionCollection.where().roomIdEqualTo(id).findFirstSync();
  }

  Future<RoomSubscriptionCollection?> putRoomSubscription(
    RoomSubscriptionCollection roomSub, {
    bool replaceData = false,
  }) async {
    return await dbInstance.writeTxn(() async {
      try {
        if (replaceData) {
          await roomSubscriptionCollection.put(roomSub);
          return roomSub;
        } else {
          final localRoomSub = await getRoomSubscriptionWithRoomId(roomSub.roomId ?? '');
          if (localRoomSub != null) {
            localRoomSub.update(roomSub);
            await roomSubscriptionCollection.put(localRoomSub);
            return localRoomSub;
          } else {
            await roomSubscriptionCollection.put(roomSub);
            return roomSub;
          }
        }
      } catch (e, stacktrace) {
        _log.e('putRoomSubscription error.', e, stacktrace);
      }
      return null;
    });
  }

  /// Set [replaceData] to true if you want to replace some value with null.
  /// If [replaceData] is false all null properties in [roomSub] will be ignored and local db
  /// data will be updated with non null properties from [roomSub] only.
  Future<RoomSubscriptionCollection?> putRoomSubscriptionWithoutTxn(
    RoomSubscriptionCollection roomSub, {
    bool replaceData = false,
  }) async {
    if (replaceData) {
      await roomSubscriptionCollection.put(roomSub);
      return roomSub;
    } else {
      try {
        final localRoomSub = await getRoomSubscriptionWithRoomId(roomSub.roomId ?? '');
        if (localRoomSub != null) {
          // if update room subscription
          localRoomSub.update(roomSub);
          await roomSubscriptionCollection.put(localRoomSub);
          return localRoomSub;
        } else {
          // if new room subscription
          await roomSubscriptionCollection.put(roomSub);
          return roomSub;
        }
      } catch (e, stacktrace) {
        _log.e('putRoomSubscriptionWithoutTxn error', e, stacktrace);
        return null;
      }
    }
  }

  /// Update all roomSubs in local db with [roomSubs]'s data.
  Future<void> updateAllRoomSubscription(
    List<RoomSubscriptionCollection> roomSubs,
  ) async {
    await dbInstance.writeTxn(() async {
      for (final roomSub in roomSubs) {
        await putRoomSubscriptionWithoutTxn(roomSub);
      }
    });
  }

  /// Update all roomSubs in local db with [roomSubs]'s data.
  Future<void> updateAllRoomSubscriptionWithoutTxn(
    List<RoomSubscriptionCollection> roomSubs,
  ) async {
    for (final roomSub in roomSubs) {
      await putRoomSubscriptionWithoutTxn(roomSub);
    }
  }

  /// Put and replace all roomSubs in local db with [roomSubs]'s data.
  Future<int> putAllRoomSub(List<RoomSubscriptionCollection> roomSubs) async {
    return await dbInstance.writeTxn(() async {
      return (await roomSubscriptionCollection.putAll(roomSubs)).length;
    });
  }

  Future<int?> putAllRoomSubWithoutTxn(List<RoomSubscriptionCollection> roomSubs) async {
    return (await roomSubscriptionCollection.putAll(roomSubs)).length;
  }

  List<RoomSubscriptionCollection?> getRoomSubscriptionWithIdsSync(List<String> ids, {bool desc = false}) {
    final query = roomSubscriptionCollection.filter().anyOf(ids, (q, element) => q.roomIdEqualTo(element));
    if (!desc) {
      return query.sortByRoomLocalDateTime().findAllSync();
    } else {
      return query.sortByRoomLocalDateTimeDesc().findAllSync();
    }
  }

  Future<int> getAllUnreadCount() async {
    return await roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .isHiddenEqualTo(false)
        .unreadCountProperty()
        .sum();
  }

  Future<List<RoomSubscriptionCollection>> getRoomCanShowInShare({
    int page = 1,
    int pageSize = 20,
  }) {
    final query = roomSubscriptionCollection.where().canShowInShareEqualTo(true).sortByRoomLocalDateTimeDesc();
    final offset = (page - 1) * pageSize;

    return query.offset(offset).limit(pageSize).findAll();
  }

  Future<int> getRoomCanShowInShareCount() async {
    return await roomSubscriptionCollection.where().canShowInShareEqualTo(true).count();
  }

  Future<List<RoomSubscriptionCollection>> getRecentDirectChat({
    int? limit,
    String? keyword,
    int? offset,
  }) {
    if (keyword == null) {
      final query = roomSubscriptionCollection
          .where()
          .canShowInShareEqualTo(true)
          .filter()
          .isDirectEqualTo(true)
          .isDirectChatFriendEqualTo(true)
          .sortByRoomLocalDateTimeDesc();

      if (limit != null) {
        if (offset != null) {
          return query.offset(offset).limit(limit).findAll();
        } else {
          return query.limit(limit).findAll();
        }
      }

      if (offset != null) {
        return query.offset(offset).findAll();
      } else {
        return query.findAll();
      }
    } else {
      final query = roomSubscriptionCollection
          .where()
          .canShowInShareEqualTo(true)
          .filter()
          .isDirectEqualTo(true)
          .roomNameContains(keyword, caseSensitive: false)
          .sortByRoomLocalDateTimeDesc();

      if (limit != null) {
        if (offset != null) {
          return query.offset(offset).limit(limit).findAll();
        } else {
          return query.limit(limit).findAll();
        }
      }

      if (offset != null) {
        return query.offset(offset).findAll();
      } else {
        return query.findAll();
      }
    }
  }

  List<RoomSubscriptionCollection> searchRoomCanShowInShareSync(
    String keyword, {
    int? limit,
  }) {
    final query = roomSubscriptionCollection
        .where()
        .canShowInShareEqualTo(true)
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .roomNameContains(keyword, caseSensitive: false)
        .or()
        .roomNameIsNull()
        .sortByUpdatedAt();

    if (limit != null) {
      return query.limit(limit).findAllSync();
    }

    return query.findAllSync();
  }

  Future<List<RoomSubscriptionCollection>> getRoomForSharePreview({int? limit}) {
    final query = roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .canShowInShareEqualTo(true)
        .sortByLatestShareDesc()
        .thenByRoomLocalDateTimeDesc();

    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  List<RoomSubscriptionCollection> getRoomLatestShareSync({int? limit}) {
    final query = roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .canShowInLatestShareEqualTo(true)
        .sortByLatestShareDesc();

    if (limit != null) {
      return query.limit(limit).findAllSync();
    }

    return query.findAllSync();
  }

  Future<List<RoomSubscriptionCollection>> getRoomLatestShare({int? limit}) {
    final query = roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .canShowInLatestShareEqualTo(true)
        .sortByLatestShareDesc();

    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  List<RoomSubscriptionCollection> searchRoomLatestShareSync(
    String keyword, {
    int? limit,
  }) {
    final query = roomSubscriptionCollection
        .where()
        .canShowInLatestShareEqualTo(true)
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .roomNameContains(keyword, caseSensitive: false)
        .or()
        .roomNameIsNull()
        .sortByLatestShareDesc();

    if (limit != null) {
      return query.limit(limit).findAllSync();
    }

    return query.findAllSync();
  }

  Future<List<RoomSubscriptionCollection>> getAllHiddenRoomSub() async {
    return roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .isHiddenEqualTo(true)
        .lastMessageIsNotNull()
        .sortByHiddenAtDesc()
        .findAll();
  }

  Future<List<RoomSubscriptionCollection>> getRoomSubTypeGroup() async {
    return roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .isGroupEqualTo(true)
        .findAll();
  }

  Future<List<RoomSubscriptionCollection>> searchRoomTypeGroup({
    required String keyword,
    int? limit,
  }) async {
    final query = roomSubscriptionCollection
        .where()
        .canShowInGroupSearchEqualTo(true)
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .roomNameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByRoomName()
        .thenById();
    if (limit != null) {
      return query.limit(limit).findAll();
    } else {
      return query.findAll();
    }
  }

  Future<List<RoomSubscriptionCollection>> searchRoomTypeDirects(String keyword) async {
    return roomSubscriptionCollection
        .where()
        .canShowInDirectSearchEqualTo(true)
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .roomNameContains(keyword, caseSensitive: false)
        .hasMessageEqualTo(true)
        .sortByRoomLocalDateTimeDesc()
        .findAll();
  }

  ///
  Future<List<RoomSubscriptionCollection>> getAllRoomSubByChatFolderId({
    required String chatFolderId,
    bool? isPinned,
  }) async {
    if (isPinned != null) {
      return roomSubscriptionCollection
          .filter()
          .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
          .chatFoldersIsNotNull()
          .chatFoldersIsNotEmpty()
          .chatFoldersElement((q) => q.folderIdEqualTo(chatFolderId).isPinnedEqualTo(isPinned))
          .findAll();
    } else {
      return roomSubscriptionCollection
          .filter()
          .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
          .chatFoldersIsNotNull()
          .chatFoldersIsNotEmpty()
          .chatFoldersElement((q) => q.folderIdEqualTo(chatFolderId))
          .findAll();
    }
  }

  Future<List<RoomSubscriptionCollection>> searchRoomCanEdit(String keyword) async {
    return roomSubscriptionCollection
        .where()
        .hasMessageEqualTo(true)
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .roomNameContains(keyword, caseSensitive: false)
        .findAll();
  }

  Future<List<RoomSubscriptionCollection>> getAllRoom({bool enableBookmark = false}) {
    if (enableBookmark) {
      return roomSubscriptionCollection.where().canShowInChatListEqualTo(true).build().findAll();
    } else {
      return roomSubscriptionCollection
          .where()
          .canShowInChatListEqualTo(true)
          .filter()
          .isBookmarkEqualTo(false)
          .build()
          .findAll();
    }
  }

  Future<List<RoomSubscriptionCollection>> getLatestDirectChatRooms({
    int limit = 10,
  }) async {
    return roomSubscriptionCollection
        .filter()
        .group(
            (q) => q.isRoomDeletedIsNull().or().group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false)))
        .isDirectEqualTo(true)
        //NOTE: If other friends not accept will be null.
        // .hasFirstOtherInRoomEqualTo(true)
        .sortByRoomLocalDateTimeDesc()
        .limit(limit)
        .findAll();
  }

  Stream<void> watchLazy({
    bool fireImmediately = false,
  }) {
    return roomSubscriptionCollection.watchLazy(fireImmediately: fireImmediately);
  }

  Future<void> deleteRoomSubWithRoomId(String roomId) async {
    await dbInstance.writeTxn(() async {
      await roomSubscriptionCollection.where().roomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<void> deleteRoomSubWithRoomIdWithoutTxn(String roomId) async {
    await roomSubscriptionCollection.where().roomIdEqualTo(roomId).deleteAll();
  }

  Future<void> clearCollection() async {
    await roomSubscriptionCollection.clear();
  }

  Future<int> countPinedRoomAllChat() async {
    final count = await roomSubscriptionCollection
        .filter()
        .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
        .isPinnedEqualTo(true)
        .isSecretRoomEqualTo(false)
        .count();
    return count;
  }

  Future<int> countPinedRoomInFolder() async {
    final count = await roomSubscriptionCollection
        .filter()
        .chatFoldersIsNotNull()
        .chatFoldersIsNotEmpty()
        .isSecretRoomEqualTo(false)
        .chatFoldersElement((q) => q.isPinnedEqualTo(true))
        .count();
    return count;
  }

  Future<List<RoomSubscriptionCollection>?> getAllUnreadRoom() async {
    return await roomSubscriptionCollection.filter().unreadCountGreaterThan(0).findAll();
  }

  Future<RoomSubscriptionCollection?> getRoomSubscriptionByRoomAndAccount(String roomId, String accountId) async {
    return await roomSubscriptionCollection
        .where()
        .filter()
        .roomIdEqualTo(roomId)
        .and()
        .accountIdEqualTo(accountId)
        .findFirst();
  }

  Future<List<RoomSubscriptionCollection>?> getAllRoomSubscriptionByChatFolder({
    required String chatFolderId,
    bool? isPinned,
  }) async {
    if (isPinned != null) {
      return await roomSubscriptionCollection
          .filter()
          .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
          .chatFoldersIsNotEmpty()
          .chatFoldersElement((q) => q.folderIdEqualTo(chatFolderId).isPinnedEqualTo(isPinned))
          .findAll();
    } else {
      return await roomSubscriptionCollection
          .filter()
          .group((q) => q.isRoomDeletedIsNull().or().isRoomDeletedEqualTo(false))
          .chatFoldersIsNotEmpty()
          .chatFoldersElement((q) => q.folderIdEqualTo(chatFolderId))
          .findAll();
    }
  }
}
