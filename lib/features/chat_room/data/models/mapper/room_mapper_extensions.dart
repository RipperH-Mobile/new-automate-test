import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';

extension RoomCollectionExtensions on RoomCollection {
  Future<RoomEntity> toEntityWithAsync() async {
    if (id == null) {
      throw Exception('Can not create entity : Invalid model data');
    }

    return RoomEntity(
      id: id!,
      roomType: roomType!,
      roomName: await getRoomName(),
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
}

extension RoomEntityExtensions on RoomEntity {
  RoomCollection toCollection() {
    final collection = RoomCollection(
      id: id,
      roomType: roomType,
      originalRoomName: roomName,
      createdAt: createdAt,
      updatedAt: updatedAt,
      callStatus: callStatus,
      callType: callType,
      deleted: deleted,
      photoId: photoId,
      ownerId: ownerId,
      groupRef: groupRef,
      accessType: accessType,
      meta: meta,
      draftMessage: draftMessage,
      draftReplyMessage: draftReplyMessage?.toModel(),
      roomPublicKey: roomPublicKey,
      otherPublicKey: otherPublicKey,
      selfPrivateKey: selfPrivateKey,
      isJoined: isJoined,
      memberRequestCount: memberRequestCount,
      notRequireToFetchOld: notRequireToFetchOld ?? false,
    );

    // Additional fields that aren't in the constructor
    collection.photoBlurhash = photoBlurhash;
    collection.latestSearch = latestSearch;
    collection.hasFailedMessage = hasFailedMessage;
    collection.roomCryptoKey = roomCryptoKey;
    collection.memberCount = memberCount;
    collection.expireIn = expireIn;
    collection.expireAt = expireAt;
    collection.isRequesting = isRequesting;

    return collection;
  }
}

extension RoomEntityListExtensions on List<RoomEntity> {
  List<RoomCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}
