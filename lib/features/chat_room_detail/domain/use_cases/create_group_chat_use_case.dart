import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/create_group_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/create_group_chat_response_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CreateGroupChatUseCase extends SimpleUseCase<CreateGroupChatResponseEntity?, CreateGroupChatRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  ChatRoomLocalRepository get chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<CreateGroupChatResponseEntity?> call(CreateGroupChatRequest params) async {
    final response = await chatRoomDetailServerRepository.createGroupChat(params);
    if (response != null) {
      await chatRoomLocalRepository.putRoom(response.room.toEntity());
      return response;
    }
    return null;
  }
}
