import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_group.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_sort.dart';

@immutable
class SearchStickerRequest {
  final String keyword;
  final bool? includeItems;
  final bool? isPublish;
  final bool? isDefault;
  final bool? isFree;
  final bool? isRecommend;
  final bool? isGetCoverImageUrl;
  final StickerSearchSort sortBy;
  final int limit;
  final String? nextCursor;
  final StickerSearchGroup searchGroup;

  const SearchStickerRequest({
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

  factory SearchStickerRequest.nameAndCreator({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStickerRequest(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.nameAndCreator,
    );
  }

  factory SearchStickerRequest.nameOnly({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStickerRequest(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.nameOnly,
    );
  }

  factory SearchStickerRequest.creatorOnly({
    required String keyword,
    bool includeItems = false,
    int limit = 20,
    String? nextCursor,
    StickerSearchSort sortBy = StickerSearchSort.createdAtDesc,
  }) {
    return SearchStickerRequest(
      keyword: keyword,
      includeItems: includeItems,
      sortBy: sortBy,
      limit: limit,
      nextCursor: nextCursor,
      searchGroup: StickerSearchGroup.creatorOnly,
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'keyword': keyword.trim(),
      'isGetCoverImageUrl': isGetCoverImageUrl,
      'sortBy': sortBy.value,
      'limit': limit,
      'searchGroup': searchGroup.value,
    };

    if (includeItems != null) {
      data['includeItems'] = includeItems;
    }

    if (isPublish != null) {
      data['isPublish'] = isPublish;
    }

    if (isDefault != null) {
      data['isDefault'] = isDefault;
    }

    if (isFree != null) {
      data['isFree'] = isFree;
    }

    if (isRecommend != null) {
      data['isRecommend'] = isRecommend;
    }

    if (nextCursor != null) {
      data['nextCursor'] = nextCursor;
    }

    return data;
  }
}

@immutable
class SearchStickerResponse {
  final List<StoreStickerPackEntity> stickerPacks;
  final bool hasMore;
  final int totalFound;
  final String? nextCursor;

  const SearchStickerResponse({
    required this.stickerPacks,
    required this.hasMore,
    required this.totalFound,
    this.nextCursor,
  });

  factory SearchStickerResponse.fromMap(Map<String, dynamic> map) {
    List<StoreStickerPackEntity> stickerPacks = [];
    for (Map<String, dynamic> pack in map['stickerPacks'] ?? []) {
      final StoreStickerPackEntity stickerPack = StoreStickerPackEntity.fromMap(pack);
      stickerPacks.add(stickerPack);
    }

    return SearchStickerResponse(
      stickerPacks: stickerPacks,
      hasMore: map['hasMore'] ?? false,
      totalFound: map['totalFound'] ?? 0,
      nextCursor: map['nextCursor'] as String?,
    );
  }
}
