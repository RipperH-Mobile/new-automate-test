import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetMessageByRefParams {
  final String ref;

  GetMessageByRefParams({
    required this.ref,
  });
}

class GetMessageByRefUseCase extends SimpleUseCase<MessageEntity?, GetMessageByRefParams> {
  final MessageLocalRepository messageLocalRepository;

  GetMessageByRefUseCase({
    required this.messageLocalRepository,
  });

  @override
  Future<MessageEntity?> call(GetMessageByRefParams params) async {
    return await messageLocalRepository.getMessageByRef(ref: params.ref);
  }
}
