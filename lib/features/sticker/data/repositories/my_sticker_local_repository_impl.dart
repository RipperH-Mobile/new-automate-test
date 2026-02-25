import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/data/models/collections/my_sticker_collection.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_collection.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';

class MyStickerLocalRepositoryImpl implements MyStickerLocalRepository {
  final StickerDb stickerDb;

  MyStickerLocalRepositoryImpl({required this.stickerDb});

  /// MyStickerCollection section
  /// This section is for managing my sticker packs.

  @override
  Future<List<MyStickerPackEntity>> getAllMyStickerPack() async {
    final result = await stickerDb.getAllMyStickerPack();
    final resultEntity = result.map((e) => e.toEntity()).toList();
    List<MyStickerPackEntity> expiredPacks = [];
    for (final pack in resultEntity) {
      if (pack.isExpire) {
        expiredPacks.add(pack);
      }
    }
    // Move expired pack to the end of the list.
    for (final removed in expiredPacks) {
      resultEntity.remove(removed);
      resultEntity.add(removed);
    }
    return resultEntity;
  }

  @override
  Future<void> putMyStickerPack(MyStickerPackEntity pack) async {
    final collectionPack = MyStickerCollection.fromEntity(pack);
    return await stickerDb.putMyStickerPack(collectionPack);
  }

  @override
  Future<void> putAllMyStickerPacks(List<MyStickerPackEntity> packs) async {
    final collectionPacks = packs.map((pack) => MyStickerCollection.fromEntity(pack)).toList();
    for (final pack in collectionPacks) {
      final stickerItemEntity = packs.firstWhere((e) => e.id == pack.id);
      pack.stickerItems
          .addAll(stickerItemEntity.stickerItems.map((item) => StickerCollection.fromEntity(item)).toList());
    }
    return await stickerDb.putAllMyStickerPacks(collectionPacks);
  }

  @override
  Future<MyStickerPackEntity?> getMyStickerPackWithId(String packId) async {
    final collectionPack = await stickerDb.getMyStickerPackWithId(packId);
    return collectionPack?.toEntity();
  }

  @override
  Future<List<MyStickerPackEntity>> getMyStickerPackBetweenSeq({
    required int startSeq,
    required int endSeq,
    bool includeLower = false,
    bool includeUpper = false,
  }) async {
    final result = await stickerDb.getMyStickerPackBetweenSeq(
      startSeq: startSeq,
      endSeq: endSeq,
      includeLower: includeLower,
      includeUpper: includeUpper,
    );
    return result.map((e) => e.toEntity()).toList();
  }

  /// StickerCollection section
  /// This section is for managing individual stickers within sticker packs.

  @override
  Future<void> putSticker(StickerEntity sticker) async {
    await stickerDb.putSticker(StickerCollection.fromEntity(sticker));
  }

  @override
  Future<void> updateAllStickers(List<StickerEntity> stickers) async {
    final collectionStickers = stickers.map((sticker) => StickerCollection.fromEntity(sticker)).toList();
    return await stickerDb.updateAllStickers(collectionStickers);
  }

  // Update the last used date of a sticker.
  // Return true if the update was successful, Return false if sticker is not found in local db.
  @override
  Future<bool> updateStickerLastUsedAt(String packId, String fileId, DateTime lastUsedAt) async {
    return await stickerDb.updateStickerLastUsedAt(packId, fileId, lastUsedAt);
  }

  @override
  Future<List<StickerEntity>> getRecentlyUsedStickers({int limit = 40}) async {
    final result = await stickerDb.getRecentlyUsedStickers(limit: limit);
    return result.map((e) => e.toEntity()).toList();
  }
}
