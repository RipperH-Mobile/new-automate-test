import 'package:flutter/foundation.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';

@immutable
class UpdateRoomInviteLinkEvent {
  final RoomInviteLinkEntity roomInviteLink;

  const UpdateRoomInviteLinkEvent({
    required this.roomInviteLink,
  });
}
