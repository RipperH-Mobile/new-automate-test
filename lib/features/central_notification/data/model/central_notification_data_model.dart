import 'package:isar_community/isar.dart';

import '../../domain/entities/central_notification_data_entity.dart';

part 'central_notification_data_model.g.dart';

@embedded
class CentralNotificationDataModel {
  String? roomId;
  String? roomName;
  String? roomPhotoId;
  String? displayName;
  String? accountId;
  String? stickerPack;
  String? stickerName;
  String? avatarId;
  String? groupRequestedId;

  CentralNotificationDataModel({
    this.roomId,
    this.roomName,
    this.roomPhotoId,
    this.displayName,
    this.accountId,
    this.stickerPack,
    this.stickerName,
    this.avatarId,
    this.groupRequestedId,
  });

  factory CentralNotificationDataModel.fromMap(Map<String, dynamic> json) {
    return CentralNotificationDataModel(
      roomId: json['roomId'],
      roomName: json['roomName'],
      roomPhotoId: json['roomPhotoId'],
      displayName: json['displayName'],
      accountId: json['accountId'],
      stickerPack: json['stickerPack'],
      stickerName: json['stickerName'],
      avatarId: (json['avatarId']?.isEmpty == false) ? json['avatarId'] : null,
      groupRequestedId: json['requestId'],
    );
  }

  CentralNotificationDataEntity toEntity() {
    return CentralNotificationDataEntity(
      roomId: roomId,
      roomName: roomName,
      roomPhotoId: roomPhotoId,
      displayName: displayName,
      accountId: accountId,
      stickerPack: stickerPack,
      stickerName: stickerName,
      avatarId: avatarId,
      groupRequestedId: groupRequestedId,
    );
  }

  String get widgetKey {
    return 'ROOM-IV-$roomId';
  }

  @override
  String toString() {
    return '[Instance:CentralNotiDataModel] ID: $roomId, NAME: $roomName, ROOM_PHOTO_ID: $roomPhotoId, DISPLAY_NAME: $displayName, ACCOUNT_ID: $accountId , STICKER_PACK : $stickerPack , STICKER_NAME : $stickerName, AVATAR_ID : $avatarId, GROUP_REQUESTED_ID $groupRequestedId';
  }

  @override
  bool operator ==(Object other) {
    return other is CentralNotificationDataModel && roomId == other.roomId;
  }

  @ignore
  @override
  int get hashCode => roomId.hashCode;
}
