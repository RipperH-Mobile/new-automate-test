import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_invite_link_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class UpdateRoomInviteLinkParams {
  final String roomId;
  final InviteLinkStatus enable;

  const UpdateRoomInviteLinkParams({
    required this.roomId,
    required this.enable,
  });
}

class UpdateRoomInviteLinkUseCase extends SimpleUseCase<RoomInviteLinkEntity?, UpdateRoomInviteLinkParams> {
  final ChatRoomDetailLocalRepository localRepository;
  final ChatRoomDetailServerRepository serverRepository;

  UpdateRoomInviteLinkUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<RoomInviteLinkEntity?> call(UpdateRoomInviteLinkParams params) async {
    final request = RoomInviteLinkRequest(roomId: params.roomId, status: params.enable);
    final serverLink = await serverRepository.updateRoomInviteLink(request);
    if (serverLink != null) {
      await localRepository.updateRoomInviteLink(serverLink);
      return serverLink;
    }
    return await localRepository.getRoomInviteLink(params.roomId);
  }
}
