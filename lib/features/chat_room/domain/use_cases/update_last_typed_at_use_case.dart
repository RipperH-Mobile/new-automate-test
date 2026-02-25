import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_last_typed_at_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateLastTypedAtUseCase extends SimpleUseCase<void, UpdateLastTypedAtRequest> {
  ChatRoomServerRepository get _chatRoomServerRepo {
    return GetIt.I<ChatRoomServerRepository>();
  }

  @override
  Future<void> call(UpdateLastTypedAtRequest params) async {
    await _chatRoomServerRepo.updateLastTypedAt(params);
  }
}
