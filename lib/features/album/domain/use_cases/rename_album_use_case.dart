import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/requests/rename_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/events/album_update_event.dart';
import 'package:uchat/features/album/domain/params/rename_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RenameAlbumUseCase extends SimpleUseCase<void, RenameAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  @override
  Future<void> call(RenameAlbumParam params) async {
    await albumServerRepository.renameAlbum(
      RenameAlbumRequest(
        albumId: params.albumId,
        newAlbumName: params.newAlbumName,
      ),
    );
    eventBus.fire(AlbumUpdateEvent(
      album: AlbumEntity(
        albumName: params.newAlbumName,
        id: params.albumId,
        accountId: null,
        roomId: params.roomId,
        createdAt: null,
        updatedAt: null,
        createdBy: null,
        isSuccess: null,
      ),
      roomId: params.roomId,
    ));
  }
}
