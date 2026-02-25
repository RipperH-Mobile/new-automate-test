import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/requests/create_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/events/album_create_event.dart';
import 'package:uchat/features/album/domain/params/create_album_param.dart';
import 'package:uchat/features/album/domain/params/upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

class CreateAlbumUseCase extends SimpleUseCase<AlbumEntity?, CreateAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  @override
  Future<AlbumEntity?> call(CreateAlbumParam params) async {
    AlbumEntity? createdAlbum = await albumServerRepository.createAlbum(CreateAlbumRequest(
      albumName: params.albumName,
      roomId: params.roomId,
    ));
    if (createdAlbum != null) {
      createdAlbum = createdAlbum.copyWith(totalImages: params.selectedMediaAssets.length);
      eventBus.fire(
        AlbumCreateEvent(
          album: createdAlbum,
          roomId: createdAlbum.roomId!,
        ),
      );
      if (createdAlbum.id != null) {
        /// No await here because create album is done and we need to return CreateAlbumResponse for controller to use.
        /// Upload images result isn't needed right now.
        GetIt.I<UploadImageToAlbumUseCase>().call(UploadImageToAlbumParam(
          albumId: createdAlbum.id!,
          roomId: createdAlbum.roomId!,
          mediaAssets: params.selectedMediaAssets,
          imagePathList: params.selectedImagePathList,
        ));
      }
    }
    return createdAlbum;
  }
}
