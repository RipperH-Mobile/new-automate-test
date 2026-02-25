import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_mute_call_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleMuteCallNotificationUseCase extends SimpleUseCase<bool, ToggleMuteCallRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<bool> call(ToggleMuteCallRequest params) {
    return chatRoomDetailServerRepository.toggleMuteCallNotification(params);
  }
}
