import 'package:uchat/features/sticker/data/models/payloads/buy_sticker_payload.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_buy_type.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class BuyStickerUseCase extends SimpleUseCase<BuyStickerResponse?, String> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;

  BuyStickerUseCase({required this.storeStickerRemoteRepository});

  @override
  Future<BuyStickerResponse?> call(String params) {
    return storeStickerRemoteRepository.buySticker(
      request: BuyStickerRequest(
        stickerId: params,
        type: StickerBuyType.self,
      ),
    );
  }
}
