import 'dart:convert';
import 'package:uchat/entities/enum/call_status_type.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_action_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/models/room_meta_model.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/utils/nullable_utils.dart';
import 'package:webcrypto/webcrypto.dart';

class RoomEntity {
  final String id;
  final RoomType? roomType;
  final String? roomName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CallStatusType? callStatus;
  final String? callType;
  final bool? deleted;
  final String? photoId;
  final String? photoBlurhash;
  final String? ownerId;
  final String? groupRef;
  final RoomAccessType? accessType;
  final RoomMetaModel? meta;
  final DateTime? latestSearch;
  final bool? isJoined;
  final bool? isRequesting;
  final bool? hasFailedMessage;
  final String? draftMessage;
  final MessageEntity? draftReplyMessage;
  final String? roomPublicKey;
  final String? roomCryptoKey;
  final int? memberCount;
  final int? memberRequestCount;
  final bool? notRequireToFetchOld;

  /// Secret room data
  final String? otherPublicKey;
  final String? selfPrivateKey;
  final int? expireIn;
  final DateTime? expireAt;

  const RoomEntity({
    required this.id,
    this.roomType,
    this.roomName,
    this.createdAt,
    this.updatedAt,
    this.callStatus,
    this.callType,
    this.deleted,
    this.photoId,
    this.photoBlurhash,
    this.ownerId,
    this.groupRef,
    this.accessType,
    this.meta,
    this.latestSearch,
    this.isJoined,
    this.isRequesting,
    this.hasFailedMessage,
    this.draftMessage,
    this.draftReplyMessage,
    this.roomPublicKey,
    this.roomCryptoKey,
    this.memberCount,
    this.memberRequestCount,
    this.notRequireToFetchOld,
    this.otherPublicKey,
    this.selfPrivateKey,
    this.expireIn,
    this.expireAt,
  });

  // Helper method to parse room meta with error handling
  static RoomMetaModel? _parseRoomMeta(Map<String, dynamic> data) {
    RoomMetaModel? meta;

    if (data['meta'] != null) {
      meta = RoomMetaModel.fromMap(data['meta']);
    }

    // Handle menuMeta
    if (data['menuMeta'] != null) {
      meta ??= RoomMetaModel();
      meta.menu = RoomMenuModel.fromMap(data['menuMeta']);
    }

    // Handle publishMenu
    if (data['publishMenu'] != null) {
      meta ??= RoomMetaModel();
      meta.menu ??= RoomMenuModel();
      meta.menu!.publishMenu =
          (data['publishMenu'] as List<dynamic>).map((e) => RoomMenuActionModel.fromMap(e)).toList();
    }
    return null;
  }

  /// fromJson factory to create RoomEntity from a JSON map
  factory RoomEntity.fromJson(Map<String, dynamic> data) {
    return RoomEntity(
      id: data['_id'] ?? '',
      roomType: data['roomType'] != null ? RoomType.from(data['roomType']) : null,
      roomName: data['roomName'],
      createdAt: data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
      updatedAt: data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
      callStatus: data['callStatus'] != null ? CallStatusType.from(data['callStatus']) : null,
      callType: data['callType'],
      deleted: data['deleted'],
      photoId: data['photoId'],
      photoBlurhash: data['photoBlurhash'],
      ownerId: data['ownerId'] ?? data['owner']?['_id'],
      groupRef: data['groupRef'],
      accessType: data['accessType'] != null ? RoomAccessType.from(data['accessType']) : null,
      meta: data['meta'] != null ? _parseRoomMeta(data) : null,
      latestSearch: data['latestSearch'] != null ? DateTime.parse(data['latestSearch']).toLocal() : null,
      isJoined: data['isJoined'],
      isRequesting: data['isRequesting'],
      hasFailedMessage: data['hasFailedMessage'],
      draftMessage: data['draftMessage'],
      draftReplyMessage: data['draftReplyMessage'] != null ? MessageEntity.fromJson(data['draftReplyMessage']) : null,
      roomPublicKey: data['publicKey'] != null ? json.encode(data['publicKey']) : null,
      roomCryptoKey: data['cryptoKey'],
      memberCount: data['membership'],
      otherPublicKey: data['encryptionKey']?['friendPublicKey'] != null
          ? json.encode(data['encryptionKey']['friendPublicKey'])
          : null,
      selfPrivateKey: data['encryptionKey']?['accountPrivateKey'] != null
          ? json.encode(data['encryptionKey']['accountPrivateKey'])
          : null,
      expireIn: data['expireIn'],
      expireAt: data['expireAt'] != null ? DateTime.parse(data['expireAt']).toLocal() : null,
    );
  }

