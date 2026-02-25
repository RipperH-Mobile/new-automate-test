import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_invite_link_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

class RoomInviteLinkDb {
  static final RoomInviteLinkDb instance = RoomInviteLinkDb._internal();

  factory RoomInviteLinkDb() => instance;

  RoomInviteLinkDb._internal();

  Isar? get dbInstance {
    return DbManager().authenticatedInstance;
  }

  IsarCollection<RoomInviteLinkCollection>? get roomInviteLinkCollection {
    return dbInstance?.roomInviteLinkCollections;
  }

  Future<RoomInviteLinkCollection?> getByRoomId(String roomId) async {
    if (roomInviteLinkCollection == null) return null;
    return roomInviteLinkCollection?.get(fastHash(roomId));
  }

  Future<void> save(RoomInviteLinkCollection inviteLink) async {
    try {
      await roomInviteLinkCollection?.put(inviteLink);
    } catch (_) {
      await dbInstance?.writeTxn(() async {
        await roomInviteLinkCollection?.put(inviteLink);
      });
    }
  }
}
