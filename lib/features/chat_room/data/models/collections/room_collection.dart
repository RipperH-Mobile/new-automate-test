import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/album_task_model.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/deleted_by_account_model.dart';
import 'package:webcrypto/webcrypto.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/features/chat_room/data/models/mixin/room_mixin.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/models/last_emoji_model.dart';
import 'package:uchat/features/chat_room/data/models/models/mention_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_call_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_video_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_member_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_system_payload_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'room_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'rooms')
@Name('Room')
class RoomCollection with RoomMixin implements RoomInterface {
  @override
  @Index(unique: true, replace: true)
  String? id;

  Id get isarId => fastHash(id!);

  @override
  @Enumerated(EnumType.name)
  @Index()
  RoomType? roomType;

  @override
  String? originalRoomName;

  @override
  @Index()
  DateTime? createdAt;

  @override
  @Index()
  DateTime? updatedAt;

  @override
  @Enumerated(EnumType.name)
  CallStatusType? callStatus;

  @override
  String? callType; // VOICE, VIDEO

  @override
  @ignore
  RoomMemberCollection? originalMeInRoom;
  @override
  bool? deleted;
  @override
  String? photoId;
  @override
  String? photoBlurhash;
  @override
  String? ownerId;
  @override
  String? groupRef;

  @override
  @Enumerated(EnumType.name)
  RoomAccessType? accessType;

  @override
  int? memberRequestCount = 0;
  @override
  RoomMetaModel? meta;
  @override
  DateTime? latestSearch;

  @override
  bool notRequireToFetchOld = false;
  @override
  bool? isJoined;
  @override
  bool? isRequesting;
  @override
  @ignore
  RoomMemberCollection? originalFirstOtherInRoom;

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
  int? memberCount;

  /// secret room
  // TODO how to store public key in group ?
  // public key of the other member
  @override
  String? otherPublicKey;
  @override
  String? selfPrivateKey;
  @override
  int? expireIn;
  @override
  DateTime? expireAt;

  RoomCollection({
    this.id,
    this.roomType,
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
    this.draftMessage,
    this.draftReplyMessage,
    this.roomPublicKey,
    this.otherPublicKey,
    this.selfPrivateKey,
    this.isJoined,
    this.memberCount,
  });

  // TODO: move to response or entity
  factory RoomCollection.fromMap(Map<String, dynamic> data) {
    // Process room type
    final roomType = data['roomType'] != null ? RoomType.from(data['roomType']) : null;

    var room = RoomCollection(
      id: data['_id'],
      createdAt: strToDateTime(data['createdAt']),
      updatedAt: strToDateTime(data['updatedAt']),
      originalRoomName: data['roomName'],
      roomType: roomType,
      photoId: data['photoId'],
      ownerId: data['ownerId'],
      deleted: data['deleted'],
      groupRef: data['groupRef'],
      callType: data['callType'],
    );

    if (data['callStatus'] != null) {
      room.callStatus = CallStatusType.from(data['callStatus']);
    }

    if (data['owner'] != null) {
      room.ownerId = data['owner']['_id'];
    }

    if (data['isJoined'] != null) {
      try {
        room.isJoined = data['isJoined'] as bool;
      } catch (e, stackTrace) {
        _log.e('Error parse is joined. (${data['isJoined']})', e, stackTrace);
      }
    }

    if (data['isRequesting'] != null) {
      try {
        room.isRequesting = data['isRequesting'] as bool;
      } catch (e, stackTrace) {
        _log.e(
          'Error parse is requesting. (${data['isRequesting']})',
          e,
          stackTrace,
        );
      }
    }

    if (data['accessType'] != null) {
      room.accessType = RoomAccessType.from(data['accessType']);
    }

    if (data['memberRequestCount'] != null) {
      room.memberRequestCount = data['memberRequestCount'];
    }

    // Meta
    if (data['meta'] != null) {
      try {
        room.meta = RoomMetaModel.fromMap(data['meta']);
      } catch (e, stackTrace) {
        _log.e('Error parse meta. (${data['meta']})', e, stackTrace);
      }
    }

    // Menu Meta
    if (data['menuMeta'] != null) {
      _log.d('menuMeta: ${data['menuMeta']}');
      room.meta ??= RoomMetaModel();

      try {
        room.meta!.menu = RoomMenuModel.fromMap(data['menuMeta']);
      } catch (e, stackTrace) {
        _log.e(
          'Error parse menu meta. (${data['menuMeta']})',
          e,
          stackTrace,
        );
      }
    }

    // Publish menu
    if (data['publishMenu'] != null) {
      // _log.i('PublishMenu: ${json['publishMenu']}');
      room.meta ??= RoomMetaModel();

      room.meta!.menu ??= RoomMenuModel();
      try {
        room.meta!.menu!.publishMenu =
            (data['publishMenu'] as List<dynamic>).map((e) => RoomMenuActionModel.fromMap(e)).toList();
      } catch (e, stackTrace) {
        _log.d(
          'Error parse publish menu. (${data['publishMenu']})',
          e,
          stackTrace,
        );

        room.meta!.menu!.publishMenu = [];
      }
    }

    /// secret room
    if (data['expireIn'] != null) {
      room.expireIn = data['expireIn'];
    }
    if (data['expireAt'] != null) {
      DateTime dateTime = DateTime.parse(data['expireAt']).toLocal();

      room.expireAt = dateTime;
    }
    if (data['encryptionKey'] != null) {
      room.selfPrivateKey = json.encode(data['encryptionKey']?['accountPrivateKey']);
      room.otherPublicKey = json.encode(data['encryptionKey']?['friendPublicKey']);
    }

    /// Encryption
    if (data['publicKey'] != null) {
      room.roomPublicKey = json.encode(data['publicKey']);
    }

    if (data['membership'] != null) {
      room.memberCount = data['membership'];
    }

    return room;
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};

