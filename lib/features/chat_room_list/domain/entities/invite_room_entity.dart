// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enum/invited_status.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/app_env.dart';

@immutable
class InviteRoomEntity {
  final String id;
  final String roomName;
  final RoomAccessType accessType;
  final RoomType? roomType;
  final InvitedStatus invitedStatus;
  final int memberCount;
  final String? photoId;
  final List<ContactEntity>? members;
  final bool isViaLink;

  const InviteRoomEntity({
    required this.id,
    required this.roomName,
    required this.accessType,
    required this.roomType,
    required this.invitedStatus,
    required this.memberCount,
    this.photoId,
    this.members,
    this.isViaLink = false,
  });

  factory InviteRoomEntity.fromMap(Map<String, dynamic> map) {
    return InviteRoomEntity(
      id: map['roomId'] as String,
      roomName: map['roomName'] as String,
      memberCount: map['memberCount'] as int,
      accessType: RoomAccessType.from(map['accessType'] as String),
      roomType: RoomType.from(map['roomType'] as String),
      invitedStatus: InvitedStatus.from(map['invitedStatus'] as String),
      photoId: map['photoId'] as String?,
      members:
          (map['members'] as List<dynamic>?)?.map((e) => ContactEntity.fromMap(e as Map<String, dynamic>)).toList(),
      isViaLink: map['isViaLink'] as bool? ?? false,
    );
  }

  bool get isGroup => roomType == RoomType.group;

  bool get isDirect => roomType == RoomType.direct;

  String get roomAvatarUrl {
    if (photoId == null || photoId?.isEmpty == true) {
      return defaultRoomAvatarUrl;
    }

    if (id.contains('mock') == true) {
      return '${AppEnv.apiUrl}assets/$photoId';
    }
    return FileService().getFileUrl(photoId!);
  }

  String get roomPublicAvatar {
    return '${AppEnv.apiUrl}v2/chat-rooms/$id/public-avatar';
  }

  String get defaultRoomAvatarUrl {
    return 'https://www.gravatar.com/avatar/$id?s=80&d=identicon&r=g';
  }

  @override
  String toString() {
    return 'InviteRoomEntity(id: $id, roomName: $roomName, accessType: $accessType, roomType: $roomType, invitedStatus: $invitedStatus, memberCount: $memberCount, photoId: $photoId, members: $members, isViaLink: $isViaLink)';
  }
}
