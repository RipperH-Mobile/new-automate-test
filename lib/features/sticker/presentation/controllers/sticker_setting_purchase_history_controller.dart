import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_history_entity.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sticker_history_use_case.dart';
import 'package:uchat/routes/app_pages.dart';

final _log = useLogger();

class StickerSettingPurchaseHistoryIds {
  StickerSettingPurchaseHistoryIds._();

  static const String stickerPurchaseHistoryListId = 'sticker_purchase_history_list';
  static const String stickerPurchaseHistoryItemId = 'sticker_purchase_history_item_:id';
}

class StickerSettingPurchaseHistoryController extends GetxController {
  final scrollController = ScrollController();
  bool initializing = true;
  bool hasMore = false;
  bool isLoadingMore = false;
  final purchaseHistoryList = <StickerHistoryEntity>[];

  @override
  void onInit() async {
    super.onInit();

    scrollController.addListener(listenOnScrolling);
    await fetchInitial();
  }

  @override
  onClose() {
    scrollController.removeListener(listenOnScrolling);
    scrollController.dispose();
  }

  Future<void> listenOnScrolling() async {
    final currentPixel = scrollController.position.pixels;
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    if (shouldLoadMore && hasMore && !isLoadingMore) {
      EasyThrottle.throttle(
        'fetch-more-stickers',
        const Duration(milliseconds: 500),
        () async {
          await fetchMoreHistory();
        },
      );
    }
  }

  Future<void> fetchInitial() async {
    try {
      initializing = true;
      update([StickerSettingPurchaseHistoryIds.stickerPurchaseHistoryListId]);

      final historyResponse = await GetIt.I<FetchStickerHistoryUseCase>().call(FetchStickerHistoryParams());
      if (historyResponse != null) {
        purchaseHistoryList.assignAll(historyResponse.items);
        hasMore = historyResponse.hasMore;
      } else {
        hasMore = false;
      }
    } catch (e, stackTrace) {
      _log.e('Error fetching initial sticker purchase history', e, stackTrace);
    } finally {
      initializing = false;
      update([StickerSettingPurchaseHistoryIds.stickerPurchaseHistoryListId]);
    }
  }

  Future<void> fetchMoreHistory() async {
    try {
      if (isLoadingMore || !hasMore) return;
      isLoadingMore = true;

      final lastItem = purchaseHistoryList.lastOrNull;
      final nextCursor = lastItem?.receivedAt;

      if (nextCursor == null) {
        isLoadingMore = false;
        update([StickerSettingPurchaseHistoryIds.stickerPurchaseHistoryListId]);
        return;
      }

      final historyResponse = await GetIt.I<FetchStickerHistoryUseCase>().call(
        FetchStickerHistoryParams(nextCursor: nextCursor),
      );

      if (historyResponse != null) {
        purchaseHistoryList.addAll(historyResponse.items);
        hasMore = historyResponse.hasMore;
      } else {
        hasMore = false;
      }
    } catch (e, stackTrace) {
      _log.e('Error fetching more sticker purchase history', e, stackTrace);
    } finally {
      isLoadingMore = false;
      update([StickerSettingPurchaseHistoryIds.stickerPurchaseHistoryListId]);
    }
  }

  void onTapStickerItem(StickerHistoryEntity pack) {
    Get.toNamed(Routes.stickerDetail.replaceAll(':stickerPackId', pack.id));
  }
}
