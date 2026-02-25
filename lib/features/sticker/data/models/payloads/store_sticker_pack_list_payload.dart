import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_pagination_payload.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';

@immutable
class StoreStickerPackListResponse {
  final StoreStickerPackPaginationResponse allPacks;
  final StoreStickerPackPaginationResponse freePacks;
  final StoreStickerPackPaginationResponse popularPacks;
  final StoreStickerPackPaginationResponse recommendPacks;

  const StoreStickerPackListResponse({
    required this.allPacks,
    required this.freePacks,
    required this.popularPacks,
    required this.recommendPacks,
  });

  factory StoreStickerPackListResponse.fromMap(Map<String, dynamic> map) {
    final allPacks = StoreStickerPackPaginationResponse.fromMap(map['all']);
    final freePacks = StoreStickerPackPaginationResponse.fromMap(map['free']);
    final popularPacks = StoreStickerPackPaginationResponse.fromMap(map['popular']);
    final recommendPacks = StoreStickerPackPaginationResponse.fromMap(map['recommend']);
    return StoreStickerPackListResponse(
      allPacks: allPacks,
      freePacks: freePacks,
      popularPacks: popularPacks,
      recommendPacks: recommendPacks,
    );
  }
}

@immutable
class StoreStickerPackListRequest {
  final String? keyword;
  final int page;
  final int pageSize;
  final bool includeItems;
  final bool isPublish;
  final StickerStoreTabCategory? type;

  const StoreStickerPackListRequest({
    required this.page,
    required this.pageSize,
    required this.includeItems,
    required this.isPublish,
    this.keyword,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      if (keyword != null) 'keyword': keyword,
      'page': page,
      'pageSize': pageSize,
      'includeItems': includeItems,
      'isPublish': isPublish,
      'type': type?.serverKey,
    };
  }
}
