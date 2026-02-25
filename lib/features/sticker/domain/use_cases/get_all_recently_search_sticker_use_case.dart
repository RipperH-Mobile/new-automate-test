import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllRecentlySearchStickerUseCase extends SimpleUseCase<List<StoreStickerPackEntity>, NoParams> {
  final StickerSearchLocalRepository stickerSearchLocalRepository;

  GetAllRecentlySearchStickerUseCase({
    required this.stickerSearchLocalRepository,
  });

  @override
  Future<List<StoreStickerPackEntity>> call(NoParams params) async {
    return await stickerSearchLocalRepository.getAllRecentlySearch();
  }
}
