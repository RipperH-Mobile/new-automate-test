import 'package:uchat/api/payloads/pagination/cursor_payload.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/sticker/data/models/payloads/get_sent_sticker_gift_history_payload.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_gift_sent_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchSentStickerGiftHistoryParams {
  final DateTime? nextCursor;
  final int? limit;

  FetchSentStickerGiftHistoryParams({
    this.nextCursor,
    this.limit = 20,
  });

  GetSentStickerGiftHistoryRequest toRequest() {
    return GetSentStickerGiftHistoryRequest(
      nextCursor: nextCursor,
      limit: limit,
    );
  }
}

class FetchSentStickerGiftHistoryUseCase
    extends SimpleUseCase<CursorPayload<StickerGiftSentEntity>?, FetchSentStickerGiftHistoryParams> {
  final StoreStickerRemoteRepository storeStickerRemoteRepository;
  final ContactLocalRepository contactLocalRepository;

  FetchSentStickerGiftHistoryUseCase({
    required this.storeStickerRemoteRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<CursorPayload<StickerGiftSentEntity>?> call(FetchSentStickerGiftHistoryParams params) async {
    final sentHistory = await storeStickerRemoteRepository.fetchSentStickerGiftHistory(
      request: params.toRequest(),
    );

    List<StickerGiftSentEntity> newData = [];
    for (int i = 0; i < (sentHistory?.data?.length ?? 0); i++) {
      StickerGiftSentEntity history = sentHistory!.data!.toList()[i];
      // Change giftTo name to contact nickname if it exists.
      final contact = await contactLocalRepository.getContact(history.giftToId);
      newData.add(history.copyWith(giftTo: contact?.nickname));
    }
    sentHistory?.data = newData;

    return sentHistory;
  }
}
