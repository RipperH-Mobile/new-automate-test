import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllAdminAndOwnerUseCase extends SimpleUseCase<List<RoomMemberEntity>, GetAllAdminRequest> {
  final ChatRoomDetailLocalRepository chatRoomDetailLocalRepository;

  GetAllAdminAndOwnerUseCase({
    required this.chatRoomDetailLocalRepository,
  });

  @override
  Future<List<RoomMemberEntity>> call(GetAllAdminRequest params) async {
    return await chatRoomDetailLocalRepository.getAllAdminAndOwner(params);
  }
}
