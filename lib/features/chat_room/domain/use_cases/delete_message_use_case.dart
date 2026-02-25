import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/domain/params/delete_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteMessageUseCase extends SimpleUseCase<void, DeleteMessageParams> {
  DeleteMessageUseCase({
    required this.messageRepoServer,
    required this.messageRepoLocal,
  });

  final MessageServerRepository messageRepoServer;
  final MessageLocalRepository messageRepoLocal;

  @override
  Future<void> call(DeleteMessageParams params) async {
    await messageRepoServer.removeMessage(params);

    for (final msg in params.messages) {
      final messageId = msg.id;
      final removedFileIds = msg.files;

      if (messageId == null || removedFileIds == null) continue;

      eventBus.fire(UnsentOrRemoveImagesLocalEvent(
        messageId,
        removedFileIds.map((e) => e.id ?? '').toList(),
      ));
    }
  }
}
