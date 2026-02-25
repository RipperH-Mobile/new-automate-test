import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/params/save_recent_search_result_param.dart';

class ChatListSearchSocketService {
  final SocketCaller socketCaller;

  ChatListSearchSocketService({
    required this.socketCaller,
  });

  Future<List<RecentSearchResultModel>> saveRecentSearchResult(SaveRecentSearchResultParam request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.saveRecentSearchResult.socket,
      request.toJson(),
    );

    return res.listToResponseV3((data) => RecentSearchResultModel.fromJson(data))?.toList() ?? [];
  }

  Future<List<RecentSearchResultModel>> getRecentSearchResult() async {
    final res = await socketCaller.emitCallV3(BackendPath.getRecentSearchList.socket, {});
    return res.listToResponseV3((data) => RecentSearchResultModel.fromJson(data))?.toList() ?? [];
  }

  Future<void> clearAllRecentSearchResult() async {
    await socketCaller.emitCallV3(BackendPath.clearAllRecentSearchResult.socket, {});
  }

  Future<void> removeRecentSearchResult(String id) async {
    await socketCaller.emitCallV3(BackendPath.removeRecentSearchResult.socket, {
      'recentSearchId': id,
    });
  }
}
