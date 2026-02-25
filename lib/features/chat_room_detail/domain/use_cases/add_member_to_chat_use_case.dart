import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_member_to_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AddMemberToChatUseCase extends SimpleUseCase<void, AddMemberToChatRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(AddMemberToChatRequest params) async {
    return await chatRoomDetailServerRepository.addMemberToChat(params);
  }
}
