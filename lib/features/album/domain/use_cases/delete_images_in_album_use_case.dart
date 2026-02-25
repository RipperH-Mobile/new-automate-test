import 'package:get_it/get_it.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/delete_images_in_album_response.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/album/domain/params/delete_images_in_album_param.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteImagesInAlbumUseCase extends SimpleUseCase<DeleteImagesInAlbumResponse?, DeleteImagesInAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  @override
  Future<DeleteImagesInAlbumResponse?> call(DeleteImagesInAlbumParam params) async {
    return await albumServerRepository.deleteImagesInAlbum(
      DeleteImagesInAlbumRequest(
        albumId: params.albumId,
        imageIds: params.imageIds,
      ),
    );
  }
}
