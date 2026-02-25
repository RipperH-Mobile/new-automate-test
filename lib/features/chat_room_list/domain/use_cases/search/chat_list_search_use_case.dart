import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_model.dart';
import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/params/search_official_account_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/search_friend_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_official_account_contact_use_case.dart';

final _log = useLogger();

class ChatListSearchUseCase {
  final RoomDb roomDb;
  final MessageDb messageDb;
  final RoomSubscriptionDb roomSubDb;
  final RoomMemberDb roomMemberDb;

  ChatListSearchUseCase({
    required this.roomDb,
    required this.messageDb,
    required this.roomSubDb,
    required this.roomMemberDb,
  });

  Future<List<ContactSearchResultModel>> fetchContacts(String keyword, {bool includePhoneNumber = false}) async {
    try {
      final entities = await GetIt.I<SearchFriendContactUseCase>().call(
        SearchFriendContactParams(keyword: keyword, includePhoneNumber: includePhoneNumber),
      );
      final friendSearched = entities.toCollections();
      // if friend search result is less than previewCount, search official account
      final officialAccountSearchedEntities = await GetIt.I<SearchOfficialAccountContactUseCase>().call(
        SearchOfficialAccountContactParams(
          keyword: keyword,
        ),
      );
      final officialAccountSearched = officialAccountSearchedEntities.toCollections();

      final roomSearched = await roomDb.searchRoomTypeGroup(keyword);

      var contactList = <ContactSearchResultModel>[];
      for (var element in [...friendSearched, ...officialAccountSearched]) {
        contactList.add(ContactSearchResultModel(contact: element));
      }
      for (var element in roomSearched!) {
        contactList.add(ContactSearchResultModel(room: element));
      }

      contactList.sort((a, b) {
        // Get display names safely with fallback to empty string
        final aName = (a.contact?.name ?? a.room?.roomName ?? '');
        final bName = (b.contact?.name ?? b.room?.roomName ?? '');

        // Compare names alphabetically
        return aName.compareTo(bName);
      });

      return contactList;
    } catch (e) {
      _log.e('fetchContacts error: $e');
      return [];
    }
  }

  Future<SearchMessagesResultModelWithCount> fetchMessages(String keyword) async {
    try {
      final localMessageSearched = await messageDb.searchMessageInAllRoom(keyword: keyword);
      final localUniversalSearchResult = await convertMessageCollectionToUniversalSearch(keyword, localMessageSearched);
      return localUniversalSearchResult;
    } catch (e) {
      _log.e('fetchContacts error: $e');
      return SearchMessagesResultModelWithCount([], 0);
    }
  }

  Future<SearchMessagesResultModelWithCount> convertMessageCollectionToUniversalSearch(
    String keyword,
    List<MessageCollection> messages,
  ) async {
    // Group messages by room ID
    var groupedByRoomId = <String, List<MessageCollection>>{};
    for (var message in messages) {
      final displayMessage = message.message?.displayMarkUp(getDisplay: true);
      if (displayMessage != null) {
        if (!displayMessage.contains(keyword)) {
          continue;
        }
      }

      var roomId = message.roomId; // room ID in MessageCollection
      groupedByRoomId.putIfAbsent(roomId ?? '', () => []).add(message);
    }

    // Convert each group to a UniversalSearchResultModel
    var localSearchResults = <SearchMessagesResultModel>[];
    int totalMessageCount = 0;
    for (var roomId in groupedByRoomId.keys) {
      var room = await GetIt.I<RoomDb>().getRoom(roomId);
      if (room != null) {
        int foundMessageCount = groupedByRoomId[roomId]!.length;
        totalMessageCount += foundMessageCount;
        localSearchResults.add(SearchMessagesResultModel(
          room: room,
          foundMessageCount: groupedByRoomId[roomId]!.length,
        ));
      }
    }

    localSearchResults.sort((a, b) => a.room.title.compareTo(b.room.title));

    return SearchMessagesResultModelWithCount(
      localSearchResults,
      totalMessageCount,
    );
  }

  Future<void> addRecentSearch(RoomCollection room) async {
    final currentRecentList = await roomDb.getLatestSearchQuery()!.findAll();
    if (currentRecentList.length >= 30) {
      currentRecentList.last.latestSearch = null;
      await roomDb.putRoom(currentRecentList.last, replaceData: true);
    }

    try {
      final localRoom = await roomDb.getRoom(room.id!);
      if (localRoom != null) {
        localRoom.latestSearch = DateTime.now();
        await roomDb.putRoom(localRoom, replaceData: true);
      }
    } catch (e) {
      final localRoom = await roomDb.getRoom(room.id!);
      if (localRoom != null) {
        localRoom.latestSearch = DateTime.now();
        await roomDb.putRoom(localRoom, replaceData: true);
      }
    }
  }

  Future<ContactModel> getRoomContract(String roomId) async {
    final roomMember = await roomMemberDb.getFirstOtherInRoom(roomId);
    if (roomMember != null) {
      return roomMember.account ?? ContactModel();
    }
    return ContactModel();
  }

  Future<void> removeRecentSearch(RecentSearchModel recentItem) async {
    recentItem.room.latestSearch = null;
    await roomDb.putRoom(recentItem.room, replaceData: true);
  }

  Future<void> clearRecentSearch() async {
    await roomDb.clearAllLatestSearch();
  }
}
