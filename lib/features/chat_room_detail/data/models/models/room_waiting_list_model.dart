import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/contact/data/models/models/contact_model.dart';

import '../../../../contact/data/models/collections/contact_collection.dart';

class RoomDetailMemberAndPendingModel {
  final String roomId;
  final String accountId;
  final String? role;
  final bool isPending;
  final String? accountDisplayName;
  final String? accountStatusMessage;
  final String? accountOnlineStatus;
  final bool isOwner;
  final String? accountAvatarId;
  final String? customTitle;

  RoomDetailMemberAndPendingModel({
    required this.roomId,
    required this.accountId,
    this.role,
    required this.isPending,
    this.accountDisplayName,
    this.accountStatusMessage,
    this.accountOnlineStatus,
    required this.isOwner,
    this.accountAvatarId,
    this.customTitle,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  factory RoomDetailMemberAndPendingModel.fromJson(Map<String, dynamic> json) {
    return RoomDetailMemberAndPendingModel(
      roomId: json['roomId'],
      accountId: json['accountId'],
      role: json['role'],
      isPending: json['isPending'],
      accountDisplayName: json['accountDisplayName'],
      accountStatusMessage: json['accountStatusMessage'],
      accountOnlineStatus: json['accountOnlineStatus'],
      isOwner: json['isOwner'],
      accountAvatarId: json['accountAvatarId'],
      customTitle: json['customTitle'],
    );
  }

  factory RoomDetailMemberAndPendingModel.fromRoomMemberEntity(RoomMemberEntity member) {
    return RoomDetailMemberAndPendingModel(
      roomId: member.roomId,
      accountId: member.account.id!,
      role: member.groupRole?.role?.value,

      /// This should be false because all data in RoomMemberCollection is member that is already in the room.
      /// If the above statement isn't correct then isPending should be saved in RoomMemberCollection and use it here.
      isPending: false,
      accountDisplayName: member.account.name,
      accountOnlineStatus: member.account.onlineStatus?.value,
      isOwner: member.isOwner,
      accountAvatarId: member.account.avatarId,
      accountStatusMessage: member.account.originalStatusMessage,
      customTitle: member.groupRole?.customAdminName,
    );
  }

  ContactModel toContactModel() {
    return ContactModel(
      avatarId: accountAvatarId,
      id: accountId,
      displayName: accountDisplayName,
      originalStatusMessage: accountStatusMessage,
    );
  }

  ContactCollection toContactCollection() {
    return ContactCollection(
      avatarId: accountAvatarId,
      id: accountId,
      displayName: accountDisplayName,
      originalStatusMessage: accountStatusMessage,
    );
  }
}
