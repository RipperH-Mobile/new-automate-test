import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class MarkSendingMessagesAsFailedUseCase extends SimpleUseCase<void, void> {
  final MessageLocalRepository messageLocalRepository;

  MarkSendingMessagesAsFailedUseCase({
    required this.messageLocalRepository,
  });

  @override
  Future<void> call([void params]) async {
    final sendingMessages = await messageLocalRepository.getAllSendingMessagesAcrossRooms();

    if (sendingMessages.isEmpty) {
      return;
    }

    final updatedMessages = sendingMessages.map((message) {
      return message.copyWith(
        isSending: false,
        isSendFailed: true,
        updatedAt: DateTime.now(),
      );
    }).toList();

    await messageLocalRepository.putAllMessages(messages: updatedMessages);
  }
}
