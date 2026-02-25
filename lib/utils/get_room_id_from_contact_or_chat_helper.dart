import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

final roomDb = GetIt.I<RoomDb>();
final roomMemberDb = GetIt.I<RoomMemberDb>();
final roomSubDb = GetIt.I<RoomSubscriptionDb>();

/// return List of room id from [selectedValue] and update latestShare value of that room in local db.
Future<List<String>> getRoomIdHelper(List<Object> selectedValue) async {
  List<String> roomIds = [];
  for (var obj in selectedValue) {
    RoomCollection? room;
    if (obj is RoomCollection) {
      room = obj;
    } else if (obj is ContactCollection) {
      try {
        String? id = roomMemberDb.getDirectRoomIdByOtherIdInRoomSync(obj.id ?? '');
        final processRoom = roomDb.getRoomSync(id ?? '');
        if (processRoom != null) {
          room = processRoom;
        } else {
          // If room in local db is not found, Get it from server.
          final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
            OpenDirectChatRequest(friendAccountId: obj.id!),
          );
          if (roomEntity != null) {
            room = RoomCollection.fromEntity(roomEntity);
          }
        }
      } catch (_) {
        // User and friend without chat
        final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: obj.id!),
        );
        if (roomEntity != null) {
          room = RoomCollection.fromEntity(roomEntity);
        }
      }
    } else if (obj is RoomSubscriptionCollection) {
      room = await GetIt.I<RoomDb>().getRoom(obj.roomId ?? '');
    }
    if (room != null && room.id != null && room.id!.isNotEmpty) {
      final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(room.id!);
      if (roomSub != null) {
        roomSub.latestShare = DateTime.now();
        await roomSubDb.putRoomSubscription(roomSub);
      }
      roomIds.add(room.id!);
    }
  }
  return roomIds;
}
