import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetEmojiPackagesItemsUseCase
    extends SimpleUseCase<PaginationPayload<EmojiPackageWithItemsEntity>, GetEmojiPackageItemsRequest> {
  GetEmojiPackagesItemsUseCase({
    required this.emojiRepository,
  });

  final EmojiServerRepository emojiRepository;

  @override
  Future<PaginationPayload<EmojiPackageWithItemsEntity>> call(GetEmojiPackageItemsRequest params) async {
    return await emojiRepository.getEmojiPackagesItems(params);
  }
}
