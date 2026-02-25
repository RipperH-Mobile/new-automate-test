import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/album/data/models/requests/fetch_images_in_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/params/fetch_images_in_albums_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class FetchImagesInAlbumUseCase extends SimpleUseCase<PaginationPayload<AlbumImageEntity>?, FetchImagesInAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  @override
  Future<PaginationPayload<AlbumImageEntity>?> call(FetchImagesInAlbumParam params) async {
    /// Idea for improvement later:
    /// Query from local db first to reduce fetch from server.
    /// But in some cases, we still need to fetch from server such as when opening the album image list screen.
    /// or when there are new images uploaded to the album but local db doesn't have all new images yet.
    /// And how do we know if we need to fetch from server or not?
    // TODO (album improve) Improve this by using local data and skip fetching from server.
    // if (localData?.isNotEmpty == true && params.skipServerFetchIfFoundInLocal) {
    //   return Right(localData!);
    // }

    try {
      final serverData = await albumServerRepository.fetchImagesInAlbums(FetchImagesInAlbumRequest(
        albumId: params.albumId,
        page: params.page,
        pageSize: params.pageSize,
        beforeCreatedAt: params.beforeCreatedAt,
        afterCreatedAt: params.afterCreatedAt,
      ));
      final dataList = serverData?.data?.toList();
      if (dataList != null) {
        /// Save fetched data to local storage.
        await albumLocalRepository.putAllAlbumImages(dataList);
      }
      return serverData;
    } catch (e, stackTrace) {
      if (e is ApiException && e.type == 'ERR_ALBUM_NOT_FOUND') {
        rethrow;
      }
      _log.w('Failed to fetch images in album. Using data from local db.', e, stackTrace);
      final localResult = await albumLocalRepository.getImagesInAlbum(FetchImagesInAlbumRequest(
        albumId: params.albumId,
        page: params.page,
        pageSize: params.pageSize,
        beforeCreatedAt: params.beforeCreatedAt,
        afterCreatedAt: params.afterCreatedAt,
      ));

      return localResult;
    }
  }
}
