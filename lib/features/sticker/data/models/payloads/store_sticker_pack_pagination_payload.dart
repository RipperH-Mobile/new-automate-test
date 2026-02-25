import 'package:flutter/foundation.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';

final _log = useLogger();

@immutable
class StoreStickerPackPaginationResponse {
  final List<StoreStickerPackEntity> packList;
  final int total;
  final int page;
  final int pageSize;
  final int totalPage;

  const StoreStickerPackPaginationResponse({
    required this.packList,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPage,
  });

  factory StoreStickerPackPaginationResponse.fromMap(Map<String, dynamic> map) {
    List<StoreStickerPackEntity> packs = [];
    for (Map<String, dynamic> pack in map['data']) {
      try {
        packs.add(StoreStickerPackEntity.fromMap(pack));
      } catch (e) {
        _log.w('StoreListResponse.fromMap error : $pack', e);
      }
    }
    return StoreStickerPackPaginationResponse(
      packList: packs,
      total: map['pagination']['total'],
      page: map['pagination']['page'],
      pageSize: map['pagination']['pageSize'],
      totalPage: map['pagination']['totalPages'],
    );
  }
}

@immutable
class StoreStickerPackRequest {
  final String keyword;
  final int page;

  const StoreStickerPackRequest({
    required this.keyword,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'page': page,
    };
  }
}
