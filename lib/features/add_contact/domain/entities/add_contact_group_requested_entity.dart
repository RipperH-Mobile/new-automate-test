import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/entities/models/contact_model.dart';

class AddContactGroupRequestedEntity {
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

  AddContactGroupRequestedEntity({
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

  ContactModel toContactModel() {
    return ContactModel(
      avatarId: avatarId,
      id: accountId,
      displayName: displayName,
      originalStatusMessage: statusMessage,
    );
  }
}
