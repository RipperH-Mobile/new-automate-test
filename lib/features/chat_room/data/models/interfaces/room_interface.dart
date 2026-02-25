import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';

abstract class RoomInterface {
  String? id;
  RoomType? roomType;
  String? originalRoomName;
  DateTime? createdAt;
  DateTime? updatedAt;
  CallStatusType? callStatus;
  String? callType;
  @ignore
  RoomMemberCollection? originalMeInRoom;
  bool? deleted;
  String? photoId;
  String? photoBlurhash;
  String? ownerId;
  String? groupRef;
  RoomAccessType? accessType;
  int? memberRequestCount = 0;
  RoomMetaModel? meta;
  DateTime? latestSearch;
  bool notRequireToFetchOld = false;
  bool? isJoined;
  bool? isRequesting;
  @ignore
  RoomMemberCollection? originalFirstOtherInRoom;
  bool? hasFailedMessage;
  String? draftMessage;
  MessageModel? draftReplyMessage;
  String? roomPublicKey;
  String? roomCryptoKey;
  String? otherPublicKey;
  String? selfPrivateKey;
  int? expireIn;
  DateTime? expireAt;
  int? memberCount;

  @ignore
  String? get roomName;

  @ignore
  String get title;

  @ignore
  String? get subTitle;

  @ignore
  bool get hasAvatar;

  String get defaultRoomAvatarUrl;

  @ignore
  String get roomAvatarUrl;

  String get widgetKey;

  bool get meIsOwner;

  bool get isDirect;

  bool get isGroup;

  bool get isSystem;

  bool get canShowInLatestSearch;

  bool get canLeaveGroup;

  bool get canAddAdmin;

  bool get canRemoveAdmin;

  bool get canTransferOwner;

  bool get hasPhotoId;

  bool get hasPhotoBlurhash;

  bool get isPrivateGroup;

  @ignore
  Iterable<RoomMemberCollection> get typingMembers;

  @ignore
  DateTime? get latestLastTypedAt;

  @ignore
  DateTime? get latestLastSeenAt;

  void update(RoomInterface room, {bool ignoreMySubscription = false});
}
