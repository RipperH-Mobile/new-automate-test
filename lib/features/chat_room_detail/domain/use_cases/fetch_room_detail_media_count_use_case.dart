import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_response.dart';
import 'package:uchat/features/chat_room_detail/domain/params/fetch_room_detail_media_count_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchRoomDetailMediaCountUseCase
    extends SimpleUseCase<FetchRoomDetailMediaCountResponse?, FetchRoomDetailMediaCountParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<FetchRoomDetailMediaCountResponse?> call(FetchRoomDetailMediaCountParams params) async {
    // TODO (improve idea) Get media count from local when fetch from server fail ?
    return await chatRoomDetailServerRepository
        .fetchRoomDetailMediaCount(FetchRoomDetailMediaCountRequest(roomId: params.roomId));
  }
}
