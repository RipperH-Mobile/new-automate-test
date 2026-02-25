import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room_list/domain/chat_room_list_domain.dart';

class AcceptGroupInvitedUseCase {
  ChatRoomListServerRepository get chatRoomListServerRepository {
    return GetIt.I.get<ChatRoomListServerRepository>();
  }

  Future<void> call(AcceptGroupInviteRequest request) async {
    await chatRoomListServerRepository.acceptRoom(request);
  }
}
