import 'package:isar_community/isar.dart';

import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';

part 'message_system_payload_model.g.dart';

@embedded
class MessageSystemPayloadModel {
  String? accountId;
  String? displayName;
  String? albumName;
  String? oldAlbumName;
  String? newAlbumName;
  String? createBy;
  String? createByName;
  String? invitedBy;
  String? invitedByName;
  List<MessageSystemPayloadMemberModel>? newMemberList = [];
  String? removedBy;
  String? removedByName;
  List<MessageSystemPayloadMemberModel>? removeMemberList = [];
  String? callEndDuration;
  String? newRoomName;
  String? roomName;
  String? photoId;
  bool? isViaLink;

  MessageSystemPayloadModel({
    this.accountId,
    this.displayName,
    this.albumName,
    this.oldAlbumName,
    this.createBy,
    this.createByName,
    this.invitedBy,
    this.invitedByName,
    this.newMemberList,
    this.removedBy,
    this.removedByName,
    this.removeMemberList,
    this.callEndDuration,
    this.newRoomName,
    this.roomName,
    this.newAlbumName,
    this.photoId,
    this.isViaLink,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['displayName'] = displayName;
    data['albumName'] = albumName;
    data['oldAlbumName'] = oldAlbumName;
    data['newAlbumName'] = newAlbumName;
    data['createBy'] = createBy;
    data['createByName'] = createByName;
    data['invitedBy'] = invitedBy;
    data['invitedByName'] = invitedByName;
    if (newMemberList != null) {
      data['newMemberList'] = newMemberList!.map((v) => v.toMap()).toList();
    }
    data['removedBy'] = removedBy;
    data['removedByName'] = removedByName;
    if (removeMemberList != null) {
      data['removeMemberList'] = removeMemberList!.map((v) => v.toMap()).toList();
    }
    data['duration'] = callEndDuration;
    data['newRoomName'] = newRoomName;
    data['roomName'] = roomName;
    data['photoId'] = photoId;
    data['isViaLink'] = isViaLink;
    return data;
  }

  factory MessageSystemPayloadModel.fromMap(Map<String, dynamic> json) {
    final payload = MessageSystemPayloadModel(
      accountId: json['accountId'],
      displayName: json['displayName'],
      albumName: json['albumName'],
      oldAlbumName: json['oldAlbumName'],
      createBy: json['createBy'],
      createByName: json['createByName'],
      invitedBy: json['invitedBy'],
      invitedByName: json['invitedByName'],
      removedBy: json['removedBy'],
      removedByName: json['removedByName'],
      roomName: json['roomName'],
      newAlbumName: json['newAlbumName'],
      photoId: json['photoId'],
      isViaLink: json['isViaLink'] as bool? ?? false,
    );

    if (json['newMemberList'] != null && json['newMemberList'] is List) {
      final newMemberList = <MessageSystemPayloadMemberModel>[];

      for (var member in json['newMemberList']) {
        newMemberList.add(MessageSystemPayloadMemberModel.fromMap(member));
      }

      payload.newMemberList = newMemberList;
    }

    if (json['removeMemberList'] != null && json['removeMemberList'] is List) {
      final removeMemberList = <MessageSystemPayloadMemberModel>[];

      for (var member in json['removeMemberList']) {
        removeMemberList.add(MessageSystemPayloadMemberModel.fromMap(member));
      }

      payload.removeMemberList = removeMemberList;
    }

    if (json['duration'] != null) {
      if (json['duration'] is double) {
        payload.callEndDuration = (json['duration'] as double).floor().toString();
      }
      if (json['duration'] is int) {
        payload.callEndDuration = (json['duration'] as int).toString();
      }
    }

    if (json['newRoomName'] != null) {
      payload.newRoomName = json['newRoomName'];
    }

    return payload;
  }

  @override
  String toString() {
    return 'MessageSystemPayloadModel(accountId: $accountId, displayName: $displayName, albumName: $albumName, oldAlbumName: $oldAlbumName, newAlbumName: $newAlbumName, createBy: $createBy, createByName: $createByName, invitedBy: $invitedBy, invitedByName: $invitedByName, newMemberList: $newMemberList, removedBy: $removedBy, removedByName: $removedByName, removeMemberList: $removeMemberList, callEndDuration: $callEndDuration, newRoomName: $newRoomName, roomName: $roomName, photoId: $photoId, isViaLink: $isViaLink)';
  }
}
