import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

// final _log = useLogger();

typedef IsarRoomFileCollection = IsarCollection<RoomFileCollection>;
typedef RoomFileCollectionList = List<RoomFileCollection>;

class RoomFileDb {
  Isar? customDbInstance;

  RoomFileDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarRoomFileCollection get roomFileCollection {
    return dbInstance.roomFiles;
  }

  Future<void> putRoomFile(RoomFileCollection roomFile) async {
    await dbInstance.writeTxn(() async {
      await roomFileCollection.put(roomFile);
    });
  }

  Future<void> putRoomFileWithoutTxn(RoomFileCollection roomFile) async {
    await roomFileCollection.put(roomFile);
  }

  Future<void> putAllRoomFile(List<RoomFileCollection> roomFiles) async {
    await dbInstance.writeTxn(() async {
      await roomFileCollection.putAll(roomFiles);
    });
  }

  Future<void> putAllRoomFileWithoutTxn(List<RoomFileCollection> roomFiles) async {
    await roomFileCollection.putAll(roomFiles);
  }

  Future<RoomFileCollection?> getRoomFile(String id) async {
    return roomFileCollection.get(fastHash(id));
  }

  Future<int> deleteAllFileInRoom(String roomId) async {
    return await dbInstance.writeTxn(() async {
      return await roomFileCollection.where().roomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<int> deleteAllFileInRoomWithoutTxn(String roomId) async {
    return await roomFileCollection.where().roomIdEqualTo(roomId).deleteAll();
  }

  Future<int> deleteAllFileWithMessageId(String messageId) async {
    return await dbInstance.writeTxn(() async {
      return await deleteAllFileWithMessageIdWithoutTxn(messageId);
    });
  }

  Future<int> deleteAllFileWithMessageIdWithoutTxn(String messageId) async {
    return await roomFileCollection.where().messageIdEqualTo(messageId).deleteAll();
  }

  Future<bool> deleteRoomFile(String id) async {
    return await dbInstance.writeTxn(() async {
      return await roomFileCollection.delete(fastHash(id));
    });
  }

  Future<bool> deleteRoomFileWithoutTxn(String id) async {
    return await roomFileCollection.delete(fastHash(id));
  }

  Future<RoomFileCollectionList> getAllFileInRoom({
    required String roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return roomFileCollection
        .where()
        .isPhotosOrVideosRoomIdEqualTo(false, roomId)
        .sortByMessageSeqDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  Future<int> getFileCountInRoom({
    required String roomId,
  }) async {
    return roomFileCollection.where().isPhotosOrVideosRoomIdEqualTo(false, roomId).count();
  }

  Future<RoomFileCollectionList> getPhotosAndVideosInRoom({
    required String roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return roomFileCollection
        .where()
        .isPhotosOrVideosRoomIdEqualTo(true, roomId)
        .sortByMessageSeqDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  Future<int> getPhotoAndVideoCountInRoom({
    required String roomId,
  }) async {
    return roomFileCollection.where().isPhotosOrVideosRoomIdEqualTo(true, roomId).count();
  }

  Future<RoomFileCollectionList> getFilesInRoom(String roomId) async {
    return roomFileCollection.where().typeRoomIdEqualTo(RoomFileType.file, roomId).sortByMessageSeqDesc().findAll();
  }

  // Get Files in Account
  Future<RoomFileCollectionList> getFilesInAccount(String accountId) async {
    return roomFileCollection
        .where()
        .typeAccountIdEqualTo(RoomFileType.file, accountId)
        .filter()
        .isHiddenEqualTo(false)
        .or()
        .isHiddenIsNull()
        .sortByCreateAtDesc()
        .findAll();
  }

  // Stream to listen for changes in files for an account
  StreamSubscription<RoomFileCollectionList> watchFilesInAccount(
    String accountId,
    void Function(List<RoomFileCollection> event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return roomFileCollection
        .where()
        .typeAccountIdEqualTo(RoomFileType.file, accountId)
        .filter()
        .isHiddenEqualTo(false)
        .or()
        .isHiddenIsNull()
        .sortByCreateAtDesc()
        .watch()
        .listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }

  // Get Photos in Account
  Future<RoomFileCollectionList> getPhotosAndVideosInAccount(
    String accountId,
  ) async {
    return roomFileCollection
        .where()
        .isPhotosOrVideosAccountIdEqualTo(true, accountId)
        .filter()
        .isHiddenEqualTo(false)
        .or()
        .isHiddenIsNull()
        .sortByCreateAtDesc()
        .findAll();
  }

  // Stream to listen for changes in photos and videos for an account
  StreamSubscription<RoomFileCollectionList> watchPhotosAndVideosInAccount(
    String accountId,
    void Function(List<RoomFileCollection> event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return roomFileCollection
        .where()
        .isPhotosOrVideosAccountIdEqualTo(true, accountId)
        .filter()
        .isHiddenEqualTo(false)
        .or()
        .isHiddenIsNull()
        .sortByCreateAtDesc()
        .watch()
        .listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }

  // Fetch Videos in Account
  Future<RoomFileCollectionList> getVideosInAccount(String accountId) async {
    return roomFileCollection
        .where()
        .typeAccountIdEqualTo(RoomFileType.video, accountId)
        .sortByMessageSeqDesc()
        .findAll();
  }

  Future<RoomFileCollection?> getRoomFileCollectionOne(String roomId, String messageId) async {
    return roomFileCollection.where().roomIdEqualTo(roomId).filter().messageIdEqualTo(messageId).findFirst();
  }

  Future<void> clearCollection() async {
    await roomFileCollection.clear();
  }
}
