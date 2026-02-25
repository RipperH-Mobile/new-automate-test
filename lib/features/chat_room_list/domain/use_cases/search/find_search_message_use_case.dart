import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/params/find_search_message_param.dart';
import 'package:uchat/use_cases/use_case.dart';

class FindSearchMessageUseCase extends SimpleUseCase<(bool, MessageEntity), FindSearchMessageParam> {
  final MessageLocalRepository messageLocalRepository;

  FindSearchMessageUseCase({
    required this.messageLocalRepository,
  });

  @override
  Future<(bool, MessageEntity)> call(FindSearchMessageParam params) async {
    final message = params.message;

    if (message.id == null) {
      return (false, message);
    }

    final localMessage = await messageLocalRepository.getMessageById(id: message.id!);
    if (localMessage != null) {
      return (true, localMessage);
    } else {
      return (false, message);
    }
  }
}
