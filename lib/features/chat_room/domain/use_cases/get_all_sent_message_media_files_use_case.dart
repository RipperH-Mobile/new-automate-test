import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllSentMessageMediaFilesParams {
  final String roomId;

  GetAllSentMessageMediaFilesParams({
    required this.roomId,
  });
}

class GetAllSentMessageMediaFilesUseCase extends SimpleUseCase<List<MessageEntity>, GetAllSentMessageMediaFilesParams> {
  final MessageLocalRepository messageLocalRepository;

  GetAllSentMessageMediaFilesUseCase({
    required this.messageLocalRepository,
  });

  @override
  Future<List<MessageEntity>> call(GetAllSentMessageMediaFilesParams params) async {
    return await messageLocalRepository.getAllSentMessageMediaFiles(params.roomId);
  }
}
