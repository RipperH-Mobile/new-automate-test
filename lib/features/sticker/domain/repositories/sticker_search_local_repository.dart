import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

abstract class StickerSearchLocalRepository {
  Future<List<StoreStickerPackEntity>> getAllRecentlySearch();

  Future<void> addRecentlySearch(StoreStickerPackEntity stickerPack);

  Future<void> deleteRecentlySearch(String id);

  Future<void> clearRecentlySearches();
}
