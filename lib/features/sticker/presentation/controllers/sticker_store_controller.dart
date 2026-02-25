import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/in_app_purchase_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_store_sticker_by_type_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_store_sticker_use_case.dart';
import 'package:uchat/routes/app_pages.dart';

final _log = useLogger();

typedef MapStickerCategorySet = Map<StickerStoreTabCategory, Set<StoreStickerPackEntity>>;

class StickerStoreIds {
  StickerStoreIds._();

  static const String tabBar = 'sticker_store_tab_bar';
  static const String homeTabView = 'sticker_store_home_tab_view';
  static const String stickerPackPreviewList = 'sticker_store_pack_preview_list';
  static const String popularStickerList = 'sticker_store_popular_sticker_list';
  static const String recommendedStickerList = 'sticker_store_recommended_sticker_list';
  static const String freeStickerList = 'sticker_store_free_sticker_list';
}

class StickerStoreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController storeTabController;
  int currentTabIndex = 0;

  /// Scroll controller for each category tab
  final popularScrollController = ScrollController();
  final recommendedScrollController = ScrollController();
  final freeScrollController = ScrollController();

  MapStickerCategorySet stickerCategoryMap = {
    StickerStoreTabCategory.home: <StoreStickerPackEntity>{},
    StickerStoreTabCategory.popular: <StoreStickerPackEntity>{},
    StickerStoreTabCategory.recommended: <StoreStickerPackEntity>{},
    StickerStoreTabCategory.free: <StoreStickerPackEntity>{},
  };

  Set<StoreStickerPackEntity> get popularStickers => stickerCategoryMap[StickerStoreTabCategory.popular] ?? {};

  Set<StoreStickerPackEntity> get recommendedStickers => stickerCategoryMap[StickerStoreTabCategory.recommended] ?? {};

  Set<StoreStickerPackEntity> get freeStickers => stickerCategoryMap[StickerStoreTabCategory.free] ?? {};

  bool isLoadingStore = false;

  bool hasMorePopularStickers = true;
  bool hasMoreRecommendedStickers = true;
  bool hasMoreFreeStickers = true;

  int popularPage = 1;
  int recommendedPage = 1;
  int freePage = 1;

  @override
  onInit() {
    super.onInit();
    storeTabController = TabController(length: StickerStoreTabCategory.values.length, vsync: this);
    popularScrollController.addListener(() => listenOnScrolling(StickerStoreTabCategory.popular));
    recommendedScrollController.addListener(() => listenOnScrolling(StickerStoreTabCategory.recommended));
    freeScrollController.addListener(() => listenOnScrolling(StickerStoreTabCategory.free));

    getAllStockerStore();
    InAppPurchaseController.instance.verifyAllPendingPurchase();
  }

  @override
  void onClose() {
    storeTabController.dispose();
    popularScrollController.dispose();
    recommendedScrollController.dispose();
    freeScrollController.dispose();
    super.onClose();
  }

  void onGoToStickerSetting() {
    Get.toNamed(Routes.stickerSetting);
  }

  void onGoToSearchScreen() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchBarStickerStore);
    Get.toNamed(Routes.stickerSearch);
  }

  void onTabChanged(int index) {
    final category = StickerStoreTabCategory.values[index];
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.stickerTabClicked,
      eventProperties: EventProperty.stickerTabClicked(category.value),
    );
    currentTabIndex = index;
    update([StickerStoreIds.tabBar]);
  }

  Future<void> listenOnScrolling(StickerStoreTabCategory category) async {
    final scrollController = switch (category) {
      StickerStoreTabCategory.popular => popularScrollController,
      StickerStoreTabCategory.recommended => recommendedScrollController,
      StickerStoreTabCategory.free => freeScrollController,
      _ => throw ArgumentError('Invalid category: $category'),
    };

    final currentPixel = scrollController.position.pixels;
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;
    if (shouldLoadMore) {
      EasyThrottle.throttle(
        'get-more-sticker-category-${category.value}',
        const Duration(milliseconds: 500),
        () async {
          await getMoreStickersByType(category);
        },
      );
    }
  }

  void onSeeAllTab(StickerStoreTabCategory category) {
    switch (category) {
      case StickerStoreTabCategory.home:
        storeTabController.animateTo(0);
        break;
      case StickerStoreTabCategory.popular:
        storeTabController.animateTo(1);
        break;
      case StickerStoreTabCategory.recommended:
        storeTabController.animateTo(2);
        break;
      case StickerStoreTabCategory.free:
        storeTabController.animateTo(3);
        break;
    }
  }

  Future<void> getAllStockerStore() async {
    try {
      isLoadingStore = true;
      update([StickerStoreIds.homeTabView, StickerStoreIds.stickerPackPreviewList]);

      final mapStickerList = await GetIt.I<FetchStoreStickerUseCase>().call(const FetchStoreStickerParams(page: 1));
      mapStickerList.forEach((category, stickers) {
        stickerCategoryMap[category]?.addAll(stickers);
      });
    } catch (e, stackTrace) {
      _log.e('Error fetching all sticker store data', e, stackTrace);
    } finally {
      isLoadingStore = false;
      update([StickerStoreIds.homeTabView, StickerStoreIds.stickerPackPreviewList]);
    }
  }

  Future<void> getMoreStickersByType(StickerStoreTabCategory category) async {
    try {
      final page = switch (category) {
        StickerStoreTabCategory.popular => popularPage += 1,
        StickerStoreTabCategory.recommended => recommendedPage += 1,
        StickerStoreTabCategory.free => freePage += 1,
        _ => throw ArgumentError('Invalid category: $category'),
      };

      if ((category == StickerStoreTabCategory.popular && !hasMorePopularStickers) ||
          (category == StickerStoreTabCategory.recommended && !hasMoreRecommendedStickers) ||
          (category == StickerStoreTabCategory.free && !hasMoreFreeStickers)) {
        return;
      }

      final stickers = await GetIt.I<FetchStoreStickerByTypeUseCase>().call(
        FetchStoreStickerByTypeParams(type: category, page: page),
      );

      if (stickers.isEmpty) {
        switch (category) {
          case StickerStoreTabCategory.popular:
            hasMorePopularStickers = false;
            break;
          case StickerStoreTabCategory.recommended:
            hasMoreRecommendedStickers = false;
            break;
          case StickerStoreTabCategory.free:
            hasMoreFreeStickers = false;
            break;
          default:
            throw ArgumentError('Invalid category: $category');
        }
        return;
      }

      switch (category) {
        case StickerStoreTabCategory.popular:
          stickerCategoryMap[StickerStoreTabCategory.popular]?.addAll(stickers);
          update([StickerStoreIds.popularStickerList]);
          break;
        case StickerStoreTabCategory.recommended:
          stickerCategoryMap[StickerStoreTabCategory.recommended]?.addAll(stickers);
          update([StickerStoreIds.recommendedStickerList]);
          break;
        case StickerStoreTabCategory.free:
          stickerCategoryMap[StickerStoreTabCategory.free]?.addAll(stickers);
          update([StickerStoreIds.freeStickerList]);
          break;
        default:
          throw ArgumentError('Invalid category: $category');
      }
    } catch (e, stackTrace) {
      _log.e('Error fetching more stickers for category: $category', e, stackTrace);
    }
  }

  Future<void> onGoToStickerDetail({required String stickerPackId}) async {
    Get.toNamed(Routes.stickerDetail.replaceAll(':stickerPackId', stickerPackId));
  }
}
