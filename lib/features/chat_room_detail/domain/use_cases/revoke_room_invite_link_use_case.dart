import 'package:uchat/features/chat_room_detail/data/models/requests/revoke_room_invite_link_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RevokeRoomInviteLinkParams {
  final String roomId;

  const RevokeRoomInviteLinkParams({
    required this.roomId,
  });
}

class RevokeRoomInviteLinkUseCase extends SimpleUseCase<RoomInviteLinkEntity?, RevokeRoomInviteLinkParams> {
  final ChatRoomDetailLocalRepository localRepository;
  final ChatRoomDetailServerRepository serverRepository;

  RevokeRoomInviteLinkUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<RoomInviteLinkEntity?> call(RevokeRoomInviteLinkParams params) async {
    final request = RevokeRoomInviteLinkRequest(roomId: params.roomId);
    final serverLink = await serverRepository.revokeRoomInviteLink(request);
    if (serverLink != null) {
      await localRepository.updateRoomInviteLink(serverLink);
      return serverLink;
    }
    return await localRepository.getRoomInviteLink(params.roomId);
  }
}
