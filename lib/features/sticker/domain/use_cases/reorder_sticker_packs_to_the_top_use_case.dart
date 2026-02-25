import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ReorderStickerPacksToTheTopUseCase extends SimpleUseCase<void, ReorderStickerPacksToTheTopRequest> {
  final MyStickerRemoteRepository myStickerRemoteRepository;

  ReorderStickerPacksToTheTopUseCase({required this.myStickerRemoteRepository});

  @override
  Future<void> call(ReorderStickerPacksToTheTopRequest params) {
    return myStickerRemoteRepository.reorderStickerPacksToTheTop(request: params);
  }
}
