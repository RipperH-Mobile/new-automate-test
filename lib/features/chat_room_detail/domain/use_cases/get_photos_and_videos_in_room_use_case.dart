import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_photos_and_videos_in_room_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_photos_and_videos_in_room_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetPhotosAndVideosInRoomUseCase
    extends SimpleUseCase<PaginationPayload<RoomFileEntity>?, GetPhotosAndVideosInRoomParams> {
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<PaginationPayload<RoomFileEntity>?> call(GetPhotosAndVideosInRoomParams params) async {
    return await chatRoomDetailLocalRepository.getPhotosAndVideosInRoom(GetPhotosAndVideosInRoomRequest(
      roomId: params.roomId,
      page: params.page,
      pageSize: params.pageSize,
    ));
  }
}
