import 'package:dio/dio.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_backend_path.dart';
import 'package:uchat/features/sticker/data/models/payloads/buy_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/check_sticker_owner_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_received_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sent_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sticker_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_all_sticker_pack_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_by_emoji_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/send_gift_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_list_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_pagination_payload.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

final _log = useLogger();

class StickerHttpDataSource {
  final HttpCaller httpCaller;

  StickerHttpDataSource({
    required this.httpCaller,
  });

  Future<StoreStickerPackListResponse?> getStickerMainScreen(StoreStickerPackListRequest request) async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getStickerMainScreen.socket,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3((data) => StoreStickerPackListResponse.fromMap(data));
  }

  Future<StoreStickerPackPaginationResponse?> getStickerSection(StoreStickerPackListRequest request) async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getStickerSection.http,
      queryParameters: request.toMap(),
    );

    return httpResp.mapToResponse((data) => StoreStickerPackPaginationResponse.fromMap(data));
  }

  Future<List<StoreStickerPackEntity>> getStickerFavorite() async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getFavoriteStickerPack.http,
    );

    return httpResp.listToResponseV3((e) => StoreStickerPackEntity.fromMap(e))?.toList() ?? [];
  }

  Future<SearchStickerByEmojiResponse> searchStickerByEmoji(SearchStickerByEmojiRequest request) async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.searchStickerByEmoji.http,
      data: request.toMap(),
    );

    return SearchStickerByEmojiResponse.fromList(httpResp.data);
  }

  Future<StoreStickerPackEntity?> getStickerDetail({required String stickerPackId}) async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getStickerDetailV3.http.replaceAll(':stickerPackId', stickerPackId),
    );

    return httpResp.mapToResponseV3(
      (data) => StoreStickerPackEntity.fromMap(data),
    );
  }

  Future<void> acquireStickerPack({required String stickerPackId}) async {
    await httpCaller.post(
      StickerBackendPath.acceptStickerPack.http.replaceAll(':stickerPackId', stickerPackId),
    );
  }

  Future<void> toggleFavoriteSticker({required String stickerPackId}) async {
    await httpCaller.post(
      StickerBackendPath.favoriteStickerV3.http.replaceAll(':stickerPackId', stickerPackId),
    );
  }

  Future<BuyStickerResponse?> buySticker({
    required BuyStickerRequest request,
  }) async {
    final httpResp = await httpCaller.post(
      StickerBackendPath.buyStickerV3.http.replaceAll(':stickerPackId', request.stickerId),
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3(
      (data) => BuyStickerResponse.fromMap(data),
    );
  }

  Future<bool> checkOwnerSticker({required CheckStickerOwnerRequest request}) async {
    final httpResp = await httpCaller.post(
      StickerBackendPath.checkOwnerStickerV3.http.replaceAll(':stickerPackId', request.stickerId),
      data: request.toMap(),
    );

    if (httpResp.data == null) {
      _log.e('CheckOwnerSticker response is null');
      return false;
    }

    return httpResp.data['data'] ?? false;
  }

  Future<BuyStickerResponse?> sendGiftSticker({required SendGiftRequest request}) async {
    final httpResp = await httpCaller.post(
      StickerBackendPath.sendGiftStickerV3.http.replaceAll(':stickerPackId', request.stickerId),
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3(
      (data) => BuyStickerResponse.fromMap(data),
    );
  }

  Future<CursorPayload<StickerHistoryEntity>?> getHistorySticker({required FetchStickerHistoryRequest request}) async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getHistorySticker.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3((e) => CursorPayload<StickerHistoryEntity>.fromMapV3(e));
  }

  Future<CursorPayload<GetReceivedStickerGiftHistoryResponse>?> getReceivedStickerGiftHistory(
      {required GetReceivedStickerGiftHistoryRequest request}) async {
    final response = await httpCaller.get(
      StickerBackendPath.getReceivedStickerHistory.http,
      data: request.toJson(),
    );

    return CursorPayload.fromMapV3(
      response.data,
      listMapper: (e) {
        return GetReceivedStickerGiftHistoryResponse.fromJson(List<Map<String, dynamic>>.from(e)).toList();
      },
    );
  }

  Future<CursorPayload<GetSentStickerGiftHistoryResponse>?> getSentStickerGiftHistory(
      {required GetSentStickerGiftHistoryRequest request}) async {
    final response = await httpCaller.get(
      StickerBackendPath.getSentStickerHistory.http,
      data: request.toJson(),
    );

    return CursorPayload.fromMapV3(
      response.data,
      listMapper: (e) {
        return GetSentStickerGiftHistoryResponse.fromJson(List<Map<String, dynamic>>.from(e)).toList();
      },
    );
  }

  Future<List<int>> downloadStickerItem({required String packId, required String fileId}) async {
    final url = 'sticker/$packId/file/$fileId';
    final httpResp = await httpCaller.get(url, options: Options(responseType: ResponseType.bytes));
    if (httpResp.data is List<int>) {
      return httpResp.data as List<int>;
    } else {
      _log.e('Download sticker item failed, response data is not a List<int>');
      return [];
    }
  }

  Future<void> reorderStickerPacksToTheTop({required ReorderStickerPacksToTheTopRequest request}) async {
    await httpCaller.put(
      StickerBackendPath.reorderStickerPacksToTheTop.http,
      data: request.toMap(),
    );
  }

  Future<void> reorderAllStickerPack({required ReorderAllStickerPackRequest request}) async {
    await httpCaller.put(
      StickerBackendPath.reorderAllStickerPack.http,
      data: request.toMap(),
    );
  }

  Future<List<MyStickerPackEntity>> getAllMySticker() async {
    final httpResp = await httpCaller.get(
      StickerBackendPath.getAllMySticker.http,
    );

    return httpResp.listToResponseV3((e) => MyStickerPackEntity.fromMap(e))?.toList() ?? [];
  }

  Future<CursorPayload<StoreStickerPackEntity>?> searchSticker({required SearchStickerRequest request}) async {
    final httpResp = await httpCaller.get(StickerBackendPath.searchStickers.http, queryParameters: request.toMap());
    return httpResp.mapToResponseV3((data) {
      return CursorPayload<StoreStickerPackEntity>.fromMapV3(data);
    });
  }
}
