import 'package:uchat/features/sticker/data/models/payloads/reorder_all_sticker_pack_payload.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ReorderAllStickerPackParams {
  final List<String> orderedStickerIds;

  const ReorderAllStickerPackParams({
    required this.orderedStickerIds,
  });

  ReorderAllStickerPackRequest toRequest() {
    return ReorderAllStickerPackRequest(
      orderedStickerIds: orderedStickerIds,
    );
  }
}

class ReorderAllStickerUseCase extends SimpleUseCase<void, ReorderAllStickerPackParams> {
  final MyStickerRemoteRepository myStickerRemoteRepository;

  ReorderAllStickerUseCase({required this.myStickerRemoteRepository});

  @override
  Future<void> call(ReorderAllStickerPackParams params) {
    return myStickerRemoteRepository.reorderAllStickerPack(request: params.toRequest());
  }
}
