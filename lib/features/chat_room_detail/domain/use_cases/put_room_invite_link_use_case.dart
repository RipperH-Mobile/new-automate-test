import 'package:flutter/foundation.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

@immutable
class PutRoomInviteLinkParams {
  final RoomInviteLinkEntity roomInviteLink;

  const PutRoomInviteLinkParams({required this.roomInviteLink});
}

class PutRoomInviteLinkUseCase extends SimpleUseCase<RoomInviteLinkEntity?, PutRoomInviteLinkParams> {
  final ChatRoomDetailLocalRepository localRepository;

  PutRoomInviteLinkUseCase({required this.localRepository});

  @override
  Future<RoomInviteLinkEntity?> call(PutRoomInviteLinkParams params) async {
    try {
      final roomInviteLink = params.roomInviteLink;
      await localRepository.updateRoomInviteLink(roomInviteLink);
      return roomInviteLink;
    } catch (e, stackTrace) {
      useLogger().e('PutRoomInviteLinkUseCase error: $e', e, stackTrace);
      return localRepository.getRoomInviteLink(params.roomInviteLink.roomId);
    }
  }
}
