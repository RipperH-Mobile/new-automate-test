import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_detail_waiting_list_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_room_member_and_pending_list_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomMemberAndPendingListUseCase
    extends SimpleUseCase<PaginationPayload<RoomDetailMemberAndPendingModel>?, GetRoomMemberAndPendingListParams> {
  ChatRoomDetailServerRepository chatRoomDetailServerRepository;

  GetRoomMemberAndPendingListUseCase({required this.chatRoomDetailServerRepository});

  @override
  Future<PaginationPayload<RoomDetailMemberAndPendingModel>?> call(GetRoomMemberAndPendingListParams params) async {
    return await chatRoomDetailServerRepository.getRoomMemberAndPendingList(GetRoomDetailMemberAndPendingRequest(
      roomId: params.roomId,
      page: params.page,
      pageSize: params.pageSize,
      keyword: params.keyword,
    ));
  }
}
