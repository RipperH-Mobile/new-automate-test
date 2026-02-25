import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_member_and_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllMemberAndAdminUseCase extends SimpleUseCase<List<RoomMemberEntity>, GetAllMemberAndAdminRequest> {
  final ChatRoomDetailLocalRepository chatRoomDetailLocalRepository;

  GetAllMemberAndAdminUseCase({
    required this.chatRoomDetailLocalRepository,
  });

  @override
  Future<List<RoomMemberEntity>> call(GetAllMemberAndAdminRequest params) async {
    return await chatRoomDetailLocalRepository.getAllMemberAndAdmin(params);
  }
}
