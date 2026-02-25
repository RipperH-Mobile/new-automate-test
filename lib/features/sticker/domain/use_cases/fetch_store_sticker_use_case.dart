import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_list_payload.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

typedef MapStickerCategoryList = Map<StickerStoreTabCategory, List<StoreStickerPackEntity>>;

@immutable
class FetchStoreStickerParams {
  final int page;
  final int pageSize;

  const FetchStoreStickerParams({
    required this.page,
    this.pageSize = 20,
  });

  StoreStickerPackListRequest toRequest() {
    return StoreStickerPackListRequest(
      page: page,
      pageSize: pageSize,
      includeItems: false,
      isPublish: true,
    );
  }
}

class FetchStoreStickerUseCase extends SimpleUseCase<MapStickerCategoryList, FetchStoreStickerParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  FetchStoreStickerUseCase({
    required this.storeStickerRemoteRepository,
  });

  @override
  Future<MapStickerCategoryList> call(FetchStoreStickerParams params) async {
    final request = params.toRequest();
    final stickerPacks = await storeStickerRemoteRepository.fetchStoreStickers(request);
    final Map<StickerStoreTabCategory, List<StoreStickerPackEntity>> categorizedStickers = {
      StickerStoreTabCategory.home: stickerPacks?.allPacks.packList ?? [],
      StickerStoreTabCategory.popular: stickerPacks?.popularPacks.packList ?? [],
      StickerStoreTabCategory.recommended: stickerPacks?.recommendPacks.packList ?? [],
      StickerStoreTabCategory.free: stickerPacks?.freePacks.packList ?? [],
    };

    return categorizedStickers;
  }
}
