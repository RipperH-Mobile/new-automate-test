import 'package:uchat/features/sticker/data/models/payloads/check_sticker_owner_payload.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckOwnerStickerUseCase extends SimpleUseCase<void, CheckStickerOwnerRequest> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  CheckOwnerStickerUseCase({required this.storeStickerRemoteRepository});

  @override
  Future<void> call(CheckStickerOwnerRequest params) {
    return storeStickerRemoteRepository.checkOwnerSticker(request: params);
  }
}
