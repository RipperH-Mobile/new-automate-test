import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_show_expired_date_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_show_expired_date_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleShowExpiredDateUseCase extends SimpleUseCase<void, ToggleShowExpiredDateParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(ToggleShowExpiredDateParams params) async {
    return await chatRoomDetailServerRepository.toggleShowExpiredDate(ToggleShowExpiredDateRequest(
      roomId: params.roomId,
      isShowExpireTime: params.isShowExpireTime,
    ));
  }
}
