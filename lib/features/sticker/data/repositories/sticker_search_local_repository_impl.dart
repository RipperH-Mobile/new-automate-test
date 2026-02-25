import 'package:uchat/features/sticker/data/data_sources/local/sticker_recently_search_db.dart';
import 'package:uchat/features/sticker/data/models/collections/sticker_recently_search_collection.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';

class StickerSearchLocalRepositoryImpl implements StickerSearchLocalRepository {
  final StickerRecentlySearchDb stickerRecentlySearchDb;

  StickerSearchLocalRepositoryImpl({required this.stickerRecentlySearchDb});

  @override
  Future<void> addRecentlySearch(StoreStickerPackEntity stickerPack) async {
    final stickerRecentlySearchCollection = StickerRecentlySearchCollection.fromEntity(stickerPack);
    return await stickerRecentlySearchDb.addRecentlySearch(
      stickerRecentlySearchCollection,
      DateTime.now(),
    );
  }

  @override
  Future<void> clearRecentlySearches() async {
    return await stickerRecentlySearchDb.clearRecentlySearches();
  }

  @override
  Future<void> deleteRecentlySearch(String id) async {
    return await stickerRecentlySearchDb.deleteRecentlySearch(id);
  }

  @override
  Future<List<StoreStickerPackEntity>> getAllRecentlySearch() async {
    final recentlySearches = await stickerRecentlySearchDb.getAllRecentlySearches();
    return recentlySearches.map((e) => e.toEntity()).toList();
  }
}
