import 'package:uchat/features/sticker/data/models/payloads/store_sticker_pack_list_payload.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_store_tab_category.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchStoreStickerByTypeParams {
  final int page;
  final int pageSize;
  final bool includeItems;
  final bool isPublish;
  final StickerStoreTabCategory type;

  const FetchStoreStickerByTypeParams({
    required this.type,
    required this.page,
    this.pageSize = 20,
    this.includeItems = false,
    this.isPublish = true,
  });

  StoreStickerPackListRequest toRequest() {
    return StoreStickerPackListRequest(
      page: page,
      pageSize: pageSize,
      includeItems: includeItems,
      isPublish: isPublish,
      type: type,
    );
  }
}

class FetchStoreStickerByTypeUseCase
    extends SimpleUseCase<List<StoreStickerPackEntity>, FetchStoreStickerByTypeParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  FetchStoreStickerByTypeUseCase({
    required this.storeStickerRemoteRepository,
  });

  @override
  Future<List<StoreStickerPackEntity>> call(FetchStoreStickerByTypeParams params) async {
    final request = params.toRequest();
    final stickerPacks = await storeStickerRemoteRepository.fetchStickersByType(request);
    return stickerPacks?.packList ?? [];
  }
}
