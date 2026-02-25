import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_from_server_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchMessageUseCase extends SimpleUseCase<GetMessageFromServerEntity?, ChatMessagesRequest> {
  FetchMessageUseCase({
    required this.messageRepository,
  });

  final MessageServerRepository messageRepository;

  @override
  Future<GetMessageFromServerEntity?> call(ChatMessagesRequest params) async {
    final getMessageParams = GetMessageFromServerParams(
      roomId: params.roomId,
      pageSize: params.pageSize!,
      isMyNote: false,
    );

    return await messageRepository.getMessageInRoom(getMessageParams);
  }
}
