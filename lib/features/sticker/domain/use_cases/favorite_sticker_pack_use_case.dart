// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FavoriteStickerPackParams {
  final String stickerPackId;

  FavoriteStickerPackParams({required this.stickerPackId});
}

class FavoriteStickerPackUseCase extends SimpleUseCase<void, FavoriteStickerPackParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  FavoriteStickerPackUseCase({
    required this.storeStickerRemoteRepository,
  });

  @override
  Future<void> call(FavoriteStickerPackParams params) async {
    await storeStickerRemoteRepository.toggleFavoriteSticker(stickerPackId: params.stickerPackId);
  }
}
