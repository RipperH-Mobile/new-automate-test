import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_received_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_sent_entity.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_received_sticker_gift_history_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sent_sticker_gift_history_use_case.dart';
import 'package:uchat/routes/app_pages.dart';

class StickerSettingGiftIds {
  StickerSettingGiftIds._();

  static const String mainContentBox = 'mainContentBox';
  static const String receivedHistoryList = 'receivedHistoryList';
  static const String sentHistoryList = 'sentHistoryList';
}

final _log = useLogger();

class StickerSettingGiftController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController historyTypeTabController;
  final receivedTabScrollController = ScrollController();
  final sentTabScrollController = ScrollController();

  bool isInitializing = true;
  List<StickerGiftReceivedEntity> receivedHistoryList = [];
  List<StickerGiftSentEntity> sentHistoryList = [];
  bool receivedTabHasMore = false;
  bool receivedTabIsLoadingMore = false;
  bool sentTabHasMore = false;
  bool sentTabIsLoadingMore = false;

  @override
  void onInit() async {
    historyTypeTabController = TabController(length: 2, vsync: this);
    receivedTabScrollController.addListener(onReceivedTabScroll);
    sentTabScrollController.addListener(onSentTabScroll);

    await initHistoryData();

    super.onInit();
  }

  @override
  void onClose() {
    historyTypeTabController.dispose();
    receivedTabScrollController.removeListener(onReceivedTabScroll);
    sentTabScrollController.removeListener(onSentTabScroll);
    receivedTabScrollController.dispose();
    sentTabScrollController.dispose();

    super.onClose();
  }

  Future<void> initHistoryData() async {
    try {
      final receivedHistory = await GetIt.I<FetchReceivedStickerGiftHistoryUseCase>().call(
        FetchReceivedStickerGiftHistoryParams(),
      );
      receivedHistoryList = receivedHistory?.data?.toList() ?? [];
      receivedTabHasMore = receivedHistory?.hasMore ?? false;
    } catch (e, stackTrace) {
      _log.e('init received sticker gift history error', e, stackTrace);
    }

    try {
      final sentHistory = await GetIt.I<FetchSentStickerGiftHistoryUseCase>().call(
        FetchSentStickerGiftHistoryParams(),
      );
      sentHistoryList = sentHistory?.data?.toList() ?? [];
      sentTabHasMore = sentHistory?.hasMore ?? false;
    } catch (e, stackTrace) {
      _log.e('init sent sticker gift history error', e, stackTrace);
    }

    isInitializing = false;

    update([StickerSettingGiftIds.receivedHistoryList, StickerSettingGiftIds.sentHistoryList]);
  }

  Future<void> fetchMoreReceivedHistory() async {
    if (receivedTabIsLoadingMore || !receivedTabHasMore) return;
    receivedTabIsLoadingMore = true;

    final lastItem = receivedHistoryList.lastOrNull;
    final nextCursor = lastItem?.receivedAt;

    if (nextCursor == null) {
      receivedTabIsLoadingMore = false;
      update([StickerSettingGiftIds.receivedHistoryList]);
      return;
    }

    try {
      final receivedHistoryResponse = await GetIt.I<FetchReceivedStickerGiftHistoryUseCase>().call(
        FetchReceivedStickerGiftHistoryParams(nextCursor: nextCursor),
      );

      final dataList = receivedHistoryResponse?.data;
      if (dataList == null) return;
      receivedHistoryList.addAll(dataList);
      receivedTabHasMore = receivedHistoryResponse?.hasMore ?? false;
    } catch (e, stackTrace) {
      _log.e('fetchMoreReceivedHistory error', e, stackTrace);
    } finally {
      receivedTabIsLoadingMore = false;
      update([StickerSettingGiftIds.receivedHistoryList]);
    }
  }

  Future<void> fetchMoreSentHistory() async {
    if (sentTabIsLoadingMore || !sentTabHasMore) return;
    sentTabIsLoadingMore = true;

    final lastItem = sentHistoryList.lastOrNull;
    final nextCursor = lastItem?.receivedAt;

    if (nextCursor == null) {
      sentTabIsLoadingMore = false;
      update([StickerSettingGiftIds.sentHistoryList]);
      return;
    }

    try {
      final sentHistoryResponse = await GetIt.I<FetchSentStickerGiftHistoryUseCase>().call(
        FetchSentStickerGiftHistoryParams(nextCursor: nextCursor),
      );

      final dataList = sentHistoryResponse?.data;
      if (dataList == null) return;
      sentHistoryList.addAll(dataList);
      sentTabHasMore = sentHistoryResponse?.hasMore ?? false;
    } catch (e, stackTrace) {
      _log.e('fetchMoreSentHistory error', e, stackTrace);
    } finally {
      sentTabIsLoadingMore = false;
      update([StickerSettingGiftIds.sentHistoryList]);
    }
  }

  Future<void> onReceivedTabScroll() async {
    final currentPixel = receivedTabScrollController.position.pixels;
    final maxScrollPixel = receivedTabScrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    if (shouldLoadMore && receivedTabHasMore && !receivedTabIsLoadingMore) {
      EasyThrottle.throttle(
        'fetch-more-received-stickers-gift-history',
        const Duration(milliseconds: 500),
        () async {
          await fetchMoreReceivedHistory();
        },
      );
    }
  }

  Future<void> onSentTabScroll() async {
    final currentPixel = sentTabScrollController.position.pixels;
    final maxScrollPixel = sentTabScrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    if (shouldLoadMore && sentTabHasMore && !sentTabIsLoadingMore) {
      EasyThrottle.throttle(
        'fetch-more-sent-stickers-gift-history',
        const Duration(milliseconds: 500),
        () async {
          await fetchMoreSentHistory();
        },
      );
    }
  }

  void handleStickerPackPressed(String id) {
    Get.toNamed(Routes.stickerDetail.replaceAll(':stickerPackId', id));
  }
}
