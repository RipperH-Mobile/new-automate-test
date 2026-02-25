import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/data/models/requests/fetch_albums_request.dart';
import 'package:uchat/features/album/data/models/requests/get_all_album_in_room_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/params/fetch_albums_params.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class FetchAlbumsUseCase extends SimpleUseCase<PaginationPayload<AlbumEntity>?, FetchAlbumsParams> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  @override
  Future<PaginationPayload<AlbumEntity>?> call(FetchAlbumsParams params) async {
    try {
      final serverResult = await albumServerRepository.fetchAlbums(FetchAlbumsRequest(
        roomId: params.roomId,
        page: params.page,
        pageSize: params.pageSize,
      ));

      final dataList = serverResult?.data?.toList();
      if (dataList != null) {
        await albumLocalRepository.putAllAlbum(dataList);
      }
      return serverResult;
    } catch (e, stackTrace) {
      /// If failed to fetch from server, return local data.
      _log.w('Failed to fetch images in album. Using data from local db', e, stackTrace);
      final localResult = await albumLocalRepository.getAllAlbumInRoom(
        GetAllAlbumInRoomRequest(
          roomId: params.roomId,
          page: params.page,
          pageSize: params.pageSize,
        ),
      );
      return localResult;
    }
  }
}
