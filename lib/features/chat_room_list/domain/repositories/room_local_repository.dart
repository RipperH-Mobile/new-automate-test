import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';

abstract class RoomLocalRepository {
  /// Get all group-type rooms
  Future<List<RoomEntity>> getRoomTypeGroup();

  /// Search group-type rooms by a query
  Future<List<RoomEntity>> searchRoomTypeGroup(String query);

  /// Get a single Room by [roomId] synchronously
  Future<RoomEntity?> getRoomSync(String roomId);

  /// Get a single Room by [roomId]
  Future<RoomEntity?> getRoom(String roomId);
}
