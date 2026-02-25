import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_file_seq_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_file_seq_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

// TODO (refactor clean) Recheck what is this used for.
class GetFileSeqUseCase extends SimpleUseCase<int?, GetFileSeqParams> {
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<int?> call(GetFileSeqParams params) {
    return chatRoomDetailLocalRepository.getFileSeq(GetFileSeqRequest(roomId: params.roomId));
  }
}
