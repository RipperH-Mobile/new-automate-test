import 'package:uchat/features/sticker/data/models/payloads/search_sticker_payload.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_group.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_sort.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SearchStoreStickerParams {
  final String keyword;
  final bool? includeItems;
  final bool? isPublish;
  final bool? isDefault;
  final bool? isFree;
  final bool? isRecommend;
  final bool? isGetCoverImageUrl;
  final StickerSearchSort sortBy; // Assuming sortBy is a string for simplicity
  final int limit;
  final String? nextCursor;
  final StickerSearchGroup searchGroup;

  SearchStoreStickerParams({
    required this.keyword,
    this.includeItems,
    this.isPublish,
    this.isDefault,
    this.isFree,
    this.isRecommend,
    this.isGetCoverImageUrl = true,
    this.sortBy = StickerSearchSort.createdAtDesc,
    this.limit = 20,
    this.nextCursor,
    this.searchGroup = StickerSearchGroup.nameAndCreator,
  });

  factory SearchStoreStickerParams.nameAndCreator({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStoreStickerParams(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.nameAndCreator,
    );
  }

  factory SearchStoreStickerParams.nameOnly({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStoreStickerParams(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.nameOnly,
    );
  }

  factory SearchStoreStickerParams.creatorOnly({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStoreStickerParams(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.creatorOnly,
    );
  }

  SearchStickerRequest toRequest() {
    return SearchStickerRequest(
      keyword: keyword,
      includeItems: includeItems,
      isPublish: isPublish,
      isDefault: isDefault,
      isFree: isFree,
      isRecommend: isRecommend,
      isGetCoverImageUrl: isGetCoverImageUrl ?? true,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: searchGroup,
    );
  }
}

class SearchStoreStickerUseCase extends SimpleUseCase<SearchStickerResponse?, SearchStoreStickerParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  SearchStoreStickerUseCase({required this.storeStickerRemoteRepository});

  @override
  Future<SearchStickerResponse?> call(SearchStoreStickerParams params) async {
    final request = params.toRequest();
    final cursorResp = await storeStickerRemoteRepository.searchSticker(request);
    if (cursorResp == null) {
      return null;
    }

    return SearchStickerResponse(
      stickerPacks: cursorResp.data?.toList() ?? [],
      hasMore: cursorResp.hasMore,
      totalFound: cursorResp.totalFound,
      nextCursor: cursorResp.nextCursor,
    );
  }
}
