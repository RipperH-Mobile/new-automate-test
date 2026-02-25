import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_backend_path.dart';
import 'package:uchat/features/sticker/data/models/payloads/buy_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/check_sticker_owner_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_received_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sent_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sticker_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_all_sticker_pack_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_by_emoji_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/search_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/send_gift_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_list_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_pagination_payload.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

final _log = useLogger();

class StickerSocketDataSource {
  final SocketCaller socketCaller;

  StickerSocketDataSource({
    required this.socketCaller,
  });

  Future<StoreStickerPackListResponse?> getStickerMainScreen(StoreStickerPackListRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.getStickerMainScreen.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3((data) => StoreStickerPackListResponse.fromMap(data));
  }

  Future<StoreStickerPackPaginationResponse?> getStickerSection(StoreStickerPackListRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.getStickerSection.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3((data) => StoreStickerPackPaginationResponse.fromMap(data));
  }

  Future<List<StoreStickerPackEntity>> getStickerFavorite() async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.getFavoriteStickerPack.socket,
      {},
    );

    return socketResp.listToResponseV3((e) => StoreStickerPackEntity.fromMap(e))?.toList() ?? [];
  }

  Future<SearchStickerByEmojiResponse> searchStickerByEmoji(SearchStickerByEmojiRequest request) async {
    final socketResp = await socketCaller.emitCall(
      StickerBackendPath.searchStickerByEmoji.socket,
      request.toMap(),
    );

    return SearchStickerByEmojiResponse.fromList(socketResp.data);
  }

  Future<StoreStickerPackEntity?> getStickerDetail({
    required String stickerPackId,
  }) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.getStickerDetailV3.socket,
      {
        'stickerId': stickerPackId,
      },
    );

    return socketResp.mapToResponseV3(
      (data) => StoreStickerPackEntity.fromMap(data),
    );
  }

  Future<void> acquireStickerPack({required String stickerPackId}) async {
    await socketCaller.emitCallV3(
      StickerBackendPath.acceptStickerPack.socket,
      {
        'stickerId': stickerPackId,
      },
    );
  }

  Future<void> toggleFavoriteSticker({required String stickerPackId}) async {
    await socketCaller.emitCallV3(
      StickerBackendPath.favoriteStickerV3.socket,
      {'stickerId': stickerPackId},
    );
  }

  Future<BuyStickerResponse?> buySticker({
    required BuyStickerRequest request,
  }) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.buyStickerV3.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3(
      (data) => BuyStickerResponse.fromMap(data),
    );
  }

  Future<bool> checkOwnerSticker({required CheckStickerOwnerRequest request}) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.checkOwnerStickerV3.socket,
      request.toMap(),
    );

    if (socketResp.data == null) {
      _log.e('CheckOwnerSticker response is null');
      return false;
    }

    return socketResp.data['data'] ?? false;
  }

  Future<BuyStickerResponse?> sendGiftSticker({required SendGiftRequest request}) async {
    final response = await socketCaller.emitCallV3(
      StickerBackendPath.sendGiftStickerV3.socket,
      request.toMap(),
    );

    return response.mapToResponseV3(
      (data) => BuyStickerResponse.fromMap(data),
    );
  }

  Future<CursorPayload<StickerHistoryEntity>?> getHistorySticker({required FetchStickerHistoryRequest request}) async {
    final socketResp = await socketCaller.emitCallV3(
      StickerBackendPath.getHistorySticker.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse(
      (data) {
        return CursorPayload<StickerHistoryEntity>.fromMapV3(data, listMapper: (data) {
          List<StickerHistoryEntity> dataList = [];
          for (Map<String, dynamic> item in data) {
            dataList.add(StickerHistoryEntity.fromMap(item));
          }
          return dataList;
        });
      },
    );
  }

  Future<CursorPayload<GetReceivedStickerGiftHistoryResponse>?> getReceivedStickerGiftHistory(
      {required GetReceivedStickerGiftHistoryRequest request}) async {
    final response = await socketCaller.emitCallV3(
      StickerBackendPath.getReceivedStickerHistory.socket,
      request.toJson(),
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
    final response = await socketCaller.emitCallV3(
      StickerBackendPath.getSentStickerHistory.socket,
      request.toJson(),
    );

    return CursorPayload.fromMapV3(
      response.data,
      listMapper: (e) {
        return GetSentStickerGiftHistoryResponse.fromJson(List<Map<String, dynamic>>.from(e)).toList();
      },
    );
  }

  Future<void> reorderStickerPacksToTheTop({required ReorderStickerPacksToTheTopRequest request}) async {
    await socketCaller.emitCallV3(
      StickerBackendPath.reorderStickerPacksToTheTop.socket,
      request.toMap(),
    );
  }

  Future<void> reorderAllStickerPack({required ReorderAllStickerPackRequest request}) async {
    await socketCaller.emitCallV3(
      StickerBackendPath.reorderAllStickerPack.socket,
      request.toMap(),
    );
  }

  Future<List<MyStickerPackEntity>> getAllMySticker() async {
    final socketResp = await socketCaller.emitCallV3(StickerBackendPath.getAllMySticker.socket, {});

    return socketResp.listToResponseV3((e) => MyStickerPackEntity.fromMap(e))?.toList() ?? [];
  }

  Future<CursorPayload<StoreStickerPackEntity>?> searchSticker({required SearchStickerRequest request}) async {
    final socketResp = await socketCaller.emitCallV3(StickerBackendPath.searchStickers.socket, request.toMap());
    return socketResp.mapToResponse(
      (data) {
        return CursorPayload<StoreStickerPackEntity>.fromMapV3(data, listMapper: (data) {
          List<StoreStickerPackEntity> dataList = [];
          for (Map<String, dynamic> item in data) {
            dataList.add(StoreStickerPackEntity.fromMap(item));
          }
          return dataList;
        });
      },
    );
  }
}
