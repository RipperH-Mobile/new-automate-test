import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_delete_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_get_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_put_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';

class RoomFileLocalRepositoryImpl implements RoomFileLocalRepository {
  RoomFileDb get _roomFileDb {
    return GetIt.I<RoomFileDb>();
  }

  // TODO: Change Either to normal return
  @override
  Future<void> deleteAllFileInRoom(String roomId) async {
    try {
      await _roomFileDb.deleteAllFileInRoom(roomId);
      return;
    } catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<int> deleteAllFileWithMessageId(DeleteAllFileWithMessageIdRequest request) async {
    if (request.useTxn) {
      return await _roomFileDb.deleteAllFileWithMessageId(request.messageId);
    } else {
      return await _roomFileDb.deleteAllFileWithMessageIdWithoutTxn(request.messageId);
    }
  }

  @override
  Future<void> putAllRoomFiles(PutAllRoomFilesRequest request) async {
    final collection = request.files.map((e) => RoomFileCollection.fromEntity(e)).toList();
    if (request.useTxn) {
      return _roomFileDb.putAllRoomFile(collection);
    } else {
      return _roomFileDb.putAllRoomFileWithoutTxn(collection);
    }
  }

  @override
  Future<List<RoomFileEntity>> getFilesByRoomId({required String roomId}) async {
    final collection = await _roomFileDb.getFilesInRoom(roomId);
    return collection.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomFileEntity>> getPhotosAndVideosByRoomId(GetPhotosAndVideosByRoomIdRequest request) async {
    final collections = await _roomFileDb.getPhotosAndVideosInRoom(
      roomId: request.roomId,
      page: request.page,
      pageSize: request.pageSize,
    );
    return collections.map((e) => e.toEntity()).toList();
  }
}
