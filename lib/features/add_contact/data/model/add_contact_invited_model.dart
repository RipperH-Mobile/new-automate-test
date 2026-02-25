import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/utils/datetime.dart';

import '../../domain/entities/add_contact_invited_entity.dart';

class AddContactInvitedModel {
  String? id;
  String? name;
  String? senderName;
  String? senderId;
  String? avatarId;
  bool? isFriendRequest;
  bool? isGroupInvite;
  DateTime? invitedAt;
  List<RoomMemberCollection>? members;
  String? groupRef;
  CentralNotiType? type;

  AddContactInvitedModel({
    this.id,
    this.name,
    this.senderName,
    this.senderId,
    this.avatarId,
    this.isFriendRequest,
    this.isGroupInvite,
    this.invitedAt,
    this.members,
    this.groupRef,
    this.type,
  });

  factory AddContactInvitedModel.fromMapToFriend(Map<String, dynamic> data) {
    AddContactInvitedModel contactReq = AddContactInvitedModel(
      id: data['friendAccountId'],
      name: data['account']?['displayName'] ?? data['account']?['userName'],
      senderName: data['account']?['displayName'],
      avatarId: data['account']?['avatarId'],
      isFriendRequest: true,
      invitedAt: strToDateTime(data['updatedAt']),
      type: CentralNotiType.newFriend,
    );

    return contactReq;
  }

  factory AddContactInvitedModel.fromMapToGroup(Map<String, dynamic> data) {
    AddContactInvitedModel contactReq = AddContactInvitedModel(
      id: data['_id'],
      name: data['roomName'],
      senderName: data['invitedAccount']?['displayName'],
      senderId: data['invitedAccount']?['accountId'],
      avatarId: data['photoId'],
      isGroupInvite: true,
      invitedAt: strToDateTime(data['invitedAt']),
      groupRef: data['groupRef'],
      type: CentralNotiType.inviteGroup,
    );

    if (data['members'] != null) {
      List<RoomMemberCollection> members = [];

      for (final member in data['members']) {
        members.add(RoomMemberCollection.fromMap(member));
      }

      contactReq.members = members;
    }

    return contactReq;
  }

  AddContactInvitedEntity toEntity() {
    return AddContactInvitedEntity(
      id: id,
      name: name,
      senderName: senderName,
      senderId: senderId,
      avatarId: avatarId,
      isFriendRequest: isFriendRequest,
      isGroupInvite: isGroupInvite,
      invitedAt: invitedAt,
      members: members,
      groupRef: groupRef,
      type: type,
    );
  }
}
