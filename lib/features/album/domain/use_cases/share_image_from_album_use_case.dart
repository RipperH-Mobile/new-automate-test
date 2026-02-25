import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/params/share_image_from_album_param.dart';
import 'package:uchat/features/album/data/models/requests/share_image_from_album_request.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ShareImageFromAlbumUseCase extends SimpleUseCase<void, ShareImageFromAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  @override
  Future<void> call(ShareImageFromAlbumParam params) async {
    await albumServerRepository.shareImageFromAlbum(ShareImageFromAlbumRequest(
      albumId: params.albumId,
      imageIds: params.imageIds,
      targetRoomIds: params.targetRoomIds,
    ));
  }
}
