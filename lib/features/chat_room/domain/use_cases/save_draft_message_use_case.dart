import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/entities/save_draft_message_entity.dart';
import 'package:uchat/use_cases/use_case.dart';

class SaveDraftMessageUseCase extends SimpleUseCase<void, SaveDraftMessageEntity> {
  final MessageLocalRepository messageLocalRepository;

  SaveDraftMessageUseCase({
    required this.messageLocalRepository,
  });

  @override
  Future<void> call(SaveDraftMessageEntity params) async {
    return messageLocalRepository.saveDraftMessage(params);
  }
}
