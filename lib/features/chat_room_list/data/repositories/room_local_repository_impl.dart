import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_local_repository.dart';

class RoomLocalRepositoryImpl implements RoomLocalRepository {
  final RoomDb roomDb;
  final _log = useLogger();

  RoomLocalRepositoryImpl({
    required this.roomDb,
  });

  @override
  Future<List<RoomEntity>> getRoomTypeGroup() async {
    try {
      final groupsResult = await roomDb.getRoomTypeGroup();
      // If null, return empty list, otherwise convert each collection to entity
      if (groupsResult == null) {
        return [];
      }

      // Convert all collections to entities and return
      return Future.wait(groupsResult.map((room) => room.toEntityWithAsync()).toList());
    } catch (e, stackTrace) {
      _log.e('getRoomTypeGroup error', e, stackTrace);
      return []; // Return empty list on error
    }
  }

  @override
  Future<List<RoomEntity>> searchRoomTypeGroup(String query) async {
    try {
      final result = await roomDb.searchRoomTypeGroup(query);
      if (result == null) {
        return [];
      }

      // Convert all collections to entities and return
      return Future.wait(result.map((room) => room.toEntityWithAsync()).toList());
    } catch (e, stackTrace) {
      _log.e('searchRoomTypeGroup error', e, stackTrace);
      return []; // Return empty list on error
    }
  }

  @override
  Future<RoomEntity?> getRoomSync(String roomId) async {
    try {
      final room = roomDb.getRoomSync(roomId);
      if (room == null) {
        return null;
      }

      // Convert collection to entity and return
      return room.toEntityWithAsync();
    } catch (e, stackTrace) {
      _log.e('getRoomSync error', e, stackTrace);
      return null; // Return null on error
    }
  }

  @override
  Future<RoomEntity?> getRoom(String roomId) async {
    try {
      final room = await roomDb.getRoom(roomId);
      if (room == null) {
        return null;
      }

      // Convert collection to entity and return
      return room.toEntityWithAsync();
    } catch (e, stackTrace) {
      _log.e('getRoom error', e, stackTrace);
      return null; // Return null on error
    }
  }
}
