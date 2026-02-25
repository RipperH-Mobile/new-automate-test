import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetEmojiPackagesUseCase extends SimpleUseCase<PaginationPayload<EmojiPackageEntity>, GetEmojiPackagesRequest> {
  GetEmojiPackagesUseCase({
    required this.emojiRepository,
  });

  final EmojiServerRepository emojiRepository;

  @override
  Future<PaginationPayload<EmojiPackageEntity>> call(GetEmojiPackagesRequest params) async {
    return await emojiRepository.getEmojiPackages(params);
  }
}
