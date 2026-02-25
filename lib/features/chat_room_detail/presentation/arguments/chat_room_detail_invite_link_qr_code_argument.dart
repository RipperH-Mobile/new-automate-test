import 'package:flutter/foundation.dart';

@immutable
class ChatRoomDetailInviteLinkQrCodeArgument {
  final String roomId;
  final String inviteLink;

  const ChatRoomDetailInviteLinkQrCodeArgument({
    required this.roomId,
    required this.inviteLink,
  });
}
