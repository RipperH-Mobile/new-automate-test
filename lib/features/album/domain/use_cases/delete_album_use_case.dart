import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/events/album_delete_event.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/requests/delete_album_request.dart';
import 'package:uchat/features/album/domain/params/delete_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteAlbumUseCase extends SimpleUseCase<void, DeleteAlbumParam> {
  final AlbumServerRepository albumServerRepository;
  final AlbumLocalRepository albumLocalRepository;

  DeleteAlbumUseCase({
    required this.albumServerRepository,
    required this.albumLocalRepository,
  });

  @override
  Future<void> call(DeleteAlbumParam params) async {
    await albumServerRepository.deleteAlbum(DeleteAlbumRequest(
      albumId: params.albumId,
      roomId: params.roomId,
    ));
    await albumLocalRepository.deleteAlbum(params.albumId);

    eventBus.fire(AlbumDeleteEvent(
      album: AlbumEntity(
        albumName: null,
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
