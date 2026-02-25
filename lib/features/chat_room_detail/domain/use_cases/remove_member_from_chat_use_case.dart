import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_member_from_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/remove_member_from_chat_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemoveMemberFromChatUseCase extends SimpleUseCase<void, RemoveMemberFromChatParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(RemoveMemberFromChatParams params) async {
    return await chatRoomDetailServerRepository.removeMemberFromChat(RemoveMemberFromChatRequest(
      roomId: params.roomId,
      friendId: params.friendId,
    ));
  }
}
