import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/end_secret_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/end_secret_chat_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class EndSecretChatUseCase extends SimpleUseCase<void, EndSecretChatParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(EndSecretChatParams params) async {
    return await chatRoomDetailServerRepository.endSecretChat(EndSecretChatRequest(roomId: params.roomId));
  }
}
