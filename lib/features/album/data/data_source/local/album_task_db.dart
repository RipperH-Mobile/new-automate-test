import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/album/data/models/collections/album_task_collection.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';

class AlbumTaskDb {
  Isar? customDbInstance;

  AlbumTaskDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarCollection<AlbumTaskCollection> get albumTaskCollection {
    return dbInstance.albumTasks;
  }

  Future<void> putAlbumTask(AlbumTaskCollection task) async {
    await dbInstance.writeTxn(() async {
      await albumTaskCollection.put(task);
    });
  }

  Future<List<AlbumTaskCollection>> getAlbumTasksInRoom(String roomId) async {
    return albumTaskCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .statusEqualTo(AlbumTaskStatus.inProgress)
        .or()
        .statusEqualTo(AlbumTaskStatus.failed)
        .findAll();
  }

  Future<List<AlbumTaskCollection>> getAlbumTasksInRoomWithAlbumId(String roomId, String albumId) async {
    return albumTaskCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .albumIdEqualTo(albumId)
        .group((q) => q.statusEqualTo(AlbumTaskStatus.inProgress).or().statusEqualTo(AlbumTaskStatus.failed))
        .findAll();
  }

  Future<void> deleteFailedAlbumTaskWithAlbumId(String albumId) async {
    await dbInstance.writeTxn(() async {
      await albumTaskCollection
          .where()
          .albumIdEqualTo(albumId)
          .filter()
          .statusEqualTo(AlbumTaskStatus.failed)
          .deleteAll();
    });
  }
}
