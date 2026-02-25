import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';

abstract class StoreStickerLocalRepository {
  Future<List<StickerEntity>> getStickersWithEmoji(String emoji);

  Future<List<StickerEntity>> getAllStickersWithPackId(String packId);
}
