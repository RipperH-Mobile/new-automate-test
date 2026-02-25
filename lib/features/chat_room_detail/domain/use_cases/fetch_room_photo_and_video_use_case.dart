import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_photo_and_video_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchRoomPhotoAndVideoUseCase extends SimpleUseCase<List<RoomFileEntity>?, RoomPhotoAndVideoRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<List<RoomFileEntity>?> call(RoomPhotoAndVideoRequest params) async {
    return await chatRoomDetailServerRepository.fetchRoomPhotoAndVideo(params);
  }
}
