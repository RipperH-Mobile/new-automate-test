// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:uchat/entities/enum/invite_link_status.dart';

@immutable
class RoomInviteLinkEntity {
  final String roomId;
  final InviteLinkStatus enable;
  final String? inviteLink;

  const RoomInviteLinkEntity({
    required this.roomId,
    required this.enable,
    this.inviteLink,
  });

  RoomInviteLinkEntity copyWith({
    String? roomId,
    InviteLinkStatus? enable,
    String? inviteLink,
  }) {
    return RoomInviteLinkEntity(
      roomId: roomId ?? this.roomId,
      enable: enable ?? this.enable,
      inviteLink: inviteLink ?? this.inviteLink,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomInviteLinkEntity &&
        other.roomId == roomId &&
        other.enable == enable &&
        other.inviteLink == inviteLink;
  }

  @override
  int get hashCode => roomId.hashCode ^ enable.hashCode ^ inviteLink.hashCode;

  @override
  String toString() => 'RoomInviteLinkEntity(roomId: $roomId, enable: $enable, inviteLink: $inviteLink)';

  factory RoomInviteLinkEntity.fromMap(Map<String, dynamic> map) {
    return RoomInviteLinkEntity(
      roomId: map['roomId'] as String,
      enable: InviteLinkStatus.from(map['isActive'] as bool),
      inviteLink: map['inviteLink'] != null ? map['inviteLink'] as String : null,
    );
  }
}
