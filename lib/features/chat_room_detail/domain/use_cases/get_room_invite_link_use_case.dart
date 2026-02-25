import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class GetRoomInviteLinkUseCaseParams {
  final String roomId;
  final bool fromServer;

  const GetRoomInviteLinkUseCaseParams({
    required this.roomId,
    this.fromServer = false,
  });
}

class GetRoomInviteLinkUseCase extends SimpleUseCase<RoomInviteLinkEntity?, GetRoomInviteLinkUseCaseParams> {
  final ChatRoomDetailLocalRepository localRepository;
  final ChatRoomDetailServerRepository serverRepository;

  GetRoomInviteLinkUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<RoomInviteLinkEntity?> call(GetRoomInviteLinkUseCaseParams params) async {
    if (params.fromServer) {
      final serverLink = await serverRepository.getRoomInviteLink(params.roomId);
      if (serverLink != null) {
        await localRepository.updateRoomInviteLink(serverLink);
        return serverLink;
      }
    }

    return await localRepository.getRoomInviteLink(params.roomId);
  }
}
