import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_links_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_links_response.dart';
import 'package:uchat/features/chat_room_detail/domain/params/fetch_room_links_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchRoomLinksUseCase extends SimpleUseCase<PaginationPayload<RoomLinksResponse>?, FetchRoomLinksParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<PaginationPayload<RoomLinksResponse>?> call(FetchRoomLinksParams params) async {
    return await chatRoomDetailServerRepository.fetchRoomLinks(FetchRoomLinksRequest(
      roomId: params.roomId,
      page: params.page,
      pageSize: params.pageSize,
    ));
    // TODO (improve idea) Get links from local if cannot get from server here.
  }
}
