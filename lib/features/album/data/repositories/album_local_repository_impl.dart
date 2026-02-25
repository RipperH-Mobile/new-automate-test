import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/data_source/local/album_image_db.dart';
import 'package:uchat/features/album/data/data_source/local/album_task_db.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';
import 'package:uchat/features/album/data/models/collections/album_task_collection.dart';
import 'package:uchat/features/album/data/models/requests/fetch_images_in_album_request.dart';
import 'package:uchat/features/album/data/models/requests/get_all_album_in_room_request.dart';
import 'package:uchat/features/album/data/models/requests/put_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';

class AlbumLocalRepositoryImpl implements AlbumLocalRepository {
  AlbumLocalRepositoryImpl({
    required this.albumDb,
    required this.albumImageDb,
    required this.albumTaskDb,
  });

  final AlbumDb albumDb;
  final AlbumImageDb albumImageDb;
  final AlbumTaskDb albumTaskDb;

  @override
  Future<PaginationPayload<AlbumEntity>> getAllAlbumInRoom(GetAllAlbumInRoomRequest request) async {
    final albums = await albumDb.getAllAlbumInRoom(
      roomId: request.roomId,
      page: request.page,
      pageSize: request.pageSize,
    );
    // final albumsEntity = albums.map((e) => e.toEntity()).toList();
    int total = await albumDb.getAlbumCountInRoom(roomId: request.roomId);
    return PaginationPayload<AlbumEntity>(
      data: albums.map((e) => e.toEntity()),
      total: total,
      page: request.page,
      pageSize: request.pageSize,
      totalPages: (total / request.pageSize).ceil(),
    );
  }

  @override
  Future<AlbumEntity?> getAlbum(String albumId) async {
    final result = await albumDb.getAlbum(id: albumId);
    return result?.toEntity();
  }

  @override
  Future<void> putAlbum(PutAlbumRequest request) async {
    await albumDb.putAlbum(AlbumCollection.fromEntity(request.album));
  }

  @override
  Future<void> putAllAlbum(List<AlbumEntity> albums) async {
    await albumDb.putAlbums(albums: albums.map((e) => AlbumCollection.fromEntity(e)).toList());
  }

  @override
  Future<PaginationPayload<AlbumImageEntity>> getImagesInAlbum(
    FetchImagesInAlbumRequest request,
  ) async {
    List<AlbumImageCollection> imageList = await albumImageDb.getImagesInAlbum(
      request.albumId,
      page: request.page,
      pageSize: request.pageSize,
      beforeCreatedAt: request.beforeCreatedAt,
      afterCreatedAt: request.afterCreatedAt,
    );
    int total = await albumImageDb.getImageCountInAlbum(request.albumId);
    return PaginationPayload<AlbumImageEntity>(
      data: imageList.map((e) => e.toEntity()),
      total: total,
      page: request.page,
      pageSize: request.pageSize,
      totalPages: (total / request.pageSize).ceil(),
    );
  }

  @override
  Future<void> putAlbumImage(AlbumImageEntity image) async {
    await albumImageDb.putAlbumImage(AlbumImageCollection.fromEntity(image));
  }

  @override
  Future<void> putAllAlbumImages(List<AlbumImageEntity> images) async {
    await albumImageDb.putAllAlbumImage(images.map((e) => AlbumImageCollection.fromEntity(e)).toList());
  }

  @override
  Future<void> putAlbumTask(AlbumTaskEntity task) async {
    await albumTaskDb.putAlbumTask(AlbumTaskCollection.fromEntity(task));
  }

  @override
  Future<List<AlbumTaskEntity>> getAlbumTasksInRoom(String roomId, {String? albumId}) async {
    if (albumId == null) {
      final result = await albumTaskDb.getAlbumTasksInRoom(roomId);
      return result.map((e) => e.toEntity()).toList();
    } else {
      final result = await albumTaskDb.getAlbumTasksInRoomWithAlbumId(roomId, albumId);
      return result.map((e) => e.toEntity()).toList();
    }
  }

  @override
  Future<void> deleteFailedAlbumTaskWithAlbumId(String albumId) async {
    await albumTaskDb.deleteFailedAlbumTaskWithAlbumId(albumId);
  }

  @override
  Future<void> deleteAlbum(String albumId) {
    return albumDb.deleteAlbum(id: albumId);
  }
}
