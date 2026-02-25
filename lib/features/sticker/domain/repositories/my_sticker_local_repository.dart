import 'dart:async';

import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';

abstract class MyStickerLocalRepository {
  /// MyStickerCollection section
  /// This section is for managing my sticker packs.

  Future<List<MyStickerPackEntity>> getAllMyStickerPack();

  Future<void> putMyStickerPack(MyStickerPackEntity pack);

  Future<void> putAllMyStickerPacks(List<MyStickerPackEntity> packs);

  Future<MyStickerPackEntity?> getMyStickerPackWithId(String packId);

  Future<List<MyStickerPackEntity>> getMyStickerPackBetweenSeq({
    required int startSeq,
    required int endSeq,
    bool includeLower = false,
    bool includeUpper = false,
  });

  /// StickerCollection section
  /// This section is for managing individual stickers within sticker packs.

  Future<void> putSticker(StickerEntity sticker);

  Future<void> updateAllStickers(List<StickerEntity> stickers);

  Future<bool> updateStickerLastUsedAt(String packId, String fileId, DateTime dateTime);

  Future<List<StickerEntity>> getRecentlyUsedStickers({int limit = 40});
}
