import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateDefaultEmojiUseCase extends SimpleUseCase<UpdateDefaultEmojiEntity, UpdateDefaultEmojiRequest> {
  UpdateDefaultEmojiUseCase({
    required this.emojiRepository,
  });

  final EmojiServerRepository emojiRepository;

  @override
  Future<UpdateDefaultEmojiEntity> call(UpdateDefaultEmojiRequest params) async {
    return await emojiRepository.updateDefaultEmoji(params);
  }
}
