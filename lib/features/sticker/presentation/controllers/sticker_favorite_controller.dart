import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/events/favorite_sticker_event.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/routes/app_pages.dart';

class StickerFavoriteIds {
  StickerFavoriteIds._();

  static const String stickerFavoriteListId = 'sticker_favorite_list';
  static const String stickerFavoriteItemId = 'sticker_favorite_item_:id';
}

class StickerFavoriteController extends GetxController {
  bool initializing = true;
  bool _isFetchingFavorites = false;
  List<StoreStickerPackEntity> favoriteList = [];

  StreamSubscription? favoriteStickerEventSubscription;

  @override
  void onInit() async {
    favoriteStickerEventSubscription = eventBus.on<FavoriteStickerEvent>().listen((event) {
      if (event.isFavorite) {
        fetchFavoriteStickers();
      } else {
        favoriteList.removeWhere((pack) => pack.id == event.packId);
        update([StickerFavoriteIds.stickerFavoriteListId]);
      }
    });
    await fetchFavoriteStickers();
    initializing = false;
    super.onInit();
  }

  @override
  void onClose() {
    favoriteStickerEventSubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchFavoriteStickers() async {
    if (_isFetchingFavorites) return;

    _isFetchingFavorites = true;

    try {
      favoriteList = await GetIt.I<StoreStickerRemoteRepository>().getStickerFavorite();
      update([StickerFavoriteIds.stickerFavoriteListId]);
    } catch (e, stackTrace) {
      useLogger().e('fetch favorite sticker pack error', e, stackTrace);
    } finally {
      _isFetchingFavorites = false;
    }
  }

  void handleStickerPackPressed(StoreStickerPackEntity pack) {
    Get.toNamed(Routes.stickerDetail.replaceAll(':stickerPackId', pack.id));
  }

  void handlePressFavorite(int index) async {
    try {
      String packId = favoriteList[index].id;
      await GetIt.I<StoreStickerRemoteRepository>().toggleFavoriteSticker(stickerPackId: packId);
      favoriteList[index] = favoriteList[index].copyWith(isFavorite: !favoriteList[index].isFavorite);
      update([StickerFavoriteIds.stickerFavoriteItemId.replaceAll(':id', packId)]);
    } catch (e, stackTrace) {
      useLogger().e('handlePressFavorite error', e, stackTrace);
    }
  }
}