    void put(String key, dynamic value) {
      if (value != null) data[key] = value;
    }

    put('_id', id);
    put('roomType', roomType?.name);
    put('roomName', originalRoomName);
    put('createdAt', createdAt?.toUtc().toIso8601String());
    put('updatedAt', updatedAt?.toUtc().toIso8601String());
    put('ownerId', ownerId);
    put('photoId', photoId);
    put('deleted', deleted);
    put('groupRef', groupRef);
    put('accessType', accessType?.name);
    put('memberRequestCount', memberRequestCount);
    put('meta', meta?.toMap());
    put('callType', callType);
    put('callStatus', callStatus?.name);
    put('draftMessage', draftMessage);
    put('draftReplyMessage', draftReplyMessage?.toMap());
    put('publicKey', roomPublicKey != null ? json.decode(roomPublicKey!) : null);

    if (otherPublicKey != null || selfPrivateKey != null) {
      data['encryptionKey'] = {
        if (otherPublicKey != null) 'friendPublicKey': json.decode(otherPublicKey!),
        if (selfPrivateKey != null) 'accountPrivateKey': json.decode(selfPrivateKey!),
      };
    }

    put('isJoined', isJoined);
    put('expireIn', expireIn);
    put('expireAt', expireAt?.toUtc().toIso8601String());

    return data;
  }

  @override
  @ignore
  String? get roomName {
    return super.roomName;
  }

  @override
  @ignore
  String get title {
    return super.title;
  }

  @override
  @Index()
  bool get meIsOwner {
    return super.meIsOwner;
  }

  @override
  @Index()
  bool get isDirect {
    return super.isDirect;
  }

  @override
  @Index()
  bool get isGroup {
    return super.isGroup;
  }

  @override
  @Index()
  bool get isSystem {
    return super.isSystem;
  }

  @override
  @Index()
  bool get canShowInLatestSearch {
    return super.canShowInLatestSearch;
  }

  @override
  @ignore
  bool get hasFirstOtherInRoom {
    return super.hasFirstOtherInRoom;
  }

  @override
  @Index()
  bool get isPrivateGroup {
    return super.isPrivateGroup;
  }

  @ignore
  bool get isRoomEmpty {
    return isDirect == true && hasFirstOtherInRoom == false;
  }

  @Index()
  String? get nameLowercase {
    return originalRoomName?.toLowerCase();
  }

  /// Getter for converting string key to secret key object
  Future<AesGcmSecretKey?> getRoomCryptoKeyObj() async {
    if (roomCryptoKey == null) return null;
    return await AesGcmSecretKey.importJsonWebKey(json.decode(roomCryptoKey!));
  }

  // @override
  // String toString() {
  //   return 'id: $id, rT: $roomType, cAt: $createdAt, uAt: $updatedAt, mySub: $mySubscription, ownId: $ownerId, phoId: $photoId, deleted: $deleted, gRef: $groupRef, notReToFet: $notRequireToFetchOld, adId: $adminIds, accT: $accessType, mbReC: $memberRequestCount, meta: $meta, callT: $callType, callSta: $callStatus, dMs: $draftMessage, dRp: $draftReplyMessage, roomPK: $roomPublicKey, [Interface] roomN: $roomName, title: $title, meOwn: $meIsOwner, isDi: $isDirect, isGroup: $isGroup, canShInLaShare: $canShowInLatestShare, canShInShare: $canShowInShare, canShInLaSearch: $canShowInLatestSearch, hasFiOtInRoom: $hasFirstOtherInRoom, isPin: $isPinned, isPriG: $isPrivateGroup, isMySubHid: $isMySubscriptionHidden, canShInGrSearch: $canShowInGroupSearch, hasMs: $hasMessage, isRoEpt: $isRoomEmpty, oriRN: $originalRoomName, oriMB: $originalMembers';
  // }

  @override
  String toString() {
    return '[RoomCollection] ID: "$id", NAME: "$roomName", TYPE: "$roomType", isPrivateGroup: "$isPrivateGroup", isJoin: "$isJoined", isRequesting: "$isRequesting", draftMessage: "$draftMessage"';
  }

  @override
  bool operator ==(Object other) {
    return other is RoomCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  RoomEntity toEntity() {
    if (id == null) {
      // TODO (exception) This should change to UChat exception class.
      throw Exception('Can not create entity : Invalid model data');
    }

    return RoomEntity(
      id: id!,
      roomType: roomType,
      roomName: roomName,
      createdAt: createdAt,
      updatedAt: updatedAt,
      callStatus: callStatus,
      callType: callType,
      deleted: deleted,
      photoId: photoId,
      photoBlurhash: photoBlurhash,
      ownerId: ownerId,
      groupRef: groupRef,
      accessType: accessType,
      meta: meta,
      latestSearch: latestSearch,
      isJoined: isJoined,
      isRequesting: isRequesting,
      hasFailedMessage: hasFailedMessage,
      draftMessage: draftMessage,
      draftReplyMessage: draftReplyMessage?.toEntity(),
      roomPublicKey: roomPublicKey,
      roomCryptoKey: roomCryptoKey,
      memberCount: memberCount,
      otherPublicKey: otherPublicKey,
      selfPrivateKey: selfPrivateKey,
      expireIn: expireIn,
      expireAt: expireAt,
    );
  }

  static RoomCollection fromEntity(RoomEntity entity) {
    return RoomCollection(
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
      isJoined: entity.isJoined,
      memberRequestCount: entity.memberRequestCount,
      memberCount: entity.memberCount,
      // notRequireToFetchOld: entity.notRequireToFetchOld,
    );
  }
}
