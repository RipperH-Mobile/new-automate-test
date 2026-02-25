import 'package:uchat/features/chat_room_list/data/data_source/local/recent_search_db.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_local_repository.dart';

class ChatListSearchLocalRepositoryImpl implements ChatListSearchLocalRepository {
  final RecentSearchDb recentSearchDb;

  ChatListSearchLocalRepositoryImpl({
    required this.recentSearchDb,
  });

  @override
  Future<void> putAllRecentSearch(List<RecentSearchCollection> results) async {
    await recentSearchDb.putAllRecentSearch(results);
  }

  @override
  Future<void> putAllRecentSearchWithoutTxn(List<RecentSearchCollection> results) async {
    await recentSearchDb.putAllRecentSearchWithoutTxn(results);
  }

  @override
  void putAllRecentSearchSync(List<RecentSearchCollection> results) {
    recentSearchDb.putAllRecentSearchSync(results);
  }

  @override
  void putAllRecentSearchSyncWithoutTxn(List<RecentSearchCollection> results) {
    recentSearchDb.putAllRecentSearchSyncWithoutTxn(results);
  }

  @override
  Future<List<RecentSearchCollection>?> getAllRecentSearch() async {
    return await recentSearchDb.getAllRecentSearch();
  }

  @override
  List<RecentSearchCollection>? getAllRecentSearchSync() {
    return recentSearchDb.getAllRecentSearchSync();
  }

  @override
  Future<bool?> deleteRecentSearch(String id) async {
    return await recentSearchDb.deleteRecentSearch(id);
  }

  @override
  Future<bool?> deleteRecentSearchWithoutTxn(String id) async {
    return await recentSearchDb.deleteRecentSearchWithoutTxn(id);
  }

  @override
  Future<void> clearCollection() async {
    await recentSearchDb.clearCollection();
  }
}
