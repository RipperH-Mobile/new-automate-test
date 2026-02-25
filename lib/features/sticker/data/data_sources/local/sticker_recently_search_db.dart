import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_recently_search_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

class StickerRecentlySearchDb {
  Isar? customDbInstance;

  StickerRecentlySearchDb({this.customDbInstance});

  // Get the Isar database instance
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarCollection<StickerRecentlySearchCollection> get recentlySearchCollection {
    return dbInstance.stickerRecentlySearches;
  }

  Future<List<StickerRecentlySearchCollection>> getAllRecentlySearches() async {
    return recentlySearchCollection.where().sortByLastOpenedAtDesc().limit(30).findAll();
  }

  Future<void> addRecentlySearch(StickerRecentlySearchCollection stickerPack, DateTime lastOpenedAt) async {
    stickerPack.lastOpenedAt = lastOpenedAt;
    await dbInstance.writeTxn(() async {
      await recentlySearchCollection.put(stickerPack);
    });
  }

  Future<void> deleteRecentlySearch(String id) async {
    await dbInstance.writeTxn(() async {
      await recentlySearchCollection.delete(fastHash(id));
    });
  }

  Future<void> clearRecentlySearches() async {
    await dbInstance.writeTxn(() async {
      await recentlySearchCollection.clear();
    });
  }
}
