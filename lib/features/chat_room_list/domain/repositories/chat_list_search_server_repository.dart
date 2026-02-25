import 'package:uchat/features/chat_room_list/data/models/recent_search_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/params/save_recent_search_result_param.dart';

abstract class ChatListSearchServerRepository {
  Future<List<RecentSearchResultModel>> getRecentSearchResult();

  Future<List<RecentSearchResultModel>> saveRecentSearchResult(SaveRecentSearchResultParam param);

  Future<void> removeRecentSearchResult(String id);

  Future<void> clearAllRecentSearchResult();
}
