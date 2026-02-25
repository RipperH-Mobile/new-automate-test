// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';

import 'package:uchat/utils/fast_hash.dart';

part 'room_invite_link_collection.g.dart';

@Collection(accessor: 'roomInviteLinkCollections')
@Name('RoomInviteLinkCollection')
class RoomInviteLinkCollection {
  @Index(unique: true, replace: true)
  String? roomId;

  Id get isarId => fastHash(roomId!);

  bool? enable;
  String? inviteLink;

  RoomInviteLinkCollection({
    this.roomId,
    this.enable,
    this.inviteLink,
  });

  @override
  bool operator ==(covariant RoomInviteLinkCollection other) {
    if (identical(this, other)) return true;

    return other.roomId == roomId && other.inviteLink == inviteLink;
  }

  @override
  int get hashCode => roomId.hashCode ^ inviteLink.hashCode;

  @override
  String toString() => 'RoomInviteLinkCollection(roomId: $roomId, enable: $enable, inviteLink: $inviteLink)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'enable': enable,
      'inviteLink': inviteLink,
    };
  }

  factory RoomInviteLinkCollection.fromMap(Map<String, dynamic> map) {
    return RoomInviteLinkCollection(
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      enable: map['enable'] != null ? map['enable'] as bool : null,
      inviteLink: map['inviteLink'] != null ? map['inviteLink'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomInviteLinkCollection.fromJson(String source) =>
      RoomInviteLinkCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  RoomInviteLinkEntity toEntity() {
    return RoomInviteLinkEntity(
      roomId: roomId ?? '',
      enable: InviteLinkStatus.from(enable ?? false),
      inviteLink: inviteLink,
    );
  }

  factory RoomInviteLinkCollection.fromEntity(RoomInviteLinkEntity entity) {
    return RoomInviteLinkCollection(
      roomId: entity.roomId,
      enable: entity.enable.toBool,
      inviteLink: entity.inviteLink,
    );
  }
}
