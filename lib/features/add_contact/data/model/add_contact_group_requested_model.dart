import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/utils/datetime.dart';

class AddContactGroupRequestedModel {
  String? requestId;
  String? roomId;
  String? roomName;
  String? roomType;
  String? accessType;
  String? photoId;
  String? accountId;
  String? username;
  String? displayName;
  String? avatarId;
  String? avatarBlurhash;
  String? onlineStatus;
  String? statusMessage;
  DateTime? requestedAt;
  GroupRequestType? type;

  AddContactGroupRequestedModel({
    this.requestId,
    this.roomId,
    this.roomName,
    this.roomType,
    this.accessType,
    this.photoId,
    this.accountId,
    this.username,
    this.displayName,
    this.avatarId,
    this.avatarBlurhash,
    this.onlineStatus,
    this.statusMessage,
    this.requestedAt,
    this.type,
  });

  factory AddContactGroupRequestedModel.fromMap(Map<String, dynamic> data) {
    return AddContactGroupRequestedModel(
      requestId: data['requestId'],
      roomId: data['roomId'],
      roomName: data['roomName'],
      roomType: data['roomType'],
      accessType: data['accessType'],
      photoId: data['photoId'],
      accountId: data['accountId'],
      username: data['username'],
      displayName: data['displayName'],
      avatarId: data['avatarId'],
      avatarBlurhash: data['avatarBlurhash'],
      onlineStatus: data['onlineStatus'],
      statusMessage: data['statusMessage'],
      requestedAt: strToDateTime(data['createdAt']),
      type: GroupRequestType.newRequest,
    );
  }

  AddContactGroupRequestedEntity toEntity() {
    return AddContactGroupRequestedEntity(
      requestId: requestId,
      roomId: roomId,
      roomName: roomName,
      roomType: roomType,
      accessType: accessType,
      photoId: photoId,
      accountId: accountId,
      username: username,
      displayName: displayName,
      avatarId: avatarId,
      avatarBlurhash: avatarBlurhash,
      onlineStatus: onlineStatus,
      statusMessage: statusMessage,
      requestedAt: requestedAt,
      type: type,
    );
  }
}
