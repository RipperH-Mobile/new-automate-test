import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/reject_group_invite_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RejectRoomUseCase extends SimpleUseCase<dynamic, RejectGroupInviteRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<void> call(RejectGroupInviteRequest params) async {
    return await _chatRoomListServerRepository.rejectRoom(params);
  }
}
