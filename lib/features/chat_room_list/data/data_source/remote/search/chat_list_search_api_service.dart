import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/params/save_recent_search_result_param.dart';

class ChatListSearchApiService {
  final HttpCaller httpCaller;

  ChatListSearchApiService({
    required this.httpCaller,
  });

  Future<List<RecentSearchResultModel>> saveRecentSearchResult(SaveRecentSearchResultParam request) async {
    final resp = await httpCaller.post(
      BackendPath.saveRecentSearchResult.http,
      data: request.toJson(),
    );

    return resp.listToResponseV3((data) => RecentSearchResultModel.fromJson(data))?.toList() ?? [];
  }

  Future<List<RecentSearchResultModel>> getRecentSearchResult() async {
    final resp = await httpCaller.get(BackendPath.getRecentSearchList.http);
    return resp.listToResponseV3((data) => RecentSearchResultModel.fromJson(data))?.toList() ?? [];
  }

  Future<void> clearAllRecentSearchResult() async {
    await httpCaller.delete(BackendPath.clearAllRecentSearchResult.http);
  }

  Future<void> removeRecentSearchResult(String id) async {
    await httpCaller.delete(BackendPath.removeRecentSearchResult.http.replaceAll(':recentSearchId', id));
  }
}
