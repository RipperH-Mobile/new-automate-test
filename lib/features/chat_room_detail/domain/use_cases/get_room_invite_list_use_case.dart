import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_invite_list_response.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomInviteListUseCase extends SimpleUseCase<RoomInviteListResponse?, NoParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<RoomInviteListResponse?> call(NoParams params) async {
    return await chatRoomDetailServerRepository.getRoomInviteList();
  }
}
