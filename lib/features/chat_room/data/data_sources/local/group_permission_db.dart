import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/group_permission_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarGroupPermissionCollection = IsarCollection<GroupPermissionCollection>;
typedef GroupPermissionCollectionList = List<GroupPermissionCollection>;
typedef GroupPermissionSubscription = StreamSubscription<List<GroupPermissionCollection>>;
typedef GroupPermissionQAfterFilterCondition
    = QueryBuilder<GroupPermissionCollection, GroupPermissionCollection, QAfterFilterCondition>;

class GroupPermissionDb {
  // Singleton pattern
  static final GroupPermissionDb instance = GroupPermissionDb._internal();

  factory GroupPermissionDb() => instance;

  GroupPermissionDb._internal();

  // Start body
  Isar? get dbInstance {
    return DbManager().authenticatedInstance;
  }

  IsarGroupPermissionCollection? get groupPermissionCollection {
    return dbInstance?.groupPermissions;
  }

  Future<GroupPermissionCollection?> getByRoomId(String roomId) async {
    if (groupPermissionCollection == null) return null;
    return groupPermissionCollection?.get(fastHash(roomId));
  }

  Future<void> save(GroupPermissionCollection permission) async {
    try {
      await groupPermissionCollection?.put(permission);
    } catch (_) {
      await dbInstance?.writeTxn(() async {
        await groupPermissionCollection?.put(permission);
      });
    }
  }

  Future<void> saveAll(List<GroupPermissionCollection> permissions) async {
    try {
      await groupPermissionCollection?.putAll(permissions);
    } catch (_) {
      await dbInstance?.writeTxn(() async {
        await groupPermissionCollection?.putAll(permissions);
      });
    }
  }

  Stream<GroupPermissionCollection> watchByRoomId(String roomId) {
    if (groupPermissionCollection == null) {
      return const Stream.empty();
    }

    return groupPermissionCollection!
        .where()
        .roomIdEqualTo(roomId)
        .watch(fireImmediately: true)
        .where((list) => list.isNotEmpty)
        .map((list) => list.first);
  }

  Future<List<GroupPermissionCollection>> getGroupPermissionWithIds(List<String> roomIds) {
    return groupPermissionCollection!.where().anyOf(roomIds, (q, element) => q.roomIdEqualTo(element)).findAll();
  }
}
