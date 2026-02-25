import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';

extension RoomMemberMapper on RoomMemberCollection {
  RoomMemberEntity toEntity() {
    return RoomMemberEntity(
      roomId: roomId!,
      roomType: roomType!,
      joinedAt: joinedAt,
      lastSeenMessageAt: lastSeenMessageAt,
      lastTypedAt: lastTypedAt,
      groupRole: groupRole,
      firstSequence: firstSequence,
      account: account!,
    );
  }
}

extension RoomMemberEntityMapper on RoomMemberEntity {
  RoomMemberCollection toCollection() {
    return RoomMemberCollection(
      roomId: roomId,
      roomType: roomType,
      joinedAt: joinedAt,
      lastSeenMessageAt: lastSeenMessageAt,
      lastTypedAt: lastTypedAt,
      groupRole: groupRole,
      firstSequence: firstSequence,
      account: account,
    );
  }
}

extension RoomMemberCollectionListExtensions on List<RoomMemberCollection> {
  List<RoomMemberEntity> toEntities() {
    return map((collection) => collection.toEntity()).toList();
  }
}

extension RoomMemberEntityListExtensions on List<RoomMemberEntity> {
  List<RoomMemberCollection> toCollections() {
    return map((entity) => entity.toCollection()).toList();
  }
}
