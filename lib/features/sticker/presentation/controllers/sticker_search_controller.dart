import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_tab.dart';
import 'package:uchat/features/sticker/domain/use_cases/add_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/clear_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/delete_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_all_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/search_store_sticker_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class StickerSearchIds {
  StickerSearchIds._();

  static const String tabBar = 'sticker_search_tab_bar';
  static const String recentlySearchedStickers = 'sticker_search_recently_searched_stickers';
  static const String allTabView = 'sticker_search_all_tab_view';
  static const String characterTabView = 'sticker_search_character_tab_view';
  static const String creatorTabView = 'sticker_search_creator_tab_view';
}

class StickerSearchController extends GetxController with GetSingleTickerProviderStateMixin {
  final searchTextController = TextEditingController();
  final searchFocusNode = FocusNode();
  String keyword = '';
  bool isLoadingNewSearch = false;

  late final TabController tabController;
  final allScrollController = ScrollController();
  final characterScrollController = ScrollController();
  final creatorScrollController = ScrollController();

  List<StoreStickerPackEntity> recentlySearchedStickers = [];
  Map<StickerSearchTab, Set<StoreStickerPackEntity>> stickerSearchMap = {
    StickerSearchTab.all: {},
    StickerSearchTab.character: {},
    StickerSearchTab.creator: {},
  };

  bool hasMoreAll = true;
  bool hasMoreCharacter = true;
  bool hasMoreCreator = true;

  List<StoreStickerPackEntity> get allStickers => stickerSearchMap[StickerSearchTab.all]?.toList() ?? [];

  List<StoreStickerPackEntity> get characterStickers => stickerSearchMap[StickerSearchTab.character]?.toList() ?? [];

  List<StoreStickerPackEntity> get creatorStickers => stickerSearchMap[StickerSearchTab.creator]?.toList() ?? [];

  bool hasMore(StickerSearchTab tab) {
    return switch (tab) {
      StickerSearchTab.all => hasMoreAll,
      StickerSearchTab.character => hasMoreCharacter,
      StickerSearchTab.creator => hasMoreCreator,
    };
  }

  @override
  onInit() {
    super.onInit();
    // Initialize the TabController with the number of tabs
    tabController = TabController(length: StickerSearchTab.values.length, vsync: this);
    allScrollController.addListener(() => listenOnScrolling(StickerSearchTab.all));
    characterScrollController.addListener(() => listenOnScrolling(StickerSearchTab.character));
    creatorScrollController.addListener(() => listenOnScrolling(StickerSearchTab.creator));

    initRecentlySearchedStickers();
  }

  @override
  onClose() {
    searchTextController.dispose();
    allScrollController.removeListener(() => listenOnScrolling(StickerSearchTab.all));
    allScrollController.dispose();
    characterScrollController.removeListener(() => listenOnScrolling(StickerSearchTab.character));
    characterScrollController.dispose();
    creatorScrollController.removeListener(() => listenOnScrolling(StickerSearchTab.creator));
    creatorScrollController.dispose();
    tabController.dispose();
    searchFocusNode.dispose();
    EasyDebounce.cancel('sticker_search_debounce');
    EasyThrottle.cancel('get-more-search-sticker-category-all');
    EasyThrottle.cancel('get-more-search-sticker-category-character');
    EasyThrottle.cancel('get-more-search-sticker-category-creator');
    super.onClose();
  }

  Future<void> initRecentlySearchedStickers() async {
    await getRecentlySearchedStickers();
    update([StickerSearchIds.recentlySearchedStickers]);
  }

  Future<void> listenOnScrolling(StickerSearchTab tab) async {
    final scrollController = switch (tab) {
      StickerSearchTab.all => allScrollController,
      StickerSearchTab.character => characterScrollController,
      StickerSearchTab.creator => creatorScrollController,
    };

    final currentPixel = scrollController.position.pixels;
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;
    if (shouldLoadMore) {
      EasyThrottle.throttle(
        'get-more-search-sticker-category-${tab.value}',
        const Duration(milliseconds: 500),
        () async {
          await searchStickersCategory(keyword: keyword, category: tab);

          update([
            if (tab.isAll) StickerSearchIds.allTabView,
            if (tab.isCharacter) StickerSearchIds.characterTabView,
            if (tab.isCreator) StickerSearchIds.creatorTabView
          ]);
        },
      );
    }
  }

