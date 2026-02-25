import 'package:uchat/features/sticker/data/models/payloads/get_sticker_history_payload.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchStickerHistoryParams {
  final int limit;
  final DateTime? nextCursor;

  FetchStickerHistoryParams({
    this.limit = 20,
    this.nextCursor,
  });

  // toRequest
  FetchStickerHistoryRequest toRequest() {
    return FetchStickerHistoryRequest(
      type: 'SELF',
      limit: limit,
      nextCursor: nextCursor,
    );
  }
}

class FetchStickerHistoryUseCase extends SimpleUseCase<FetchStickerHistoryResponse?, FetchStickerHistoryParams> {
  final MyStickerRemoteRepository myStickerRemoteRepository;

  FetchStickerHistoryUseCase({
    required this.myStickerRemoteRepository,
  });

  @override
  Future<FetchStickerHistoryResponse?> call(FetchStickerHistoryParams params) async {
    final request = params.toRequest();
    final response = await myStickerRemoteRepository.getHistorySticker(request: request);

    if (response == null) {
      return null;
    }

    return FetchStickerHistoryResponse(
      items: response.data?.toList() ?? [],
      hasMore: response.hasMore,
      totalFound: response.totalFound,
      nextCursor: response.nextCursor,
    );
  }
}
