import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_http_data_source.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_socket_data_source.dart';
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
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';

final _log = useLogger();

class StoreStickerRemoteRepositoryImpl implements StoreStickerRemoteRepository {
  final StickerHttpDataSource httpDataSource;
  final StickerSocketDataSource socketDataSource;

  StoreStickerRemoteRepositoryImpl({
    required this.httpDataSource,
    required this.socketDataSource,
  });

  @override
  Future<void> acquireStickerPack({required String stickerPackId}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        await socketDataSource.acquireStickerPack(stickerPackId: stickerPackId);
        return;
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('acquireStickerPack with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpDataSource.acquireStickerPack(stickerPackId: stickerPackId);
  }

  @override
  Future<BuyStickerResponse?> buySticker({required BuyStickerRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.buySticker(request: request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('buySticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.buySticker(request: request);
  }

  @override
  Future<bool> checkOwnerSticker({required CheckStickerOwnerRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.checkOwnerSticker(request: request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('checkOwnerSticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.checkOwnerSticker(request: request);
  }

  @override
  Future<StoreStickerPackListResponse?> fetchStoreStickers(StoreStickerPackListRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getStickerMainScreen(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('fetchStoreStickers with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.getStickerMainScreen(request);
  }

  @override
  Future<CursorPayload<StickerGiftReceivedEntity>?> fetchReceivedStickerGiftHistory(
      {required GetReceivedStickerGiftHistoryRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        final response = await socketDataSource.getReceivedStickerGiftHistory(request: request);
        if (response == null) return null;
        return CursorPayload(
          data: response.data?.map((e) => StickerGiftReceivedEntity.fromResponse(e)),
          hasMore: response.hasMore,
          totalFound: response.totalFound,
          nextCursor: response.nextCursor,
        );
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('fetchReceivedStickerGiftHistory with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await httpDataSource.getReceivedStickerGiftHistory(request: request);
    if (response == null) return null;
    return CursorPayload(
      data: response.data?.map((e) => StickerGiftReceivedEntity.fromResponse(e)),
      hasMore: response.hasMore,
      totalFound: response.totalFound,
      nextCursor: response.nextCursor,
    );
  }

  @override
  Future<CursorPayload<StickerGiftSentEntity>?> fetchSentStickerGiftHistory(
      {required GetSentStickerGiftHistoryRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        final response = await socketDataSource.getSentStickerGiftHistory(request: request);
        if (response == null) return null;
        return CursorPayload(
          data: response.data?.map((e) => StickerGiftSentEntity.fromResponse(e)),
          hasMore: response.hasMore,
          totalFound: response.totalFound,
          nextCursor: response.nextCursor,
        );
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('fetchSentStickerGiftHistory with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await httpDataSource.getSentStickerGiftHistory(request: request);
    if (response == null) return null;
    return CursorPayload(
      data: response.data?.map((e) => StickerGiftSentEntity.fromResponse(e)),
      hasMore: response.hasMore,
      totalFound: response.totalFound,
      nextCursor: response.nextCursor,
    );
  }

  @override
  Future<StoreStickerPackPaginationResponse?> fetchStickersByType(StoreStickerPackListRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getStickerSection(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('fetchStickersByType with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.getStickerSection(request);
  }

  @override
  Future<List<StoreStickerPackEntity>> getStickerFavorite() async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        final result = await socketDataSource.getStickerFavorite();

        return result.map((e) => e.copyWith(isFavorite: true)).toList();
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('getStickerFavorite with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await httpDataSource.getStickerFavorite();

    return result.map((e) => e.copyWith(isFavorite: true)).toList();
  }

  @override
  Future<StoreStickerPackEntity?> getStickerDetail({required String stickerPackId}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getStickerDetail(stickerPackId: stickerPackId);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('getStickerDetail with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.getStickerDetail(stickerPackId: stickerPackId);
  }

  @override
  Future<SearchStickerByEmojiResponse?> searchStickerByEmoji(SearchStickerByEmojiRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.searchStickerByEmoji(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('searchStickerByEmoji with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.searchStickerByEmoji(request);
  }

  @override
  Future<CursorPayload<StoreStickerPackEntity>?> searchSticker(SearchStickerRequest request) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.searchSticker(request: request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('searchSticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.searchSticker(request: request);
  }

  @override
  Future<BuyStickerResponse?> sendGiftSticker({required SendGiftRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.sendGiftSticker(request: request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('sendGiftSticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.sendGiftSticker(request: request);
  }

  @override
  Future<void> toggleFavoriteSticker({required String stickerPackId}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        await socketDataSource.toggleFavoriteSticker(stickerPackId: stickerPackId);
        return;
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('toggleFavoriteSticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpDataSource.toggleFavoriteSticker(stickerPackId: stickerPackId);
  }
}
