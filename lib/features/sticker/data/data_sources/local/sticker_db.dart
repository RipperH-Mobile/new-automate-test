import 'dart:async';

import 'package:collection/collection.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_collection.dart';

typedef StickerQAfterFilterCondition = QueryBuilder<MyStickerCollection, MyStickerCollection, QAfterFilterCondition>;
typedef IsarMyStickerCollection = IsarCollection<MyStickerCollection>;
typedef IsarStickerCollection = IsarCollection<StickerCollection>;
typedef MyStickerCollectionList = List<MyStickerCollection>;

class StickerDb {
  Isar? customDbInstance;

  StickerDb({this.customDbInstance});

  // Get the Isar database instance
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarMyStickerCollection get myStickerCollection {
    return dbInstance.myStickers;
  }

  IsarStickerCollection get stickerCollection {
    return dbInstance.stickers;
  }

  /// MyStickerCollection section
  /// This section is for managing my sticker packs.

  StickerQAfterFilterCondition getMyStickerPackQuery() {
    return myStickerCollection.filter().idIsNotEmpty().isPublishEqualTo(true);
  }

  Future<MyStickerCollectionList> getAllMyStickerPackWithIds(List<String> ids) async {
    return myStickerCollection.filter().anyOf(ids, (q, id) => q.idEqualTo(id)).findAll();
  }

  // This will return all my sticker packs that are published.
  Future<MyStickerCollectionList> getAllMyStickerPack() async {
    // The order of result will be
    // 1.Pack that have seq > 0 and will be sorted by the order of seq
    // 2.Pack that have seq = 0 and will be sorted by isDownloaded. isDownloaded is true will be at the top.
    // 3.Pack that have seq = 0 and isDownloaded is false will be sorted by receivedAt. Latest received pack will be at the top.
    return getMyStickerPackQuery().sortByOrderNo().thenByIsDownloadedDesc().thenByReceivedAtDesc().findAll();
  }

  Future<void> putMyStickerPack(MyStickerCollection pack) async {
    await dbInstance.writeTxn(() async {
      await myStickerCollection.put(pack);
    });
  }

  Future<void> putAllMyStickerPacks(List<MyStickerCollection> packs) async {
    await dbInstance.writeTxn(() async {
      await myStickerCollection.putAll(packs);
      for (final pack in packs) {
        await pack.stickerItems.save();
      }
    });
  }

  Future<void> putAllMyStickerPacksWithoutTxn(List<MyStickerCollection> packs) async {
    await myStickerCollection.putAll(packs);
    for (final pack in packs) {
      await pack.stickerItems.save();
    }
  }

  Future<MyStickerCollection?> getMyStickerPackWithId(String packId) async {
    final stickerPack = await getMyStickerPackQuery().idEqualTo(packId).findFirst();
    return stickerPack;
  }

  Future<MyStickerCollectionList> getMyStickerPackBetweenSeq({
    required int startSeq,
    required int endSeq,
    bool includeLower = false,
    bool includeUpper = false,
  }) async {
    return myStickerCollection
        .filter()
        .seqBetween(startSeq, endSeq, includeLower: includeLower, includeUpper: includeUpper)
        .findAll();
  }

  /// StickerCollection section
  /// This section is for managing individual stickers within sticker packs.

  Future<void> putSticker(StickerCollection sticker) async {
    await dbInstance.writeTxn(() async {
      await stickerCollection.put(sticker);
    });
  }

  Future<void> updateAllStickers(List<StickerCollection> stickers) async {
    List<String> ids = stickers.map((e) => e.id).toList();
    // Query local data and add lastUsedAt data in stickers if it exists to prevent lastUsedAt from being replaced with null.
    final collections = (await stickerCollection.getAllById(ids)).where((e) => e != null);
    for (int i = 0; i < stickers.length; i++) {
      final sticker = collections.firstWhereOrNull((e) => e?.id == stickers[i].id);
      if (sticker != null) {
        stickers[i].lastUsedAt = sticker.lastUsedAt;
      }
    }
    await dbInstance.writeTxn(() async {
      await stickerCollection.putAll(stickers);
    });
  }

  Future<void> updateAllStickersWithoutTxn(List<StickerCollection> stickers) async {
    List<String> ids = stickers.map((e) => e.id).toList();
    // Query local data and add lastUsedAt data in stickers if it exists to prevent lastUsedAt from being replaced with null.
    final collections = (await stickerCollection.getAllById(ids)).where((e) => e != null);
    for (int i = 0; i < stickers.length; i++) {
      final sticker = collections.firstWhereOrNull((e) => e?.id == stickers[i].id);
      if (sticker != null) {
        stickers[i].lastUsedAt = sticker.lastUsedAt;
      }
    }

    await stickerCollection.putAll(stickers);
  }

  Future<StickerCollection?> getStickerById(
    String packId,
    String fileId,
  ) async {
    return await stickerCollection.filter().packIdEqualTo(packId).fileIdEqualTo(fileId).findFirst();
  }

  Future<bool> updateStickerLastUsedAt(
    String packId,
    String fileId,
    DateTime lastUsedAt,
  ) async {
    final stickerItem = await getStickerById(packId, fileId);
    if (stickerItem != null) {
      stickerItem.lastUsedAt = lastUsedAt;
      await putSticker(stickerItem);
      return true;
    }
    return false;
  }

  Future<List<StickerCollection>> getRecentlyUsedStickers({int limit = 40}) async {
    return stickerCollection.filter().lastUsedAtIsNotNull().sortByLastUsedAtDesc().limit(limit).findAll();
  }

  Future<List<StickerCollection>> getStickersWithEmoji(String emoji) async {
    return await stickerCollection.filter().emojiContains(emoji).findAll();
  }

  Future<List<StickerCollection>> getAllStickersWithPackId(String packId) async {
    List<StickerCollection> result = [];
    final col = await stickerCollection.filter().packIdContains(packId).findAll();
    for (StickerCollection sticker in col) {
      result.add(sticker);
    }
    return result;
  }
}
