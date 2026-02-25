import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_http_data_source.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_socket_data_source.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sticker_history_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_all_sticker_pack_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';

class MyStickerRemoteRepositoryImpl implements MyStickerRemoteRepository {
  final _log = useLogger();

  final StickerHttpDataSource httpDataSource;
  final StickerSocketDataSource socketDataSource;

  MyStickerRemoteRepositoryImpl({
    required this.httpDataSource,
    required this.socketDataSource,
  });

  @override
  Future<CursorPayload<StickerHistoryEntity>?> getHistorySticker({required FetchStickerHistoryRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getHistorySticker(request: request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e, stackTrace) {
        _log.w('getHistorySticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.getHistorySticker(request: request);
  }

  // This function is used for moving some pack to the top of the list.
  // ex: [pack1, pack2, pack3] when sending pack3 id in this function it will become [pack3, pack1, pack2]
  @override
  Future<void> reorderStickerPacksToTheTop({required ReorderStickerPacksToTheTopRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.reorderStickerPacksToTheTop(request: request);
      } catch (e, stackTrace) {
        _log.w('reorderStickerPacksToTheTop with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.reorderStickerPacksToTheTop(request: request);
  }

  // This function is used for reorder all my sticker pack. We must send every pack id that the current user has
  // otherwise server will throw an error. Server will reorder all sticker pack into the same order that we sent.
  @override
  Future<void> reorderAllStickerPack({required ReorderAllStickerPackRequest request}) async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.reorderAllStickerPack(request: request);
      } catch (e, stackTrace) {
        _log.w('reorderAllStickerPack with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.reorderAllStickerPack(request: request);
  }

  @override
  Future<List<MyStickerPackEntity>> getAllMySticker() async {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return await socketDataSource.getAllMySticker();
      } catch (e, stackTrace) {
        _log.w('getAllMySticker with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await httpDataSource.getAllMySticker();
  }
}
