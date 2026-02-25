import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchStickerDetailParams {
  final String stickerPackId;

  FetchStickerDetailParams({required this.stickerPackId});
}

class FetchStickerDetailUseCase extends SimpleUseCase<StoreStickerPackEntity?, FetchStickerDetailParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  FetchStickerDetailUseCase({required this.storeStickerRemoteRepository});

  @override
  Future<StoreStickerPackEntity?> call(FetchStickerDetailParams params) async {
    final stickerPackId = params.stickerPackId;

    final stickerPack = await storeStickerRemoteRepository.getStickerDetail(stickerPackId: stickerPackId);

    if (stickerPack == null) {
      throw Exception('Sticker pack not found for id: $stickerPackId');
    }

    return stickerPack;
  }
}
