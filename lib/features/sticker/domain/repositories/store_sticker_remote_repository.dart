import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/buy_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/check_sticker_owner_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_received_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sent_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_by_emoji_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/send_gift_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_list_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_pagination_payload.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_received_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_sent_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

abstract class StoreStickerRemoteRepository {
  Future<void> acquireStickerPack({required String stickerPackId});

  Future<BuyStickerResponse?> buySticker({required BuyStickerRequest request});

  Future<bool> checkOwnerSticker({required CheckStickerOwnerRequest request});

  Future<StoreStickerPackListResponse?> fetchStoreStickers(StoreStickerPackListRequest request);

  Future<CursorPayload<StickerGiftReceivedEntity>?> fetchReceivedStickerGiftHistory(
      {required GetReceivedStickerGiftHistoryRequest request});

  Future<CursorPayload<StickerGiftSentEntity>?> fetchSentStickerGiftHistory(
      {required GetSentStickerGiftHistoryRequest request});

  Future<StoreStickerPackPaginationResponse?> fetchStickersByType(StoreStickerPackListRequest request);

  Future<List<StoreStickerPackEntity>> getStickerFavorite();

  Future<StoreStickerPackEntity?> getStickerDetail({required String stickerPackId});

  Future<SearchStickerByEmojiResponse?> searchStickerByEmoji(SearchStickerByEmojiRequest request);

  Future<CursorPayload<StoreStickerPackEntity>?> searchSticker(SearchStickerRequest request);

  Future<BuyStickerResponse?> sendGiftSticker({required SendGiftRequest request});

  Future<void> toggleFavoriteSticker({required String stickerPackId});
}