  /// Create a copy of this entity with updated fields
  RoomEntity copyWith({
    String? roomId,
    RoomType? roomType,
    String? roomName,
    DateTime? createdAt,
    DateTime? updatedAt,
    CallStatusType? callStatus,
    String? callType,
    bool? deleted,
    String? photoId,
    String? photoBlurhash,
    String? ownerId,
    String? groupRef,
    RoomAccessType? accessType,
    RoomMetaModel? meta,
    DateTime? latestSearch,
    bool? isJoined,
    bool? isRequesting,
    bool? hasFailedMessage,
    String? draftMessage,
    Nullable<MessageEntity>? draftReplyMessage,
    String? roomPublicKey,
    String? roomCryptoKey,
    int? memberCount,
    int? memberRequestCount,
    bool? notRequireToFetchOld,
    String? otherPublicKey,
    String? selfPrivateKey,
    int? expireIn,
    DateTime? expireAt,
  }) {
    return RoomEntity(
      id: roomId ?? id,
      roomType: roomType ?? this.roomType,
      roomName: roomName ?? this.roomName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      callStatus: callStatus ?? this.callStatus,
      callType: callType ?? this.callType,
      deleted: deleted ?? this.deleted,
      photoId: photoId ?? this.photoId,
      photoBlurhash: photoBlurhash ?? this.photoBlurhash,
      ownerId: ownerId ?? this.ownerId,
      groupRef: groupRef ?? this.groupRef,
      accessType: accessType ?? this.accessType,
      meta: meta ?? this.meta,
      latestSearch: latestSearch ?? this.latestSearch,
      isJoined: isJoined ?? this.isJoined,
      isRequesting: isRequesting ?? this.isRequesting,
      hasFailedMessage: hasFailedMessage ?? this.hasFailedMessage,
      draftMessage: draftMessage ?? this.draftMessage,
      draftReplyMessage: draftReplyMessage?.isSet == true ? draftReplyMessage?.value : this.draftReplyMessage,
      roomPublicKey: roomPublicKey ?? this.roomPublicKey,
      roomCryptoKey: roomCryptoKey ?? this.roomCryptoKey,
      memberCount: memberCount ?? this.memberCount,
      memberRequestCount: memberRequestCount ?? this.memberRequestCount,
      notRequireToFetchOld: notRequireToFetchOld ?? this.notRequireToFetchOld,
      otherPublicKey: otherPublicKey ?? this.otherPublicKey,
      selfPrivateKey: selfPrivateKey ?? this.selfPrivateKey,
      expireIn: expireIn ?? this.expireIn,
      expireAt: expireAt ?? this.expireAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomType': roomType?.value,
      'roomName': roomName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'callStatus': callStatus?.value,
      'callType': callType,
      'deleted': deleted,
      'photoId': photoId,
      'photoBlurhash': photoBlurhash,
      'ownerId': ownerId,
      'groupRef': groupRef,
      'accessType': accessType?.value,
      'meta': meta?.toMap(),
      'latestSearch': latestSearch?.toIso8601String(),
      'isJoined': isJoined,
      'isRequesting': isRequesting,
      'hasFailedMessage': hasFailedMessage,
      'draftMessage': draftMessage,
      'draftReplyMessage': draftReplyMessage?.toMap(),
      'roomPublicKey': roomPublicKey,
      'roomCryptoKey': roomCryptoKey,
      'memberCount': memberCount,
      'memberRequestCount': memberRequestCount,
      'notRequireToFetchOld': notRequireToFetchOld,
      'otherPublicKey': otherPublicKey,
      'selfPrivateKey': selfPrivateKey,
      'expireIn': expireIn,
      'expireAt': expireAt?.toIso8601String(),
    };
  }

  bool get isSecretRoom {
    return roomType == RoomType.directSecret;
  }

  /// Getter for converting string key to secret key object
  Future<AesGcmSecretKey?> getRoomCryptoKeyObj() async {
    if (roomCryptoKey == null) return null;
    return await AesGcmSecretKey.importJsonWebKey(json.decode(roomCryptoKey!));
  }

  @override
  bool operator ==(Object other) {
    return other is RoomEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '[RoomEntity] ID: "$id", NAME: "$roomName", TYPE: "$roomType", isJoin: "$isJoined", isRequesting: "$isRequesting"';
  }

  bool get isDirectRoom {
    return roomType == RoomType.direct;
  }

  bool get isGroupRoom {
    return roomType == RoomType.group;
  }
}
