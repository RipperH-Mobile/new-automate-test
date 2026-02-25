import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/album/data/models/requests/fetch_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/get_all_album_in_room_request.dart';
import 'package:uchat/features/album/data/models/requests/put_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';

abstract class AlbumLocalRepository {
  Future<PaginationPayload<AlbumEntity>> getAllAlbumInRoom(GetAllAlbumInRoomRequest request);

  Future<AlbumEntity?> getAlbum(String albumId);

  Future<void> putAlbum(PutAlbumRequest request);

  Future<void> putAllAlbum(List<AlbumEntity> albums);

  Future<PaginationPayload<AlbumImageEntity>> getImagesInAlbum(FetchImagesInAlbumRequest request);

  Future<void> putAlbumImage(AlbumImageEntity image);

  Future<void> putAllAlbumImages(List<AlbumImageEntity> images);

  Future<void> putAlbumTask(AlbumTaskEntity task);

  Future<List<AlbumTaskEntity>> getAlbumTasksInRoom(String roomId, {String? albumId});

  Future<void> deleteFailedAlbumTaskWithAlbumId(String albumId);

  Future<void> deleteAlbum(String albumId);
}
