import 'package:uchat/features/call_log/domain/entities/call_log_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';

/// Helper class for fetching contacts and rooms related to a list of [CallLogEntity].
///
/// Extracts the repeated data-fetching logic shared across call log use cases
/// so it can be reused without duplication.
class CallLogRelatedDataHelper {
  final ContactLocalRepository contactLocalRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;

  const CallLogRelatedDataHelper({
    required this.contactLocalRepository,
    required this.chatRoomLocalRepository,
  });

  /// Returns the [RoomEntity] list and [ContactEntity] list that correspond
  /// to the [friendId] and [roomId] values found in [callLogs].
  Future<(List<RoomEntity>, List<ContactEntity>)> getRelatedData(
    List<CallLogEntity> callLogs,
  ) async {
    final contactIds = callLogs.map((e) => e.friendId).nonNulls.toSet().toList();
    final roomIds = callLogs.map((e) => e.roomId).nonNulls.toSet().toList();

    // Get contacts from local database for mapping with call logs
    final contacts = await contactLocalRepository.getContactList(contactIds);
    // Get rooms from local database for mapping with call logs
    final rooms = await chatRoomLocalRepository.getRooms(roomIds);

    return (rooms ?? [], contacts);
  }

  /// Searches contacts and group rooms matching [keyword] and returns them as
  /// a `(contacts, rooms)` record.
  ///
  /// [limit] controls the maximum number of contacts fetched (default 500).
  Future<(List<ContactEntity>, List<RoomEntity>)> searchRelatedData(
    String keyword, {
    int limit = 500,
  }) async {
    final contacts = await contactLocalRepository.searchFriendContact(
      SearchFriendContactParams(
        keyword: keyword,
        limit: limit,
        includePhoneNumber: true,
      ),
    );

    final rooms = await chatRoomLocalRepository.searchRoomTypeGroup(keyword);

    return (contacts, rooms ?? []);
  }
}
