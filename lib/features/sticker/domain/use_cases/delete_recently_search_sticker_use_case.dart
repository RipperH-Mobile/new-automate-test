import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteRecentlySearchStickerParams {
  final String stickerPackId;

  DeleteRecentlySearchStickerParams({
    required this.stickerPackId,
  });
}

class DeleteRecentlySearchStickerUseCase extends SimpleUseCase<void, DeleteRecentlySearchStickerParams> {
  final StickerSearchLocalRepository stickerSearchLocalRepository;

  DeleteRecentlySearchStickerUseCase({
    required this.stickerSearchLocalRepository,
  });

  @override
  Future<void> call(DeleteRecentlySearchStickerParams params) async {
    return await stickerSearchLocalRepository.deleteRecentlySearch(params.stickerPackId);
  }
}
