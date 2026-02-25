import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ClearRecentlySearchStickerUseCase extends SimpleUseCase<void, NoParams> {
  final StickerSearchLocalRepository stickerSearchLocalRepository;

  ClearRecentlySearchStickerUseCase({
    required this.stickerSearchLocalRepository,
  });

  @override
  Future<void> call(NoParams params) async {
    return await stickerSearchLocalRepository.clearRecentlySearches();
  }
}
