import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';

@immutable
class RoomInviteLinkRequest {
  final String roomId;
  final InviteLinkStatus status;

  const RoomInviteLinkRequest({
    required this.roomId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'roomId': roomId, 'enabled': status.toBool};
  }
}
