import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AddRecentlySearchStickerParams {
  final StoreStickerPackEntity stickerPack;

  AddRecentlySearchStickerParams({
    required this.stickerPack,
  });
}

class AddRecentlySearchStickerUseCase extends SimpleUseCase<void, AddRecentlySearchStickerParams> {
  final StickerSearchLocalRepository stickerSearchLocalRepository;

  AddRecentlySearchStickerUseCase({
    required this.stickerSearchLocalRepository,
  });

  @override
  Future<void> call(AddRecentlySearchStickerParams params) async {
    final pack = params.stickerPack;
    final recentlySearches = await stickerSearchLocalRepository.getAllRecentlySearch();
    if (recentlySearches.contains(pack)) {
      // If the sticker pack is already in the recently searched list, remove it first
      await stickerSearchLocalRepository.deleteRecentlySearch(pack.id);
      recentlySearches.remove(pack);
    }

    if (recentlySearches.length >= UChatConstant.maxRecentlySearchedStickers) {
      // If the list exceeds the maximum count, remove the oldest one
      final oldestPack = recentlySearches.last;
      await stickerSearchLocalRepository.deleteRecentlySearch(oldestPack.id);
      recentlySearches.removeLast();
    }

    await stickerSearchLocalRepository.addRecentlySearch(params.stickerPack);
  }
}
