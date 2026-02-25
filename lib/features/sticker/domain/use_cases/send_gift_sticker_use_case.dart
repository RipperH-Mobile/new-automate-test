import 'package:uchat/features/sticker/data/models/payloads/buy_sticker_payload.dart';
import 'package:uchat/features/sticker/data/models/payloads/send_gift_payload.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SendGiftStickerUseCase extends SimpleUseCase<BuyStickerResponse?, SendGiftRequest> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  SendGiftStickerUseCase({required this.storeStickerRemoteRepository});

  @override
  Future<BuyStickerResponse?> call(SendGiftRequest params) {
    return storeStickerRemoteRepository.sendGiftSticker(request: params);
  }
}