  void onTapSearchTextField() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.searchingSticker);
  }

  void onGoToStickerDetail({required StoreStickerPackEntity stickerPack}) {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickStickerSearchResult,
      eventProperties: EventProperty.clickStickerSearchResult(
        stickerPack.name,
        stickerPack.publisher,
      ),
    );
    Get.toNamed(Routes.stickerDetail.replaceAll(':stickerPackId', stickerPack.id));
    addRecentlySearchedSticker(stickerPack);
  }

  void onSearchTextChanged(String value) {
    final newKeyword = value.trim();

    hasMoreAll = true;
    hasMoreCharacter = true;
    hasMoreCreator = true;

    if (newKeyword.isEmpty) {
      keyword = '';
      stickerSearchMap = {
        StickerSearchTab.all: {},
        StickerSearchTab.character: {},
        StickerSearchTab.creator: {},
      };
      isLoadingNewSearch = false;
      EasyDebounce.cancel('sticker_search_debounce');
    } else {
      if (keyword != newKeyword) {
        keyword = newKeyword;
        isLoadingNewSearch = true;
        EasyDebounce.debounce('sticker_search_debounce', const Duration(milliseconds: 500), searchStickers);
      }
    }
    update([
      StickerSearchIds.tabBar,
      StickerSearchIds.recentlySearchedStickers,
      StickerSearchIds.allTabView,
      StickerSearchIds.characterTabView,
      StickerSearchIds.creatorTabView
    ]);
  }

  Future<void> searchStickers() async {
    try {
      stickerSearchMap = {
        StickerSearchTab.all: {},
        StickerSearchTab.character: {},
        StickerSearchTab.creator: {},
      };
      update([
        StickerSearchIds.tabBar,
        StickerSearchIds.allTabView,
        StickerSearchIds.characterTabView,
        StickerSearchIds.creatorTabView
      ]);

      await Future.wait([
        searchStickersCategory(keyword: keyword, category: StickerSearchTab.all),
        searchStickersCategory(keyword: keyword, category: StickerSearchTab.character),
        searchStickersCategory(keyword: keyword, category: StickerSearchTab.creator),
      ]);
    } catch (e, stackTrace) {
      _log.w('Error in onSearchTextChanged', e, stackTrace);
    } finally {
      isLoadingNewSearch = false;
      update([
        StickerSearchIds.tabBar,
        StickerSearchIds.allTabView,
        StickerSearchIds.characterTabView,
        StickerSearchIds.creatorTabView
      ]);
    }
  }

  Future<void> searchStickersCategory({required String keyword, required StickerSearchTab category}) async {
    if (hasMore(category) == false) {
      return;
    }

    final params = switch (category) {
      StickerSearchTab.all => SearchStoreStickerParams.nameAndCreator(
          keyword: keyword,
          nextCursor: allStickers.isNotEmpty ? allStickers.last.id : null,
          limit: 10,
        ),
      StickerSearchTab.character => SearchStoreStickerParams.nameOnly(
          keyword: keyword,
          nextCursor: characterStickers.isNotEmpty ? characterStickers.last.id : null,
          limit: 10,
        ),
      StickerSearchTab.creator => SearchStoreStickerParams.creatorOnly(
          keyword: keyword,
          nextCursor: creatorStickers.isNotEmpty ? creatorStickers.last.id : null,
          limit: 10,
        ),
    };

    final searchResult = await GetIt.I<SearchStoreStickerUseCase>().call(params);

    if (searchResult == null) {
      return;
    }

    if (category == StickerSearchTab.all) {
      stickerSearchMap[StickerSearchTab.all]?.addAll(searchResult.stickerPacks);
      hasMoreAll = searchResult.hasMore;
    } else if (category == StickerSearchTab.character) {
      stickerSearchMap[StickerSearchTab.character]?.addAll(searchResult.stickerPacks);
      hasMoreCharacter = searchResult.hasMore;
    } else if (category == StickerSearchTab.creator) {
      stickerSearchMap[StickerSearchTab.creator]?.addAll(searchResult.stickerPacks);
      hasMoreCreator = searchResult.hasMore;
    }
  }

  Future<void> getRecentlySearchedStickers() async {
    final result = await GetIt.I<GetAllRecentlySearchStickerUseCase>().call(NoParams());

    if (result.isNotEmpty) {
      recentlySearchedStickers.addAll(result);
      update([StickerSearchIds.recentlySearchedStickers]);
    }
  }

  Future<void> addRecentlySearchedSticker(StoreStickerPackEntity stickerPack) async {
    recentlySearchedStickers.remove(stickerPack);
    recentlySearchedStickers.insert(0, stickerPack);
    await GetIt.I<AddRecentlySearchStickerUseCase>().call(
      AddRecentlySearchStickerParams(stickerPack: stickerPack),
    );

    if (recentlySearchedStickers.length >= UChatConstant.maxRecentlySearchedStickers) {
      recentlySearchedStickers.removeLast();
    }

    update([StickerSearchIds.recentlySearchedStickers]);
  }

  Future<void> deleteRecentlySearchedSticker(StoreStickerPackEntity stickerPack) async {
    recentlySearchedStickers.remove(stickerPack);
    await GetIt.I<DeleteRecentlySearchStickerUseCase>().call(
      DeleteRecentlySearchStickerParams(stickerPackId: stickerPack.id),
    );
    update([StickerSearchIds.recentlySearchedStickers]);
  }

  Future<void> clearRecentlySearchedStickers() async {
    recentlySearchedStickers.clear();
    await GetIt.I<ClearRecentlySearchStickerUseCase>().call(NoParams());
    update([StickerSearchIds.recentlySearchedStickers]);
  }
}
