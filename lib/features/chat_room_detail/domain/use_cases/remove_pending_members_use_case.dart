import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_pending_members_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/remove_pending_members_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemovePendingMembersUseCase extends SimpleUseCase<void, RemovePendingMembersParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(RemovePendingMembersParams params) async {
    await chatRoomDetailServerRepository.removePendingMembers(RemovePendingMembersRequest(
      roomId: params.roomId,
      invitedAccountIds: params.invitedAccountIds,
    ));
  }
}
