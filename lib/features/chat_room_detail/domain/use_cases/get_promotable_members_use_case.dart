import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_promotable_members_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetPromotableMemberUseCase extends SimpleUseCase<List<RoomMemberEntity>, GetPromotableMembersRequest> {
  final ChatRoomDetailLocalRepository chatRoomDetailLocalRepository;

  GetPromotableMemberUseCase({
    required this.chatRoomDetailLocalRepository,
  });

  @override
  Future<List<RoomMemberEntity>> call(GetPromotableMembersRequest params) async {
    return await chatRoomDetailLocalRepository.getPromotableMembers(params);
  }
}
