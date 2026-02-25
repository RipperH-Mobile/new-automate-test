import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';

class RoomSubLocalRepositoryImpl implements RoomSubLocalRepository {
  final RoomSubscriptionDb roomSubDb;
  final _log = useLogger();

  RoomSubLocalRepositoryImpl({
    required this.roomSubDb,
  });

  @override
  Future<List<RoomSubscriptionEntity>> getLatestDirectChatRooms({int limit = 999}) async {
    try {
      final result = await roomSubDb.getLatestDirectChatRooms(limit: limit);
      // Convert collections to entities
      return result.map((collection) => collection.toEntity()).toList();
    } catch (e, stackTrace) {
      _log.e('getLatestDirectChatRooms error', e, stackTrace);
      return []; // Return empty list on error
    }
  }

  Future<List<RoomSubscriptionEntity>> searchRoomTypeDirects(String query) async {
    try {
      final result = await roomSubDb.searchRoomTypeDirects(query);
      // Convert collections to entities
      return result.map((collection) => collection.toEntity()).toList();
    } catch (e, stackTrace) {
      _log.e('searchRoomTypeDirects error', e, stackTrace);
      return []; // Return empty list on error
    }
  }

  @override
  Future<RoomSubscriptionEntity?> getRoomSubscriptionWithRoomId(String roomId) async {
    final collection = roomSubDb.getRoomSubscriptionWithRoomIdSync(roomId);
    return collection?.toEntity();
  }

  @override
  Future<RoomSubscriptionEntity?> putRoomSubscription(RoomSubscriptionEntity roomSub) async {
    // Convert entity to collection for storage
    final collection = RoomSubscriptionCollection.fromEntity(roomSub);
    final result = await roomSubDb.putRoomSubscription(collection);
    return result?.toEntity();
  }

  @override
  Future<RoomSubscriptionEntity?> putRoomSubscriptionWithoutTxn(RoomSubscriptionEntity roomSub) async {
    // Convert entity to collection for storage
    final collection = RoomSubscriptionCollection.fromEntity(roomSub);
    final result = await roomSubDb.putRoomSubscriptionWithoutTxn(collection);
    return result?.toEntity();
  }

  @override
  Future<int> countPinedRoomAllChat() async {
    return await roomSubDb.countPinedRoomAllChat();
  }

  @override
  Future<int> countPinedRoomInFolder() async {
    return await roomSubDb.countPinedRoomInFolder();
  }
}
