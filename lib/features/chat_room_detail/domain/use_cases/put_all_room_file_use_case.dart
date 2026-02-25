import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_all_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PutAllRoomFileUseCase extends SimpleUseCase<void, PutAllRoomFileRequest> {
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<void> call(PutAllRoomFileRequest params) async {
    return await chatRoomDetailLocalRepository.putAllRoomFile(params);
  }
}
