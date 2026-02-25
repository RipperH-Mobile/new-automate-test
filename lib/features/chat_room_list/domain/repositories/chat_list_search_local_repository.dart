import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';

abstract class ChatListSearchLocalRepository {
  Future<void> putAllRecentSearch(List<RecentSearchCollection> results);

  Future<void> putAllRecentSearchWithoutTxn(List<RecentSearchCollection> results);

  void putAllRecentSearchSync(List<RecentSearchCollection> results);

  void putAllRecentSearchSyncWithoutTxn(List<RecentSearchCollection> results);

  Future<List<RecentSearchCollection>?> getAllRecentSearch();

  List<RecentSearchCollection>? getAllRecentSearchSync();

  Future<bool?> deleteRecentSearch(String id);

  Future<bool?> deleteRecentSearchWithoutTxn(String id);

  Future<void> clearCollection();
}
