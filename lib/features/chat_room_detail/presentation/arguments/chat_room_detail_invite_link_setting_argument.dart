import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';

@immutable
class ChatRoomDetailInviteLinkSettingArgument {
  final String roomId;
  final InviteLinkStatus inviteLinkStatus;

  const ChatRoomDetailInviteLinkSettingArgument({
    required this.roomId,
    required this.inviteLinkStatus,
  });
}
