import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_member_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../../../chat_room/data/models/responses/get_account_from_member_response.dart';

class RemoveGroupAdminUseCase extends SimpleUseCase<void, RemoveGroupAdminRequest> {
  final ChatRoomDetailServerRepository chatRoomDetailServerRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;

  RemoveGroupAdminUseCase({
    required this.chatRoomDetailServerRepository,
    required this.chatRoomLocalRepository,
  });

  @override
  Future<void> call(RemoveGroupAdminRequest params) async {
    await chatRoomDetailServerRepository.removeGroupAdmin(params);
    final updateMember = await chatRoomLocalRepository.getOneMemberInRoom(GetAccountFromMemberRequest(
      roomId: params.roomId,
      accountId: params.accountId,
    ));

    if (updateMember != null) {
      eventBus.fire(
        RevokeAdminEvent(
          roomId: params.roomId,
          member: updateMember.toCollection(),
        ),
      );
    }
  }
}
