import 'package:uchat/features/chat_room/data/models/requests/room_file_delete_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_get_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_put_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
abstract class RoomFileLocalRepository {
  Future<void> deleteAllFileInRoom(String roomId);

  Future<int> deleteAllFileWithMessageId(DeleteAllFileWithMessageIdRequest request);

  Future<void> putAllRoomFiles(PutAllRoomFilesRequest request);

  Future<List<RoomFileEntity>> getPhotosAndVideosByRoomId(GetPhotosAndVideosByRoomIdRequest request);

  Future<List<RoomFileEntity>> getFilesByRoomId({required String roomId});
}
