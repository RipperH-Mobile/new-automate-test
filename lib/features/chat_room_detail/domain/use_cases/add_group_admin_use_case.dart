import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_member_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_account_from_member_response.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AddGroupAdminUseCase extends SimpleUseCase<void, AddGroupAdminRequest> {
  final ChatRoomDetailServerRepository chatRoomDetailServerRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;

  AddGroupAdminUseCase({
    required this.chatRoomDetailServerRepository,
    required this.chatRoomLocalRepository,
  });

  @override
  Future<void> call(AddGroupAdminRequest params) async {
    await chatRoomDetailServerRepository.addGroupAdmin(params);

    final localMember = await chatRoomLocalRepository.getOneMemberInRoom(GetAccountFromMemberRequest(
      roomId: params.roomId,
      accountId: params.accountId,
    ));
    if (localMember != null) {
      final newMember = localMember.copyWith(
          groupRole: localMember.groupRole?.copyWith(
        permissions: params.permissions,
        customAdminName: params.customAdminName,
        role: RoomMemberRole.admin,
      ));

      await chatRoomLocalRepository.updateMemberInRoom(newMember);

      eventBus.fire(
        AssignAdminEvent(
          roomId: params.roomId,
          member: newMember.toCollection(),
        ),
      );
    }
  }
}
