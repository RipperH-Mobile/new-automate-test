import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_all_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class FetchRoomFileUseCase extends SimpleUseCase<PaginationPayload<RoomFileEntity>?, FetchRoomFileRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<PaginationPayload<RoomFileEntity>?> call(FetchRoomFileRequest params) async {
    try {
      // Fetch files from the server
      final serverResponse = await chatRoomDetailServerRepository.fetchRoomFiles(params);

      if (serverResponse?.data != null) {
        // Save files to local repository
        await chatRoomDetailLocalRepository.putAllRoomFile(
          PutAllRoomFileRequest(roomFiles: serverResponse!.data!.map((e) => RoomFileCollection.fromEntity(e)).toList()),
        );
      }

      return serverResponse;
    } catch (e, stackTrace) {
      // Don't log error if it because user doesn't have internet.
      if (e is! FailedHostLookupException) {
        _log.w('FetchRoomFileUseCase from server error. Returning data from local db.', e, stackTrace);
      }

      /// If failed to fetch from server, return local data.
      // Retrieve all files in the room from local repository
      return await chatRoomDetailLocalRepository.getAllFileInRoom(params);
    }
  }
}
