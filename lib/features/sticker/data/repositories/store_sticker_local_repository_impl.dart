import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_local_repository.dart';

class StoreStickerLocalRepositoryImpl implements StoreStickerLocalRepository {
  final StickerDb stickerDb;

  StoreStickerLocalRepositoryImpl({required this.stickerDb});

  @override
  Future<List<StickerEntity>> getStickersWithEmoji(String emoji) async {
    final stickers = await stickerDb.getStickersWithEmoji(emoji);
    return stickers.map((item) => item.toEntity()).toList();
  }

  @override
  Future<List<StickerEntity>> getAllStickersWithPackId(String packId) async {
    final stickers = await stickerDb.getAllStickersWithPackId(packId);
    return stickers.map((item) => item.toEntity()).toList();
  }
}
