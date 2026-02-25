import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/search/chat_list_search_api_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/search/chat_list_search_socket_service.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/params/save_recent_search_result_param.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_server_repository.dart';

final _log = useLogger();

class ChatListSearchServerRepositoryImpl implements ChatListSearchServerRepository {
  final SocketCaller socketCaller;
  final ChatListSearchApiService chatListSearchApiService;
  final ChatListSearchSocketService chatListSearchSocketService;

  ChatListSearchServerRepositoryImpl({
    required this.socketCaller,
    required this.chatListSearchApiService,
    required this.chatListSearchSocketService,
  });

  @override
  Future<List<RecentSearchResultModel>> saveRecentSearchResult(SaveRecentSearchResultParam param) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatListSearchSocketService.saveRecentSearchResult(param);
      } catch (e, stackTrace) {
        _log.w('saveRecentSearchResult with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatListSearchApiService.saveRecentSearchResult(param);
  }

  @override
  Future<List<RecentSearchResultModel>> getRecentSearchResult() async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatListSearchSocketService.getRecentSearchResult();
      } catch (e, stackTrace) {
        _log.w('getRecentSearchResult with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatListSearchApiService.getRecentSearchResult();
  }

  @override
  Future<void> clearAllRecentSearchResult() async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatListSearchSocketService.clearAllRecentSearchResult();
      } catch (e, stackTrace) {
        _log.w('clearAllRecentSearchResult with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatListSearchApiService.clearAllRecentSearchResult();
  }

  @override
  Future<void> removeRecentSearchResult(String id) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatListSearchSocketService.removeRecentSearchResult(id);
      } catch (e, stackTrace) {
        _log.w('removeRecentSearchResult with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatListSearchApiService.removeRecentSearchResult(id);
  }
}
