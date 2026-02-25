import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sticker_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_all_sticker_pack_payload.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';

abstract class MyStickerRemoteRepository {
  Future<CursorPayload<StickerHistoryEntity>?> getHistorySticker({required FetchStickerHistoryRequest request});

  Future<void> reorderStickerPacksToTheTop({required ReorderStickerPacksToTheTopRequest request});

  Future<void> reorderAllStickerPack({required ReorderAllStickerPackRequest request});

  Future<List<MyStickerPackEntity>> getAllMySticker();
}
