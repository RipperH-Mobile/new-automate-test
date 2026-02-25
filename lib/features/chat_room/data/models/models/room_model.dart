import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/features/chat_room/data/models/mixin/room_mixin.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class RoomModel with RoomMixin implements RoomInterface {
  @override
  RoomAccessType? accessType;

  @override
  CallStatusType? callStatus;

  @override
  String? callType;

  @override
  DateTime? createdAt;

  @override
  bool? deleted;

  @override
  String? groupRef;

  @override
  String? id;

  @override
  bool? isJoined;

  @override
  bool? isRequesting;

  DateTime? latestShare;

  @override
  DateTime? latestSearch;

  @override
  int? memberRequestCount;

  @override
  RoomMetaModel? meta;

  RoomSubscriptionCollection? mySubscription;

  @override
  bool notRequireToFetchOld = false;

  @override
  RoomMemberCollection? originalFirstOtherInRoom;

  @override
  RoomMemberCollection? originalMeInRoom;

  @override
  String? originalRoomName;

  @override
  String? ownerId;

  @override
  String? photoId;

  @override
  String? photoBlurhash;

  @override
  RoomType? roomType;

  @override
  DateTime? updatedAt;

  @override
  bool? hasFailedMessage;

  @override
  String? draftMessage;

  @override
  MessageModel? draftReplyMessage;

  @override
  String? roomPublicKey;

  @override
  String? roomCryptoKey;

  @override
  int? expireIn;

  @override
  DateTime? expireAt;

  @override
  int? memberCount;

  @override
  String? otherPublicKey;

  @override
  String? selfPrivateKey;

  RoomModel({
    this.id,
    this.roomType,
    this.createdAt,
    this.updatedAt,
    this.mySubscription,
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
  });

  factory RoomModel.fromMap(Map<String, dynamic> json) {
    // Process room type
    final roomType = RoomType.from(json['roomType']);

    var room = RoomModel(
      id: json['_id'],
      createdAt: strToDateTime(json['createdAt']),
      updatedAt: strToDateTime(json['updatedAt']),
      originalRoomName: json['roomName'],
      roomType: roomType,
      photoId: json['photoId'],
      ownerId: json['ownerId'],
      deleted: json['deleted'],
      groupRef: json['groupRef'],
      callType: json['callType'],
      mySubscription: json['mySubscription'] != null
          ? RoomSubscriptionCollection.fromMap(
              json['mySubscription'],
            )
          : null,
    );

    if (json['callStatus'] != null) {
      room.callStatus = CallStatusType.from(json['callStatus']);
    }

    if (json['owner'] != null) {
      room.ownerId = json['owner']['_id'];
    }

    if (json['isJoined'] != null) {
      try {
        room.isJoined = json['isJoined'] as bool;
      } catch (e, stackTrace) {
        _log.e('Error parse is joined. (${json['isJoined']})', e, stackTrace);
      }
    }

    if (json['isRequesting'] != null) {
      try {
        room.isRequesting = json['isRequesting'] as bool;
      } catch (e, stackTrace) {
        _log.e(
          'Error parse is requesting. (${json['isRequesting']})',
          e,
          stackTrace,
        );
      }
    }

    if (json['accessType'] != null) {
      room.accessType = RoomAccessType.from(json['accessType']);
    } else {
      room.accessType = RoomAccessType.public;
    }

    if (json['memberRequestCount'] != null) {
      room.memberRequestCount = json['memberRequestCount'];
    }

    // Meta
    if (json['meta'] != null) {
      try {
        room.meta = RoomMetaModel.fromMap(json['meta']);
      } catch (e, stackTrace) {
        _log.e('Error parse meta. (${json['meta']})', e, stackTrace);
      }
    }

    // Menu Meta
    if (json['menuMeta'] != null) {
      _log.d('menuMeta: ${json['menuMeta']}');
      room.meta ??= RoomMetaModel();

      try {
        room.meta!.menu = RoomMenuModel.fromMap(json['menuMeta']);
      } catch (e, stackTrace) {
        _log.e('Error parse menu meta. (${json['menuMeta']})', e, stackTrace);
      }
    }

    // Publish menu
    if (json['publishMenu'] != null) {
      // _log.i('PublishMenu: ${json['publishMenu']}');
      room.meta ??= RoomMetaModel();

      room.meta!.menu ??= RoomMenuModel();
      try {
        room.meta!.menu!.publishMenu =
            (json['publishMenu'] as List<dynamic>).map((e) => RoomMenuActionModel.fromMap(e)).toList();
      } catch (e, stackTrace) {
        _log.e(
          'Error parse publish menu. (${json['publishMenu']})',
          e,
          stackTrace,
        );

        room.meta!.menu!.publishMenu = [];
      }
    }

    /// Encryption
    if (json['publicKey'] != null) {
      room.roomPublicKey = json['publicKey'].toString();
    }

    if (json['memberCount'] != null) {
      room.memberCount = int.tryParse(json['memberCount']);
    }

    return room;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomType': roomType?.value,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'originalRoomName': originalRoomName,
      'ownerId': ownerId,
      'photoId': photoId,
      'photoBlurhash': photoBlurhash,
      'deleted': deleted,
      'groupRef': groupRef,
      'notRequireToFetchOld': notRequireToFetchOld,
      'accessType': accessType?.value,
      'memberRequestCount': memberRequestCount,
      'meta': meta?.toMap(),
      'callType': callType,
      'callStatus': callStatus?.value,
      'hasFailedMessage': hasFailedMessage,
      'draftMessage': draftMessage,
      'draftReplyMessage': draftReplyMessage?.toMap(),
      'roomPublicKey': roomPublicKey,
      'roomCryptoKey': roomCryptoKey,
      'memberCount': memberCount,
      'otherPublicKey': otherPublicKey,
      'selfPrivateKey': selfPrivateKey,
      'expireIn': expireIn,
      'expireAt': expireAt?.toIso8601String(),
      'isJoined': isJoined,
      'isRequesting': isRequesting,
      'latestSearch': latestSearch?.toIso8601String(),
      'mySubscription': mySubscription?.toMap(),
      'originalFirstOtherInRoom': originalFirstOtherInRoom?.toMap(),
      'originalMeInRoom': originalMeInRoom?.toMap(),
    };
  }

  RoomCollection toRoomCollection() {
    final roomCollection = RoomCollection();

    roomCollection.id = id;
    roomCollection.roomType = roomType;
    roomCollection.originalRoomName = originalRoomName;
    roomCollection.createdAt = createdAt;
    roomCollection.updatedAt = updatedAt;
    roomCollection.callStatus = callStatus;
    roomCollection.callType = callType;
    roomCollection.originalMeInRoom = originalMeInRoom;
    roomCollection.deleted = deleted;
    roomCollection.photoId = photoId;
    roomCollection.groupRef = groupRef;
    roomCollection.accessType = accessType;
    roomCollection.memberRequestCount = memberRequestCount;
    roomCollection.meta = meta;
    roomCollection.notRequireToFetchOld = notRequireToFetchOld;
    roomCollection.isJoined = isJoined;
    roomCollection.isRequesting = isRequesting;
    roomCollection.originalFirstOtherInRoom = originalFirstOtherInRoom;
    roomCollection.draftMessage = draftMessage;
    roomCollection.draftReplyMessage = draftReplyMessage;
    roomCollection.otherPublicKey = otherPublicKey;
    roomCollection.selfPrivateKey = selfPrivateKey;

    return roomCollection;
  }

  static RoomModel fromEntity(RoomEntity entity) {
    return RoomModel(
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      originalRoomName: entity.roomName,
      roomType: entity.roomType,
      photoId: entity.photoId,
      ownerId: entity.ownerId,
      deleted: entity.deleted,
      groupRef: entity.groupRef,
      callType: entity.callType,
      accessType: entity.accessType,
      meta: entity.meta,
      callStatus: entity.callStatus,
      draftMessage: entity.draftMessage,
      draftReplyMessage: entity.draftReplyMessage != null ? MessageModel.fromEntity(entity.draftReplyMessage!) : null,
      roomPublicKey: entity.roomPublicKey,
      otherPublicKey: entity.otherPublicKey,
      selfPrivateKey: entity.selfPrivateKey,
      memberRequestCount: entity.memberRequestCount,
      memberCount: entity.memberCount,
    );
  }

  @override
  String toString() {
    return '[RoomModel] ID: "$id", NAME: "$roomName", TYPE: "$roomType", TITLE: "$title"';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomModel && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
