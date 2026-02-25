import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_detail_waiting_list_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomMemberFromLocalUseCase
    extends SimpleUseCase<PaginationPayload<RoomMemberEntity>, GetRoomDetailMemberAndPendingRequest> {
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<PaginationPayload<RoomMemberEntity>> call(GetRoomDetailMemberAndPendingRequest params) async {
    int total =
        await chatRoomDetailLocalRepository.getMembersInRoomCount(roomId: params.roomId, keyword: params.keyword);
    PaginationPayload<RoomMemberEntity> result = PaginationPayload<RoomMemberEntity>(
      data: await chatRoomDetailLocalRepository.getMembersInRoom(params),
      total: total,
      totalPages: (total / params.pageSize).ceil(),
      page: params.page,
      pageSize: params.pageSize,
    );
    return result;
  }
}
