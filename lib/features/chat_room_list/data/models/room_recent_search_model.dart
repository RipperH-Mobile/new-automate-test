import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';

part 'room_recent_search_model.g.dart';

@embedded
class RoomRecentSearchModel {
  String? roomName;

  String? title;

  @Enumerated(EnumType.name)
  RoomAccessType? accessType;

  @Enumerated(EnumType.name)
  CallStatusType? callStatus;

  String? callType;

  DateTime? createdAt;

  bool? deleted;

  String? groupRef;

  String? id;

  bool? isJoined;

  bool? isRequesting;

  DateTime? latestShare;

  DateTime? latestSearch;

  int? memberRequestCount;

  RoomMetaModel? meta;

  bool notRequireToFetchOld = false;

  String? originalRoomName;

  String? ownerId;

  String? photoId;

  String? photoBlurhash;

  @Enumerated(EnumType.name)
  RoomType? roomType;

  DateTime? updatedAt;

  bool? hasFailedMessage;

  String? draftMessage;

  MessageModel? draftReplyMessage;

  String? roomPublicKey;

  String? roomCryptoKey;

  int? expireIn;

  DateTime? expireAt;

  int? memberCount;

  String? otherPublicKey;

  String? selfPrivateKey;

  bool? isDirect;

  bool? isGroup;

  RoomRecentSearchModel({
    this.id,
    this.roomName,
    this.roomType,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.originalRoomName,
    this.ownerId,
    this.photoId,
    this.deleted,
    this.groupRef,
    this.notRequireToFetchOld = false,
    this.accessType,
    this.memberRequestCount,
    this.meta,
    this.callType,
    this.callStatus,
    this.hasFailedMessage = false,
    this.draftMessage,
    this.draftReplyMessage,
    this.roomPublicKey,
    this.memberCount,
    this.otherPublicKey,
    this.selfPrivateKey,
    this.isDirect,
    this.isGroup,
  });

  static RoomRecentSearchModel fromCollection(RoomCollection data) {
    return RoomRecentSearchModel(
      id: data.id,
      roomName: data.roomName,
      title: data.title,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      originalRoomName: data.roomName,
      roomType: data.roomType,
      photoId: data.photoId,
      ownerId: data.ownerId,
      deleted: data.deleted,
      groupRef: data.groupRef,
      callType: data.callType,
      accessType: data.accessType,
      meta: data.meta,
      callStatus: data.callStatus,
      draftMessage: data.draftMessage,
      draftReplyMessage: data.draftReplyMessage,
      roomPublicKey: data.roomPublicKey,
      otherPublicKey: data.otherPublicKey,
      selfPrivateKey: data.selfPrivateKey,
      memberRequestCount: data.memberRequestCount,
      memberCount: data.memberCount,
      isDirect: data.isDirect,
      isGroup: data.isGroup,
    );
  }

  RoomCollection toCollection() {
    return RoomCollection(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      originalRoomName: roomName,
      roomType: roomType,
      photoId: photoId,
      ownerId: ownerId,
      deleted: deleted,
      groupRef: groupRef,
      callType: callType,
      accessType: accessType,
      meta: meta,
      callStatus: callStatus,
      draftMessage: draftMessage,
      draftReplyMessage: draftReplyMessage,
      roomPublicKey: roomPublicKey,
      otherPublicKey: otherPublicKey,
      selfPrivateKey: selfPrivateKey,
      memberRequestCount: memberRequestCount,
      memberCount: memberCount,
    );
  }

  @override
  String toString() {
    return '[RoomModel] ID: "$id", NAME: "$roomName", TYPE: "$roomType", TITLE: "$title"';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomRecentSearchModel && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
