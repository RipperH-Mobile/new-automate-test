// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';

@immutable
class ChatRoomDetailInviteLinkArgument {
  final String roomId;
  final RoomAccessType groupType;
  final RoomInviteLinkEntity roomInviteLink;

  const ChatRoomDetailInviteLinkArgument({
    required this.roomId,
    required this.groupType,
    required this.roomInviteLink,
  });

  @override
  String toString() {
    return 'ChatRoomDetailInviteLinkArgument(roomId: $roomId, groupType: $groupType, roomInviteLink: $roomInviteLink)';
  }
}
