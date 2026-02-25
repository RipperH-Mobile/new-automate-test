import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';

class AlbumImageDb {
  Isar? customDbInstance;

  AlbumImageDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarCollection<AlbumImageCollection> get albumImageCollection {
    return dbInstance.albumImages;
  }

  Future<void> putAlbumImage(AlbumImageCollection image) async {
    await dbInstance.writeTxn(() async {
      await albumImageCollection.put(image);
    });
  }

  Future<void> putAllAlbumImage(List<AlbumImageCollection> images) async {
    await dbInstance.writeTxn(() async {
      await albumImageCollection.putAll(images);
    });
  }

  Future<List<AlbumImageCollection>> getImagesInAlbum(
    String albumId, {
    int page = 1,
    int pageSize = 50,
    DateTime? beforeCreatedAt,
    DateTime? afterCreatedAt,
  }) async {
    var query = albumImageCollection.where().albumIdEqualTo(albumId).filter().albumIdIsNotNull();

    if (beforeCreatedAt != null) {
      query = albumImageCollection.where().albumIdEqualTo(albumId).filter().createAtLessThan(beforeCreatedAt);
    }

    if (afterCreatedAt != null) {
      query = albumImageCollection.where().albumIdEqualTo(albumId).filter().createAtGreaterThan(afterCreatedAt);
    }

    return query.sortByCreateAtDesc().offset((page - 1) * pageSize).limit(pageSize).findAll();
  }

  Future<int> getImageCountInAlbum(String albumId) async {
    return albumImageCollection.where().albumIdEqualTo(albumId).count();
  }

  Future<void> deleteImages(List<String> imageIds) async {
    await dbInstance.writeTxn(() async {
      await albumImageCollection.filter().anyOf(imageIds, (q, element) => q.imageIdEqualTo(element)).deleteAll();
    });
  }

  Future<void> deleteImagesWithoutTxn(List<String> imageIds) async {
    await albumImageCollection.filter().anyOf(imageIds, (q, element) => q.imageIdEqualTo(element)).deleteAll();
  }
}
