import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class AcceptRoomUseCase extends SimpleUseCase<dynamic, AcceptGroupInviteRequest> {
  ChatRoomListServerRepository get chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<void> call(AcceptGroupInviteRequest param) async {
    try {
      await chatRoomListServerRepository.acceptRoom(param);
    } catch (e, stackTrace) {
      _log.w('AcceptRoomUseCase error.', e, stackTrace);
      rethrow;
    }
  }
}
