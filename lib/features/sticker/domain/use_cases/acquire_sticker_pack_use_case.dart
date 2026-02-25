import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AcquireStickerPackParams {
  final String stickerPackId;

  AcquireStickerPackParams({required this.stickerPackId});
}

class AcquireStickerPackUseCase extends SimpleUseCase<StoreStickerPackEntity?, AcquireStickerPackParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  AcquireStickerPackUseCase({
    required this.storeStickerRemoteRepository,
  });

  @override
  Future<StoreStickerPackEntity?> call(AcquireStickerPackParams params) async {
    await storeStickerRemoteRepository.acquireStickerPack(
      stickerPackId: params.stickerPackId,
    );

    return storeStickerRemoteRepository.getStickerDetail(stickerPackId: params.stickerPackId);
  }
}
