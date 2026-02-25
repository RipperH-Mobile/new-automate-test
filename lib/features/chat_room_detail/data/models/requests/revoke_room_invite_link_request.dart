import 'package:flutter/foundation.dart';

@immutable
class RevokeRoomInviteLinkRequest {
  final String roomId;

  const RevokeRoomInviteLinkRequest({required this.roomId});

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
    };
  }
}
