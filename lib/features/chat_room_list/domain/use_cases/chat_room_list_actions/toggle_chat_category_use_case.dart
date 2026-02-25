import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_chat_category_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleChatCategoryUseCase extends SimpleUseCase<dynamic, ToggleChatCategoryRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<bool> call(ToggleChatCategoryRequest params) async {
    return await _chatRoomListServerRepository.toggleChatCategory(params);
  }
}
