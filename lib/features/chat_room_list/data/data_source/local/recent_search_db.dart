import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarRecentSearchCollection = IsarCollection<RecentSearchCollection>;
typedef RecentSearchCollectionList = List<RecentSearchCollection>;
typedef RecentSearchQAfterFilterCondition
    = QueryBuilder<RecentSearchCollection, RecentSearchCollection, QAfterFilterCondition>;

class RecentSearchDb {
  Isar? customDbInstance;

  RecentSearchDb({this.customDbInstance});

  // Start body
  Isar? get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance;
  }

  IsarRecentSearchCollection? get recentSearchCollection {
    return dbInstance?.recentSearch;
  }

  Future<void> putAllRecentSearch(List<RecentSearchCollection> items) async {
    await dbInstance?.writeTxn(() async {
      await recentSearchCollection?.putAll(items);
    });
  }

  Future<void> putAllRecentSearchWithoutTxn(List<RecentSearchCollection> items) async {
    await recentSearchCollection?.putAll(items);
  }

  void putAllRecentSearchSync(List<RecentSearchCollection> items) {
    dbInstance?.writeTxn(() async {
      recentSearchCollection?.putAllSync(items);
    });
  }

  void putAllRecentSearchSyncWithoutTxn(List<RecentSearchCollection> items) {
    recentSearchCollection?.putAllSync(items);
  }

  Future<List<RecentSearchCollection>?> getAllRecentSearch() async {
    return await recentSearchCollection?.filter().idIsNotNull().sortByCreatedAtDesc().findAll();
  }

  List<RecentSearchCollection>? getAllRecentSearchSync() {
    return recentSearchCollection?.filter().idIsNotNull().sortByCreatedAtDesc().findAllSync();
  }

  Future<bool?> deleteRecentSearch(String id) async {
    return await dbInstance?.writeTxn(() async {
      return await recentSearchCollection?.delete(fastHash(id));
    });
  }

  Future<bool?> deleteRecentSearchWithoutTxn(String id) async {
    return await recentSearchCollection?.delete(fastHash(id));
  }

  Future<void> clearCollection() async {
    await dbInstance?.writeTxn(() async {
      await recentSearchCollection?.clear();
    });
  }

  Future<void> clearCollectionWithoutTxn() async {
    await recentSearchCollection?.clear();
  }
}
