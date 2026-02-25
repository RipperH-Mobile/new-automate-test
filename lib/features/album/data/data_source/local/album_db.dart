import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

typedef IsarAlbumCollection = IsarCollection<AlbumCollection>;
typedef AlbumCollectionList = List<AlbumCollection>;
typedef AlbumSubscription = StreamSubscription<AlbumCollection?>;

class AlbumDb {
  Isar? customDbInstance;

  AlbumDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarAlbumCollection get albumCollection {
    return dbInstance.albums;
  }

  Future<void> putAlbum(AlbumCollection album) async {
    await dbInstance.writeTxn(() async {
      await albumCollection.put(album);
    });
  }

  Future<AlbumCollection?> putAlbumWithoutTxn(AlbumCollection album) async {
    try {
      AlbumCollection? localAlbum = await getAlbum(id: album.id!);
      if (localAlbum != null) {
        // if update album
        localAlbum.update(album);
        await albumCollection.put(localAlbum);
        return localAlbum;
      } else {
        // if new album
        await albumCollection.put(album);
        return album;
      }
    } catch (e, stacktrace) {
      _log.e('putAlbumWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> putAlbums({required List<AlbumCollection> albums}) async {
    await dbInstance.writeTxn(() async {
      await albumCollection.putAll(albums);
    });
  }

  Future<AlbumCollection?> getAlbum({required String id}) async {
    return albumCollection.get(fastHash(id));
  }

  Future<AlbumCollectionList> getAllAlbumInRoom({
    required String roomId,
    int page = 1,
    int pageSize = 10,
  }) async {
    return albumCollection
        .where()
        .roomIdEqualTo(roomId)
        .sortByUpdatedAtDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  Future<int> getAlbumCountInRoom({
    required String roomId,
  }) async {
    return albumCollection.where().roomIdEqualTo(roomId).count();
  }

  Future<void> clearAllAlbumInRoom({required String roomId}) async {
    await dbInstance.writeTxn(() async {
      await albumCollection.where().roomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<bool> deleteAlbum({required String id}) async {
    return await dbInstance.writeTxn(() async {
      return albumCollection.delete(fastHash(id));
    });
  }

  Future<bool> deleteAlbumWithoutTxn({required String id}) async {
    return albumCollection.delete(fastHash(id));
  }
}
