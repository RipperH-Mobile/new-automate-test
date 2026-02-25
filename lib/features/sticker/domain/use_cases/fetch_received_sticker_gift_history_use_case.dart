import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_received_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_received_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchReceivedStickerGiftHistoryParams {
  final DateTime? nextCursor;
  final int? limit;

  FetchReceivedStickerGiftHistoryParams({
    this.nextCursor,
    this.limit = 20,
  });

  GetReceivedStickerGiftHistoryRequest toRequest() {
    return GetReceivedStickerGiftHistoryRequest(
      nextCursor: nextCursor,
      limit: limit,
    );
  }
}

class FetchReceivedStickerGiftHistoryUseCase
    extends SimpleUseCase<CursorPayload<StickerGiftReceivedEntity>?, FetchReceivedStickerGiftHistoryParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;
  final ContactLocalRepository contactLocalRepository;

  FetchReceivedStickerGiftHistoryUseCase({
    required this.storeStickerRemoteRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<CursorPayload<StickerGiftReceivedEntity>?> call(FetchReceivedStickerGiftHistoryParams params) async {
    final receivedHistory = await storeStickerRemoteRepository.fetchReceivedStickerGiftHistory(
      request: params.toRequest(),
    );

    List<StickerGiftReceivedEntity> newData = [];
    for (int i = 0; i < (receivedHistory?.data?.length ?? 0); i++) {
      StickerGiftReceivedEntity history = receivedHistory!.data!.toList()[i];
      // Change giftBy name to contact nickname if it exists.
      final contact = await contactLocalRepository.getContact(history.giftById);
      newData.add(history.copyWith(giftBy: contact?.nickname));
    }
    receivedHistory?.data = newData;

    return receivedHistory;
  }
}
